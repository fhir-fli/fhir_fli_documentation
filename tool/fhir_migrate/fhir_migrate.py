#!/usr/bin/env python3
"""Move a Dart project from `fhir` 0.12 to `fhir_r4` 0.14 by repeating:
run `dart analyze --format=machine`, fix each error whose shape is known,
until a round changes nothing. What is left is printed for a person.

Every rule here is one of the changes found converting real apps
(Bahmni Connect2, HL7 Physical Activity RI, 2026-11-24). Usage:
  fhir_migrate.py <project dir> <log dir>
"""
import re
import subprocess
import sys
from pathlib import Path

PROJECT = Path(sys.argv[1]).resolve()
LOG = Path(sys.argv[2]).resolve()
LOG.mkdir(parents=True, exist_ok=True)

DART_SOURCES = {"String", "int", "double", "num", "DateTime", "Uri", "bool", "BigInt"}
# fhir_r4 primitive -> its `.toFhirX` extension getter (from fhir_r4 0.14.1
# lib/src/primitive_types). FhirDate etc. take String or DateTime.
PRIMS = {"FhirString", "FhirCode", "FhirCanonical", "FhirOid", "FhirBoolean",
         "FhirMarkdown", "FhirInteger", "FhirDate", "FhirInstant",
         "FhirInteger64", "FhirBase64Binary", "FhirPositiveInt", "FhirUrl",
         "FhirXhtml", "FhirUuid", "FhirDecimal", "FhirDateTime", "FhirUri",
         "FhirId", "FhirUnsignedInt", "FhirTime"}
# Old `.value` -> new getter, by the receiver's type.
VALUE_GETTER = {"FhirUri": "valueUri", "FhirUrl": "valueUri",
                "FhirCanonical": "valueUri", "FhirDecimal": "valueDouble",
                "FhirInteger": "valueInt", "FhirPositiveInt": "valueInt",
                "FhirUnsignedInt": "valueInt", "FhirBoolean": "valueBoolean",
                "FhirDate": "valueDateTime", "FhirDateTime": "valueDateTime",
                "FhirInstant": "valueDateTime"}
# Old Dart enums whose field now has a differently named code type; built by
# comparing each field's type in fhir 0.12.1 and fhir_r4 0.14.1
# (tool/enum_renames.txt). TimingRepeat{Duration,Period}Unit both became
# UnitsOfTime.
ENUM_RENAMES = dict(
    line.split()[:2] for line in (Path(__file__).with_name("enum_renames.txt")).read_text().splitlines()
    if line and not line.startswith("#"))
# Every fhir_r4 class that extends FhirCodeEnum (AdministrativeGender,
# BundleType, ObservationStatus, ...): their old `.value` is `.valueString`.
CODE_ENUMS = set(Path(__file__).with_name("code_enums.txt").read_text().split())
# What a JSON value for each primitive decodes to. Dates are left out: the
# value may be a String or a DateTime, so a person decides.
DYNAMIC_AS = {**{p: "String" for p in ("FhirString", "FhirCode", "FhirCanonical",
              "FhirOid", "FhirMarkdown", "FhirBase64Binary", "FhirUrl",
              "FhirXhtml", "FhirUuid", "FhirUri", "FhirId", "FhirTime")},
              **{p: "num" for p in ("FhirInteger", "FhirInteger64", "FhirDecimal",
                 "FhirPositiveInt", "FhirUnsignedInt")},
              "FhirBoolean": "bool"}
READ_BACK = {"String": "valueString", "int": "valueInt", "double": "valueDouble",
             "bool": "valueBoolean", "DateTime": "valueDateTime", "Uri": "valueUri"}
SIMPLE = re.compile(r"""^(?:[A-Za-z_$][\w$]*|'[^']*'|"[^"]*"|\)|\]|\.|\?\.|!|\s)*$""")


def simple(expr: str) -> bool:
    """A literal or a postfix chain: safe to append `.x` without parens."""
    depth = 0
    for i, ch in enumerate(expr):
        if ch in "([{":
            depth += 1
        elif ch in ")]}":
            depth -= 1
        elif depth == 0 and ch in " ?:+-*/<>=&|" and not expr[i:i + 2] == "?.":
            if ch == "?" and expr[i:i + 2] == "?.":
                continue
            if ch in " " and expr.startswith(("'", '"')):
                continue
            return False
    return True


def split_top(expr, op):
    parts, depth, q, cur, i = [], 0, None, "", 0
    while i < len(expr):
        ch = expr[i]
        if q:
            cur += ch
            if ch == q:
                q = None
        elif ch in "'\"":
            q = ch
            cur += ch
        elif ch in "([{":
            depth += 1
            cur += ch
        elif ch in ")]}":
            depth -= 1
            cur += ch
        elif depth == 0 and expr.startswith(op, i):
            parts.append(cur)
            cur = ""
            i += len(op)
            continue
        else:
            cur += ch
        i += 1
    parts.append(cur)
    return [p.strip() for p in parts]


def coalesce_to_string(expr):
    parts = split_top(expr, "??")
    if len(parts) < 2:
        return None
    out = []
    for p in parts:
        if re.fullmatch(r"'[^']*'|\"[^\"]*\"", p) or p.endswith("valueString"):
            out.append(p)
        elif p.startswith("(") and p.endswith(")") and "??" in p:
            inner = coalesce_to_string(p[1:-1])
            out.append(f"({inner or p[1:-1]})")
        else:
            base = p if simple(p) else f"({p})"
            out.append(f"{base}?.valueString")
    return " ?? ".join(out)


def suffix(expr, nullable, member):
    base = expr if simple(expr) else f"({expr})"
    return f"{base}{'?.' if nullable else '.'}{member}"


def analyze(round_no):
    out = subprocess.run(["dart", "analyze", "--format=machine"], cwd=PROJECT,
                         capture_output=True, text=True)
    (LOG / f"round{round_no:02d}.txt").write_text(out.stdout + out.stderr)
    errs = []
    for line in (out.stdout + out.stderr).splitlines():
        p = line.split("|", 7)
        if len(p) == 8 and p[0] == "ERROR":
            errs.append({"code": p[2], "file": p[3], "line": int(p[4]),
                         "col": int(p[5]), "len": int(p[6]), "msg": p[7]})
    return errs


def offset(text, line, col):
    starts = [0]
    for m in re.finditer("\n", text):
        starts.append(m.end())
    return starts[line - 1] + col - 1


def fix(err, text):
    """Return (start, end, replacement) or None."""
    start = offset(text, err["line"], err["col"])
    end = start + err["len"]
    expr = text[start:end]
    code, msg = err["code"], err["msg"]

    m = re.search(r"type '([^']+)' can't be (?:assigned|returned).*?type '([^']+)'", msg) \
        or re.search(r"value of type '([^']+)' can't be (?:assigned|returned).*?type (?:of )?'([^']+)'", msg) \
        or re.search(r"element type '([^']+)' can't be assigned to the list type '([^']+)'", msg)
    if code in ("ARGUMENT_TYPE_NOT_ASSIGNABLE", "INVALID_ASSIGNMENT",
                "RETURN_OF_INVALID_TYPE", "LIST_ELEMENT_TYPE_NOT_ASSIGNABLE",
                "RETURN_OF_INVALID_TYPE_FROM_CLOSURE") and m:
        src, dst = m.group(1), m.group(2)
        nullable = src.endswith("?")
        s, d = src.rstrip("?"), dst.rstrip("?")
        if s == "Object" and d.rstrip("?") == "String":
            # `name.family ?? ''` mixes FhirString and String; read each
            # FHIR operand of the ?? chain back as a String.
            fixed = coalesce_to_string(expr)
            return (start, end, fixed) if fixed and fixed != expr else None
        lw = re.fullmatch(r"List<String\?>", s)
        if lw and d == "List<String>":
            base = expr if simple(expr) else f"({expr})"
            return start, end, f"{base}{'?.' if nullable else '.'}whereType<String>().toList()"
        if s == "dynamic" and d in PRIMS:
            # A decoded-JSON value passed straight in. It compiled against
            # fhir 0.12 and against fhir_r4, and fails only when run
            # ("String is not a subtype of FhirString?"). Seen with
            # strict-casts on (convert_app.sh turns it on for this pass).
            src_type = DYNAMIC_AS.get(d)
            if src_type and dst.endswith("?"):
                return start, end, f"({expr} as {src_type}?)?.to{d}"
            if src_type:  # a list element or a required field: not null
                return start, end, f"({expr} as {src_type}).to{d}"
            return None
        if s in DART_SOURCES and d in PRIMS:
            return start, end, suffix(expr, nullable, f"to{d}")
        lm = re.fullmatch(r"List<(\w+)\??>", s)
        ld = re.fullmatch(r"List<(\w+)\??>", d)
        if lm and ld and lm.group(1) in DART_SOURCES and ld.group(1) in PRIMS:
            q = "?." if nullable else "."
            base = expr if simple(expr) else f"({expr})"
            return start, end, f"{base}{q}map((e) => e.to{ld.group(1)}).toList()"
        if s in PRIMS and d in READ_BACK:
            return start, end, suffix(expr, nullable, READ_BACK[d])
        if lm and ld and lm.group(1) in PRIMS and ld.group(1) in READ_BACK:
            q = "?." if nullable else "."
            base = expr if simple(expr) else f"({expr})"
            return start, end, f"{base}{q}map((e) => e.{READ_BACK[ld.group(1)]}).whereType<{ld.group(1)}>().toList()"
        # A general code where the field is now its own code type.
        if s == "FhirCode" and d not in PRIMS and re.fullmatch(r"[A-Z]\w+", d):
            if expr.startswith("FhirCode("):
                return start, start + len("FhirCode"), d
            if expr.startswith("FhirCode.asConst("):
                return start, start + len("FhirCode.asConst"), d
            return start, end, f"{d}({suffix(expr, nullable, 'valueString')})"
        # A primitive of one kind where the field takes another (Extension.url).
        if s in PRIMS and d in PRIMS:
            if expr.startswith(s + "("):
                return start, start + len(s), d
            if not nullable:
                return start, end, f"{d}({suffix(expr, False, 'valueString')})"
        return None

    if code == "UNDEFINED_NAMED_PARAMETER":
        name = re.search(r"parameter '(\w+)'", msg).group(1)
        if name == "fhirId":
            return start, end, "id"
        if name == "resourceType":
            # Drop `resourceType: X,` entirely; the class knows its type.
            mm = re.compile(r"resourceType\s*:\s*[\w.]+\s*,?\s*").match(text, start)
            if mm:
                return start, mm.end(), ""
        if re.fullmatch(r"value[A-Z]\w*", name):
            return start, end, "valueX"
        return None

    if code == "UNDEFINED_METHOD" and re.search(r"method 'asConst' isn't defined for the type 'FhirCode'", msg):
        # FhirCode.asConst(x) -> FhirCode(x); the span is `asConst`.
        if text[start - 1] == ".":
            return start - 1, end, ""
        return None

    if code == "UNDEFINED_GETTER":
        gm = re.search(r"getter '(\w+)' isn't defined for the type '(\w+)'", msg)
        if gm:
            name, typ = gm.groups()
            if name == "fhirId":
                return start, end, "id"
            if name == "value" and typ in VALUE_GETTER:
                return start, end, VALUE_GETTER[typ]
            if name == "value" and (typ in PRIMS or typ in CODE_ENUMS):
                return start, end, "valueString"
        return None

    if code in ("UNDEFINED_IDENTIFIER", "UNDEFINED_CLASS"):
        nm = re.search(r"Undefined (?:name|class) '(\w+)'", msg)
        if nm and nm.group(1) in ENUM_RENAMES:
            return start, end, ENUM_RENAMES[nm.group(1)]
        return None

    if code == "UNDEFINED_ENUM_CONSTANT" or (code == "UNDEFINED_GETTER" and re.search(r"for the type '(\w+)'", msg)
                                              and re.search(r"for the type '(\w+)'", msg).group(1) in set(ENUM_RENAMES.values())):
        gm = re.search(r"'(\w+)'", msg)
        if gm:
            old = gm.group(1)
            # fhir_r4 code constants are lowerCamel, with `_` after a Dart keyword.
            cand = old[0].lower() + old[1:]
            if cand != old:
                return start, end, cand
        return None

    if code == "NEW_WITH_UNDEFINED_CONSTRUCTOR_DEFAULT":
        cm = re.search(r"class '(\w+)'", msg)
        if cm and cm.group(1) in ("FhirDateTime", "FhirDate", "FhirInstant"):
            # The error span is the class name; give it a named constructor.
            # A String argument is fixed in the next round (.fromString).
            return end, end, ".fromDateTime"
        return None
    return None


def string_into_from_datetime(err, text):
    """`FhirDateTime.fromDateTime('2020-…')` -> `.fromString`."""
    if err["code"] != "ARGUMENT_TYPE_NOT_ASSIGNABLE":
        return None
    if not re.search(r"type 'String\??' can't be assigned to the parameter type 'DateTime\??'", err["msg"]):
        return None
    start = offset(text, err["line"], err["col"])
    head = text[max(0, start - 40):start]
    mm = re.search(r"\.fromDateTime\(\s*$", head)
    if not mm:
        return None
    s = start - (len(head) - mm.start())
    return s, s + len(".fromDateTime"), ".fromString"


def nullable_into_from_datetime(err, text):
    """`FhirDateTime.fromDateTime(maybeNull)` -> `maybeNull?.toFhirDateTime`.

    The old `FhirDateTime(null)` did not fail: fhir 0.12.1's
    FhirDateTimeBase.parse set the value to DateTime.now() and marked it
    invalid. Writing `?.toFhirDateTime` leaves the field empty instead,
    which is what a missing date means. The guide says so."""
    if err["code"] != "ARGUMENT_TYPE_NOT_ASSIGNABLE":
        return None
    if not re.search(r"type 'DateTime\?' can't be assigned to the parameter type 'DateTime'", err["msg"]):
        return None
    start = offset(text, err["line"], err["col"])
    end = start + err["len"]
    head = text[max(0, start - 60):start]
    mm = re.search(r"(Fhir(?:DateTime|Date|Instant))\.fromDateTime\(\s*$", head)
    tail = re.match(r"\s*,?\s*\)", text[end:])
    if not mm or not tail:
        return None
    s = start - (len(head) - mm.start())
    close = end + tail.end()
    expr = text[start:end]
    base = expr if simple(expr) else f"({expr})"
    return s, close, f"{base}?.to{mm.group(1)}"


def main():
    for rnd in range(1, 40):
        errs = analyze(rnd)
        edits = {}
        unfixed = []
        for e in errs:
            text = edits.setdefault(e["file"], {"text": Path(e["file"]).read_text(), "spans": []})["text"]
            r = string_into_from_datetime(e, text) or nullable_into_from_datetime(e, text) or fix(e, text)
            if r:
                edits[e["file"]]["spans"].append(r)
            else:
                unfixed.append(e)
        changed = 0
        for f, d in edits.items():
            spans = sorted(set(d["spans"]), key=lambda s: (s[0], s[1]), reverse=True)
            text = d["text"]
            last = len(text) + 1
            for s, e, rep in spans:
                if e > last:  # overlaps a later edit this round; next round
                    continue
                text = text[:s] + rep + text[e:]
                last = s
                changed += 1
            if text != d["text"]:
                Path(f).write_text(text)
        print(f"round {rnd}: {len(errs)} errors, {changed} edits", flush=True)
        if changed == 0:
            with open(LOG / "unfixed.txt", "w") as fh:
                for e in unfixed:
                    fh.write(f"{e['file']}:{e['line']}:{e['col']} {e['code']} {e['msg']}\n")
            print(f"left for a person: {len(unfixed)}", flush=True)
            return


main()
