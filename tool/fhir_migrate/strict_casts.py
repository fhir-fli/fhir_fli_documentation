#!/usr/bin/env python3
"""Turn strict-casts on (on) or restore the original (off) in a project's
analysis_options.yaml, so a dynamic value passed into a FHIR field shows up
as an error for fhir_migrate.py. Usage: strict_casts.py <dir> on|off"""
import sys
from pathlib import Path
d = Path(sys.argv[1]); f = d / "analysis_options.yaml"; bak = d / ".analysis_options.yaml.fhir_migrate"
if sys.argv[2] == "on":
    text = f.read_text() if f.exists() else ""
    bak.write_text(text if f.exists() else "\0absent")
    lines = text.splitlines()
    if any(l.startswith("analyzer:") for l in lines):
        i = next(i for i, l in enumerate(lines) if l.startswith("analyzer:"))
        lines.insert(i + 1, "  language:\n    strict-casts: true")
        text = "\n".join(lines) + "\n"
    else:
        text += "\nanalyzer:\n  language:\n    strict-casts: true\n"
    f.write_text(text)
else:
    old = bak.read_text()
    if old == "\0absent":
        f.unlink()
    else:
        f.write_text(old)
    bak.unlink()
