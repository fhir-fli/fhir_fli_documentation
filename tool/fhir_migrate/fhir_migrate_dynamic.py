#!/usr/bin/env python3
"""Names the analyzer cannot see: reads through `dynamic` receivers.

`for (var data in list)` over a List<dynamic>, then `data.resource.fhirId`,
compiles against any package and fails only when run (NoSuchMethodError).
fhir_r4 has no `fhirId` member at all, so every remaining `.fhirId` is one
of these; it becomes `.id`. An Attachment's `url.value` (a Uri in fhir 0.12)
is `url.valueUri`. Anything else read through dynamic is listed, not changed.
Usage: fhir_migrate_dynamic.py <project dir>
"""
import re
import sys
from pathlib import Path

root = Path(sys.argv[1]).resolve()
n_id = n_url = 0
for f in sorted(root.glob("lib/**/*.dart")):
    t = f.read_text()
    new, a = re.subn(r"\.fhirId\b", ".id", t)
    new, b = re.subn(r"\.url\.value\b", ".url.valueUri", new)
    if new != t:
        f.write_text(new)
        n_id += a
        n_url += b
print(f"dynamic reads: .fhirId -> .id {n_id}, .url.value -> .url.valueUri {n_url}", flush=True)
