# fhir 0.12 -> fhir_r4 0.14 conversion: test runs

Run 2026-11-24 with `convert_app.sh <app> <logdir>` on local clones (nothing
pushed to the projects). Flutter 3.47.0, fhir_r4 0.14.1, fhir_r4_at_rest 0.15.0.

| App (fhir version before) | Errors after switching | Left after the tool | Reads through `dynamic` fixed | Tests |
|---|---|---|---|---|
| Bahmni/connect2Bahmni @63fbaa4 (fhir 0.12.1) | 51 | 6 (4 Bundle needs a type, 1 ternary, 1 `const`) | 10 JSON values | before 31 pass / 1 skip / 1 fail; after 30 / 1 / 2 |
| FHIR/physical-activity-ri patientApp (fhir 0.12.0, fhir_at_rest 0.12.0) | 1,281 | 0 | 77 `.fhirId`, 3 `.url.value`, 12 JSON values | no tests in the app |
| FHIR/physical-activity-ri providerApp (fhir 0.12.0, fhir_at_rest 0.12.0) | 1,245 | 14, all present before the switch (a missing file in the repo) | 125 `.fhirId`, 3 `.url.value`, 12 JSON values | no tests in the app |

Bahmni's two failures after: `bahmni_appointment_test` fails before and after
(it expects India time; passes under TZ=Asia/Kolkata), and
`providers_test` compares `'superman'` with a FhirString through
`expect`, which the analyzer cannot see (`'a' == FhirString('a')` is false).

Not checked: the HL7 apps were not run (they need a FHIR server and a phone);
reads through `dynamic` other than `.fhirId` and `.url.value` are not
changed (patientApp has 57 dynamic `.value` reads; a sample were Flutter
text values, not FHIR).
