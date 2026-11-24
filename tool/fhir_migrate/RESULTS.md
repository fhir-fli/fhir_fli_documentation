# fhir 0.12 -> fhir_r4 0.14 conversion: test runs

Run 2026-11-24 with `convert_app.sh <app> <logdir>` on local clones (nothing
pushed to the projects). Flutter 3.47.0, fhir_r4 0.14.1, fhir_r4_at_rest 0.15.0.

| App (fhir version before) | Errors after switching | Left after the tool | Reads through `dynamic` fixed | Tests |
|---|---|---|---|---|
| Bahmni/connect2Bahmni @63fbaa4 (fhir 0.12.1) | 51 | 6 (4 Bundle needs a type, 1 ternary, 1 `const`) | 10 JSON values | before 31 pass / 1 skip / 1 fail; after 30 / 1 / 2 |
| FHIR/physical-activity-ri patientApp (fhir 0.12.0, fhir_at_rest 0.12.0) | 1,281 | 0 | 77 `.fhirId`, 63 primitive `.value`, 3 `.url.value` | no tests in the app; checks below |
| FHIR/physical-activity-ri providerApp (fhir 0.12.0, fhir_at_rest 0.12.0) | 1,245 | 14, all present before the switch (a missing file in the repo) | 125 `.fhirId`, 94 primitive `.value`, 3 `.url.value` | no tests in the app |

Bahmni's two failures after: `bahmni_appointment_test` fails before and after
(it expects India time; passes under TZ=Asia/Kolkata), and
`providers_test` compares `'superman'` with a FhirString through
`expect`, which the analyzer cannot see (`'a' == FhirString('a')` is false).

## patientApp run, old build against converted build

`checks/` holds two tests dropped into the app's `test/` and run in both
builds (a git worktree at the original commit, and the converted tree).

- `equivalence_test.dart`: nine of the app's Observation builders, each
  with and without a server id (18 resources). The JSON is the same in
  both builds except one field: the old build writes `"hasMember": []`
  on the parent Observation and the new one leaves the empty list out.
- `server_test.dart`, against a local `hapiproject/hapi` container: the
  app's own patient search (`getPatientListTestUse`) returns the seeded
  patient in both builds (Bundle, total 1). The app's own upload
  (`processResource`) stores a steps Observation in both builds, and the
  two stored Observations are identical apart from id and meta. Both
  builds then return "error": the app's local database is not opened in a
  test, and the log write after the upload hits a null check, the same in
  both.

The first strict-casts pass cast every dynamic value passed into a FHIR
field; the server check showed that `data.resource.valueQuantity.value`
is already a FhirDecimal at run time, so the cast is now applied only to
reads out of decoded JSON (`p['name']`).

Not checked: the providerApp was not run; the patientApp was not run as a
whole app on a phone. Reads through `dynamic` other than the ones listed
are not changed.
