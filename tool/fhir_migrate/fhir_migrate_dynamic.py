#!/usr/bin/env python3
"""Names the analyzer cannot see: reads through `dynamic` receivers.

`for (var data in list)` over a List<dynamic>, then `data.resource.fhirId`,
compiles against any package and fails only when run (NoSuchMethodError).
After the typed errors are fixed, whatever old name is left is one of these.
  .fhirId                -> .id            (fhir_r4 has no fhirId member)
  .<field>.value         -> .<field>.<getter>, for each field whose fhir_r4
                            types all read back one way (field_prims.txt,
                            e.g. valueMarkdown -> valueString; fhir_auth's
                            FhirClient.fhirUri -> valueUri)
  .url.value.toString()  -> .url.valueString.toString()  (url is FhirUri,
                            FhirUrl or FhirString depending on the type;
                            all three have valueString)
Anything else read through dynamic is listed for a person, not changed.
Usage: fhir_migrate_dynamic.py <project dir>
"""
import re
import sys
from pathlib import Path

root = Path(sys.argv[1]).resolve()
fields = dict(l.split()[:2] for l in Path(__file__).with_name("field_prims.txt").read_text().splitlines()
              if l and not l.startswith("#"))
field_re = re.compile(r"\.(" + "|".join(map(re.escape, sorted(fields, key=len, reverse=True))) + r")(\??)\.value\b")
counts = {"fhirId": 0, "field.value": 0, "url.value": 0}
left = []
for f in sorted(root.glob("lib/**/*.dart")):
    t = f.read_text()
    new, a = re.subn(r"\.fhirId\b", ".id", t)
    new, b = field_re.subn(lambda m: f".{m.group(1)}{m.group(2)}.{fields[m.group(1)]}", new)
    new, c = re.subn(r"\.url(\??)\.value(\??)\.toString\(\)", r".url\1.valueString\2.toString()", new)
    for m in re.finditer(r"(?m)^.*\.url\??\.value\b.*$", new):
        left.append(f"{f.relative_to(root)}: {m.group(0).strip()[:100]}")
    if new != t:
        f.write_text(new)
    counts["fhirId"] += a
    counts["field.value"] += b
    counts["url.value"] += c
print("dynamic reads:", ", ".join(f"{k} {v}" for k, v in counts.items()), flush=True)
for l in left:
    print("left for a person (url.value):", l, flush=True)
