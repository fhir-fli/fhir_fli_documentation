#!/usr/bin/env bash
# Reset one app to its committed state and convert it from fhir 0.12 to
# fhir_r4 0.14: pubspec, imports, fhir_migrate.py, fhir_migrate_rest.py,
# fhir_migrate.py again. Usage: convert_app.sh <app dir> <log dir>
set -euo pipefail
APP=$(cd "$1" && pwd); LOG=$2; T=$(cd "$(dirname "$0")" && pwd)
mkdir -p "$LOG"
cd "$APP"
git checkout -q -- . && git clean -qfd lib
python3 - <<'PY'
import re, subprocess
s = open('pubspec.yaml').read()
s = re.sub(r"(?m)^  fhir: [^\n]+\n", "  fhir_r4: ^0.14.1\n", s, count=1)
s = re.sub(r"(?m)^  fhir_at_rest: [^\n]+\n", "  fhir_r4_at_rest: ^0.15.0\n", s, count=1)
s = re.sub(r"(?m)^  # Also make sure 'fhir' stays[^\n]*\n  fhir: [^\n]+\n", "", s)
s = re.sub(r"(?m)^(dependency_overrides:(?:\n[^\n]*)*?)\n  fhir: [^\n]+", r"\1", s)
open('pubspec.yaml', 'w').write(s)
out = subprocess.run(['grep', '-rlE', "package:fhir(_at_rest)?/", 'lib', 'test'], capture_output=True, text=True).stdout.split()
for f in out:
    t = open(f).read()
    t = re.sub(r"import 'package:fhir/[a-z0-9_/]+\.dart'", "import 'package:fhir_r4/fhir_r4.dart'", t)
    t = re.sub(r"import 'package:fhir_at_rest/[a-z0-9_/]+\.dart'", "import 'package:fhir_r4_at_rest/fhir_r4_at_rest.dart'", t)
    open(f, 'w').write(t)
print(f"imports rewritten in {len(out)} files", flush=True)
PY
flutter pub get > "$LOG/pubget.log" 2>&1
python3 "$T/fhir_migrate.py" . "$LOG/pass1"
python3 "$T/fhir_migrate_rest.py" .
python3 "$T/fhir_migrate_dynamic.py" .
python3 "$T/fhir_migrate.py" . "$LOG/pass2"
python3 "$T/strict_casts.py" . on
python3 "$T/fhir_migrate.py" . "$LOG/pass3-strict"
python3 "$T/strict_casts.py" . off
python3 "$T/fhir_migrate.py" . "$LOG/pass4"
