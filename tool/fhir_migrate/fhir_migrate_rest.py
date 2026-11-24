#!/usr/bin/env python3
"""Rewrite fhir_at_rest 0.12 requests to fhir_r4_at_rest 0.15.

Old:  final r = FhirRequest.search(base: b, type: R4ResourceType.Patient,
                                   parameters: ['name=x'], client: c);
      final Resource res = await r.request(headers: h);
New:  final r = FhirSearchRequest(base: b, resourceType: 'Patient',
                                 search: restfulParameters(['name=x']),
                                 client: c, headers: h);
      final Resource res = await sendForResource(r);

Old request() never threw: any failure came back as an OperationOutcome
(fhir_at_rest 0.12.0 lib/r4/fhir_request.dart, _request). sendForResource
keeps that, so code that checks `response is OperationOutcome` still works.
Usage: fhir_migrate_rest.py <project dir>
"""
import re
import sys
from pathlib import Path

PROJECT = Path(sys.argv[1]).resolve()
KIND = {"search": "FhirSearchRequest", "create": "FhirCreateRequest",
        "update": "FhirUpdateRequest", "read": "FhirReadRequest",
        "delete": "FhirDeleteRequest"}
HELPER = '''import 'dart:convert';

import 'package:fhir_r4/fhir_r4.dart';
import 'package:fhir_r4_at_rest/fhir_r4_at_rest.dart';

/// `['name=Smith', '_id=1']` as the request builders take them.
RestfulParameters restfulParameters(List<String> parameters) {
  final out = RestfulParameters();
  for (final p in parameters) {
    final i = p.indexOf('=');
    if (i > 0) out.add(p.substring(0, i), p.substring(i + 1));
  }
  return out;
}

/// What fhir_at_rest 0.12's `request()` returned: the answer as a Resource
/// (a search gives its Bundle), or an OperationOutcome on any failure.
Future<Resource> sendForResource(FhirRequest request) async {
  try {
    final response = await request.sendRequest();
    final body = response.body;
    if (body.isEmpty) {
      return OperationOutcome(issue: [
        OperationOutcomeIssue(
          severity: IssueSeverity.information,
          code: IssueType.informational,
          diagnostics: 'HTTP ${response.statusCode}, no body'.toFhirString,
        ),
      ]);
    }
    return Resource.fromJson(jsonDecode(body) as Map<String, dynamic>);
  } catch (e) {
    return OperationOutcome(issue: [
      OperationOutcomeIssue(
        severity: IssueSeverity.error,
        code: IssueType.exception,
        diagnostics: '$e'.toFhirString,
      ),
    ]);
  }
}
'''


def matching(text, i):
    """Index just past the bracket that closes text[i]."""
    depth, q = 0, None
    j = i
    while j < len(text):
        ch = text[j]
        if q:
            if ch == "\\":
                j += 2
                continue
            if ch == q:
                q = None
        elif ch in "'\"":
            q = ch
        elif ch in "([{":
            depth += 1
        elif ch in ")]}":
            depth -= 1
            if depth == 0:
                return j + 1
        j += 1
    raise ValueError("unbalanced")


def strip_comments(src):
    """Drop // comments that are outside string literals."""
    out, q, i = [], None, 0
    while i < len(src):
        ch = src[i]
        if q:
            out.append(ch)
            if ch == "\\" and i + 1 < len(src):
                out.append(src[i + 1])
                i += 2
                continue
            if ch == q:
                q = None
        elif ch in "'\"":
            q = ch
            out.append(ch)
        elif src.startswith("//", i):
            while i < len(src) and src[i] != "\n":
                i += 1
            continue
        else:
            out.append(ch)
        i += 1
    return "".join(out)


def split_args(inner):
    inner = strip_comments(inner)
    out, depth, q, cur = [], 0, None, ""
    for ch in inner:
        if q:
            cur += ch
            if ch == q:
                q = None
            continue
        if ch in "'\"":
            q = ch
        elif ch in "([{":
            depth += 1
        elif ch in ")]}":
            depth -= 1
        if ch == "," and depth == 0:
            out.append(cur)
            cur = ""
        else:
            cur += ch
    if cur.strip():
        out.append(cur)
    return [a.strip() for a in out if a.strip()]


def convert(text):
    pending = {}
    n = 0
    pos = 0
    while True:
        m = re.compile(r"FhirRequest\.(search|create|update|read|delete)\(").search(text, pos)
        if not m:
            return text, n
        open_i = m.end() - 1
        close_i = matching(text, open_i)
        args = split_args(text[open_i + 1:close_i - 1])
        new = []
        for a in args:
            k, _, v = a.partition(":")
            k, v = k.strip(), v.strip()
            if k == "fhirId":
                new.append(f"id: {v}")
            elif k == "type":
                new.append(f"resourceType: {v}.toString()")
            elif k == "resource":
                new.append(f"resource: {v}.toJson()")
            elif k == "pretty":
                if v == "true":
                    new.append("parameters: RestfulParameters().requestPretty()")
            elif k == "parameters":
                new.append(f"search: restfulParameters({v})")
            else:
                new.append(f"{k}: {v}")
        keys = {a.partition(":")[0].strip() for a in args}
        if "type" not in keys and "resource" in keys:
            res = next(a.partition(":")[2].strip() for a in args if a.partition(":")[0].strip() == "resource")
            new.insert(1, f"resourceType: {res}.resourceType.toString()")
        # Headers moved from request(headers:) to the constructor.
        var = re.search(r"(\w+)\s*=\s*$", text[max(0, m.start() - 80):m.start()])
        if var:
            name = var.group(1)
            call = None  # the next send that is code, not a commented-out line
            # Only within this method: stop at the next member declaration.
            nxt = re.compile(r"\n  (?:static\s+)?[A-Za-z_][\w<>?, ]*\s+\w+\([^;{]*\)\s*(?:async\s*)?\{").search(text, close_i)
            bound = nxt.start() if nxt else len(text)
            for c in re.compile(rf"\b{name}\.request\(").finditer(text, close_i, bound):
                if "//" not in text[text.rfind("\n", 0, c.start()) + 1:c.start()]:
                    call = c
                    break
            if not call and name in pending:
                # Second branch of an if/else assigning the same request.
                new.extend(pending.pop(name))
            if call:
                c_close = matching(text, call.end() - 1)
                call_args = split_args(text[call.end():c_close - 1])
                for a in call_args:
                    k, _, v = a.partition(":")
                    if k.strip() == "headers":
                        new.append(f"headers: {v.strip()}")
                pending[name] = [x for x in new if x.startswith("headers:")]
                text = text[:call.start()] + f"sendForResource({name})" + text[c_close:]
                head = text[text.rfind("\n", 0, m.start()) + 1:m.start()].strip()
                declared = re.match(r"(?:final|var|[A-Z]\w*[\w<>?]*)\s+\w+\s*=$", head)
                if not declared:
                    # Headers now go in the constructor, which comes before
                    # any local the headers read (`var token = ...;` between
                    # the if/else and the send). Hoist such one-line locals
                    # to just after `var <name>;`.
                    hdr = " ".join(x for x in new if x.startswith("headers:"))
                    vdecl = None  # the nearest `var <name>;` above, not the file's first
                    for vdecl in re.compile(rf"(?m)^[ \t]*(?:var|final|[A-Z]\w*\??)\s+{name}\s*;[ \t]*\n").finditer(text, 0, m.start()):
                        pass
                    if vdecl:
                        for ident in set(re.findall(r"\b([a-z]\w*)\b", hdr)):
                            dm = re.compile(rf"(?m)^[ \t]*(?:var|final|String\??)\s+{ident}\s*=[^;\n]*;[ \t]*\n").search(text, close_i)
                            if dm and dm.start() < text.index(f"sendForResource({name})", close_i):
                                line = text[dm.start():dm.end()]
                                text = text[:dm.start()] + text[dm.end():]
                                ind = re.match(r"[ \t]*", text[vdecl.start():]).group(0)
                                text = text[:vdecl.end()] + ind + line.lstrip() + text[vdecl.end():]
                                shift = len(ind + line.lstrip())
                                m = re.compile(r"FhirRequest\.(search|create|update|read|delete)\(").search(text, m.start() + shift - 1 if m.start() > vdecl.end() else m.start())
                                open_i = m.end() - 1
                                close_i = matching(text, open_i)
                    # `request = cond ? ... : ...` or an if/else pair:
                    # build in place; a header variable declared later is
                    # left for a person (the analyzer names it).
                    indent = re.match(r"[ \t]*", text[text.rfind("\n", 0, m.start()) + 1:]).group(0)
                    repl = f"{KIND[m.group(1)]}(\n" + "".join(f"{indent}  {a},\n" for a in new) + f"{indent})"
                    text = text[:m.start()] + repl + text[close_i:]
                    pos = m.start() + len(repl)
                    n += 1
                    continue
                # The headers may name a variable declared after the old
                # constructor (`final token = ...`), so the request is now
                # built on the line before it is sent.
                stmt_start = text.rfind("\n", 0, m.start()) + 1
                semi = text.index(";", close_i) + 1
                eol = semi + 1 if text[semi:semi + 1] == "\n" else semi
                decl_head = text[stmt_start:m.start()]
                send_at = text.index(f"sendForResource({name})", semi)
                line_start = text.rfind("\n", 0, send_at) + 1
                indent = re.match(r"[ \t]*", text[line_start:]).group(0)
                repl = f"{KIND[m.group(1)]}(\n" + "".join(f"{indent}  {a},\n" for a in new) + f"{indent})"
                decl = f"{indent}{decl_head.strip()} {repl};\n"
                text = text[:line_start] + decl + text[line_start:]
                text = text[:stmt_start] + text[eol:]
                pos = stmt_start
                n += 1
                continue
        indent = re.match(r"[ \t]*", text[text.rfind("\n", 0, m.start()) + 1:]).group(0)
        repl = f"{KIND[m.group(1)]}(\n" + "".join(f"{indent}  {a},\n" for a in new) + f"{indent})"
        text = text[:m.start()] + repl + text[close_i:]
        pos = m.start() + len(repl)
        n += 1


def main():
    total = 0
    for f in sorted(PROJECT.glob("lib/**/*.dart")):
        t = f.read_text()
        if "FhirRequest." not in t:
            continue
        new, n = convert(t)
        new = new.replace("ResourceUtils.resourceTypeFromStringMap[", "R4ResourceType.fromString(")
        new = re.sub(r"R4ResourceType\.fromString\(([^\]]+)\]", r"R4ResourceType.fromString(\1)", new)
        if n:
            rel = Path("/".join([".."] * (len(f.relative_to(PROJECT / "lib").parts) - 1)) or ".")
            imp = f"import '{(rel / 'fhir_rest_compat.dart').as_posix().lstrip('./') if rel.as_posix() != '.' else 'fhir_rest_compat.dart'}';\n"
            if str(rel) != ".":
                imp = f"import '{rel.as_posix()}/fhir_rest_compat.dart';\n"
            new = imp + new
        if new != t:
            f.write_text(new)
            total += n
            print(f"{f.relative_to(PROJECT)}: {n}", flush=True)
    if total:
        (PROJECT / "lib" / "fhir_rest_compat.dart").write_text(HELPER)
    print(f"total {total}", flush=True)


main()
