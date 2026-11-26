---
id: migration
title: Migration Guide
---

## Moving from `fhir` 0.12 to `fhir_r4`

The `fhir` package stopped at 0.12.1, and `fhir_at_rest` at 0.12.0.
[`fhir_r4`](https://pub.dev/packages/fhir_r4) and
[`fhir_r4_at_rest`](https://pub.dev/packages/fhir_r4_at_rest) carry on from
them. The resources have the same names and fields, but most fields that
were Dart types are now FHIR types, so an app that builds or reads
resources will have hundreds of compile errors after the switch. A tool
fixes most of them.

### Run fhir_migrate

```
dart pub global activate fhir_migrate
cd my_app
git commit -am "before fhir_r4"
fhir_migrate .
```

[`fhir_migrate`](https://pub.dev/packages/fhir_migrate) changes the
pubspec and imports, then runs the Dart analyzer over the app and fixes
every error whose shape it knows, round after round, until nothing more
changes. It edits the app in place, so commit first and read the result
as a diff. It refuses to start on uncommitted changes (`--allow-dirty`
overrides that). What it could not fix is printed at the end, one line
each.

It was checked on three apps that use `fhir` 0.12:

| App | Errors after switching packages | Left after fhir_migrate |
| --- | --- | --- |
| HL7 Physical Activity patient app | 1,281 | 0 |
| HL7 Physical Activity provider app | 1,245 | 14, all there before the switch |
| Bahmni Connect2 | 51 | 6 |

The patient app's Observation builders give the same JSON before and
after, and its patient search and upload give the same results against a
HAPI FHIR server. Bahmni's tests give the same results before and after
once the 6 left are fixed by hand. The tool's
[RESULTS.md](https://github.com/fhir-fli/fhir_migrate/blob/main/RESULTS.md)
has the detail.

After the tool, run `dart analyze` (or `flutter analyze`) and your tests,
and read the section below on code that compiles but behaves differently.

### What changed

Each row is a change `fhir_migrate` makes. The examples are taken from the
apps above.

| `fhir` 0.12 | `fhir_r4` |
| --- | --- |
| `HumanName(family: familyName)` (a `String`) | `HumanName(family: familyName?.toFhirString)`. Also `.toFhirBoolean`, `.toFhirInteger`, `.toFhirDecimal`, `.toFhirDateTime`, `.toFhirUri` and the others |
| `HumanName(given: givenNames)` (a `List<String>`) | `given: givenNames.map((e) => e.toFhirString).toList()` |
| `patient.name?.first.family` read as a `String` | `patient.name?.first.family?.valueString` |
| `.value` on a primitive | `.valueString`, `.valueBoolean`, `.valueInt`, `.valueDouble`, `.valueDateTime` or `.valueUri`, by type |
| `Patient(fhirId: uuid)`, `p.fhirId` | `Patient(id: uuid?.toFhirString)`, `p.id?.valueString` |
| `gender: FhirCode('male')` | `gender: AdministrativeGender('male')`, where the field now has its own code type |
| `FhirCode.asConst(x)` | `FhirCode(x)` |
| `HumanNameUse.official` | `NameUse.official`, and 13 other enums whose type was renamed |
| `FhirDateTime(dateTime)`, `FhirDate('1980-02-03')` | `FhirDateTime.fromDateTime(dateTime)`, `FhirDate.fromString('1980-02-03')`; the same for `FhirInstant` |
| `TaskInput(valueReference: ref)` | `TaskInput(valueX: ref)` where value[x] is one parameter |
| `Task(resourceType: R4ResourceType.Task, ...)` | no `resourceType:` parameter |
| `FhirExtension(url: FhirUri('http://...'))` | `url: FhirString('http://...')` |
| `ResourceUtils.resourceTypeFromStringMap[s]` | `R4ResourceType.fromString(s)` |

Requests from `fhir_at_rest` become the typed requests of
`fhir_r4_at_rest`:

```dart
// fhir_at_rest 0.12
final request = FhirRequest.search(
  base: base,
  type: R4ResourceType.Patient,
  parameters: ['name=$name'],
);
final Resource bundle =
    await request.request(headers: {'accept': 'application/fhir+json'});

// fhir_r4_at_rest, as fhir_migrate writes it
final request = FhirSearchRequest(
  base: base,
  resourceType: R4ResourceType.Patient.toString(),
  search: restfulParameters(['name=$name']),
  headers: {'accept': 'application/fhir+json'},
);
final Resource bundle = await sendForResource(request);
```

`FhirRequest.read`, `create`, `update` and `delete` become
`FhirReadRequest`, `FhirCreateRequest`, `FhirUpdateRequest` and
`FhirDeleteRequest`; a resource is passed as `resource.toJson()`. The old
`request()` never threw: a failure came back as an `OperationOutcome`.
`sendForResource` keeps that, so code that checks
`response is OperationOutcome` still works. The tool writes it and
`restfulParameters` into `lib/fhir_rest_compat.dart` in your app. New code
can call `request.sendRequest()` directly, which returns the HTTP response.
See [the REST client](docs/at_rest/fhir_r4_at_rest).

### What the tool leaves for you

In the three apps, the tool left these:

- A `Bundle` built without a `type`. `type` is now required:
  `Bundle(type: BundleType.searchset, ...)`.
- A ternary that mixes a FHIR value with a String
  (`x?.valueString ?? ''` where `x` is now a `FhirString`).
- A `const` constructor call whose argument is now an extension getter,
  which cannot be const. Drop the `const`.

### Code that compiles but behaves differently

Neither the compiler nor the tool catches all of these.

**Equality with a String depends on the side.** Measured with `fhir_r4`
0.14.1:

| Expression | Result |
| --- | --- |
| `FhirString('a') == 'a'` | true |
| `'a' == FhirString('a')` | false |
| `expect(name.family, 'Smith')` | fails |
| `<String>['Smith'].contains(name.family)` | false |
| `[name.family].contains('Smith')` (a list of FHIR values) | true |
| a `Set` or `Map` mixing the two, either way round | never matches |
| `switch (name.family) { case 'Smith': ... }` | never matches (the analyzer warns) |

`fhir_migrate` reads the FHIR value back (`name.family?.valueString`) in
`expect`, in `==` and `!=` with the String on the left, in a `switch`, and
in `contains`, `remove`, `containsKey`, `containsValue` and `[]` on a
collection of Dart values. A `Set` or `Map` that now holds FHIR values and
is looked up with a String is listed for you to fix where the collection
is built. A comparison that reaches a FHIR value through `Object` or
`dynamic` is not seen.

**Values from decoded JSON.** `HumanName(family: json['family'])` compiles
with both packages, since `json['family']` is `dynamic`, and fails when it
runs. The tool turns on `strict-casts` for one pass to find these and
writes `(json['family'] as String?)?.toFhirString`. Keep `strict-casts` on
in your own `analysis_options.yaml` to catch new ones:

```yaml
analyzer:
  language:
    strict-casts: true
```

**Reads through `dynamic`.** `data.resource.fhirId` on a `dynamic` compiles
and throws `NoSuchMethodError` when it runs. The tool rewrites `.fhirId` to
`.id` and `.field.value` to that field's getter on `dynamic` receivers; any
other read through `dynamic` is yours to find.

**A missing date.** The old `FhirDateTime(null)` gave the current time,
marked invalid. The migrated `end?.toFhirDateTime` leaves the field out
when `end` is null.

**Empty lists are left out of the JSON.** `Observation(hasMember: [])`
wrote `"hasMember": []` with `fhir` 0.12; `fhir_r4` leaves the element
out. A server or test that expected the empty array will see a
difference.

### Working with code types

A code type such as `AdministrativeGender` has a constant for each code
and a Dart enum for `switch`:

```dart
final gender = AdministrativeGender('male');
gender == AdministrativeGender.male; // true

switch (gender.valueEnum) {
  case AdministrativeGenderEnum.male:
    // ...
  default:
    // ...
}
```

A code outside the value set still builds: `AdministrativeGender('custom')`
has `valueString` `'custom'` and `valueEnum` null.

---

## Upgrading fhir_r4 0.12.x → 0.14.0

Change every `fhir_r4*` constraint to `^0.14.0`. 0.13.0 moved each engine into
a package that serves every FHIR version (`fhir_path`, `fhir_at_rest`,
`fhir_auth`, `fhir_bulk`, `fhir_cds_hooks`, `fhir_db`, `fhir_mapping`,
`fhir_validation`, all reading resources through `fhir_node`). Each `fhir_r4_*`
package re-exports its engine with the R4 model filled in, so an import does
not change and most code compiles as it was. 0.14.0 moves the CQL engine to
`cql` 0.8.0 and otherwise only aligns versions.

**Code that has to change**

| Package | Was | Now |
| --- | --- | --- |
| `fhir_r4_auth` | `SmartConfig(fhirBaseUrl: url.toFhirUri)`; `client.fhirBaseUrl` a `FhirUri` | `fhirBaseUrl: Uri.parse(url)`; `client.fhirBaseUrl` is a `Uri` |
| `fhir_r4_at_rest` | `result.errorOperationOutcomes` held `OperationOutcome` | They hold `Resource`: `.cast<OperationOutcome>()` to read `issue` |
| `fhir_r4_path`, `fhir_r4_mapping` | `cache.getCanonicalResource<ValueSet>(url)` | `cache.valueSet(url)` or `cache.canonical<ValueSet>(url)` (the `TypedResourceCache` extension); the cache itself holds `FhirNode` |
| `fhir_r4_path`, `fhir_r4_mapping` | `OnlineResourceCache()` | `OnlineResourceCache(parse: Resource.fromJson)` |
| `fhir_r4_path` | `WorkerContext.loadStructureDefinition(...)` returned nothing | It returns a `Future`: await it |
| `fhir_r4_bulk` | `WhichResource.resourceType` an `R4ResourceType`; `kickoff.unknownTypes()` | `resourceType` is the type's name; `kickoff.unknownTypes(r4Bulk)`. `BulkRequest.request()` returns `List<Resource>` |
| `fhir_r4_cds_hooks` | `CdsRequest.prefetch`, `CdsAction.resource` and the contexts' bundles were `Resource` / `Bundle` | They are `Map<String, dynamic>`: pass `resource.toJson()`; `prefetchResources` and `typedResource` give the typed views |
| `fhir_r4_mapping` | Engine extensions on `ElementDefinition`, `StructureDefinition`, `StructureMap`, `ValueSet` | Gone; the engine reads those by element name |
| `fhir_r4_cql` | `library.execute(context)` | `library.execute(context, const R4ModelResolver())`. The resolver is an optional argument, so leaving it out compiles; an operation that needs the model then throws `StateError('No ModelResolver in execution context…')` at run time |

**Answers that change without a compile error**

- **A code's `system` is its CodeSystem** (`fhir_r4` 0.13.0). Every enum
  constant's `system` is the CodeSystem the code is defined in
  (`http://hl7.org/fhir/observation-status`), with its `version`; it was the
  ValueSet's url. A code parsed from JSON or built from a string now carries
  its constant's `system`, `version` and `display`. `toJson` is unchanged.
- **`valueDateTime` is the instant** (`fhir_r4` 0.13.0). A value written with
  `Z` or an offset comes back in UTC (`2013-01-14T10:00:00+02:00` is 08:00Z);
  it used to keep the wall-clock time and drop the offset. A date, or a
  dateTime with no offset, is still local.
- **CQL strings are `CqlString`** (`cql` 0.8.0, through `fhir_r4_cql` 0.14.0).
  Every string operator answers a `CqlString`, never a Dart `String`: read
  `.valueString`. `Successor` / `Predecessor` at a type's bound answer null
  where they threw, and Variance of quantities keeps the elements' unit.
  From `cql` 0.7.0 (`fhir_r4_cql` 0.13.0): `To*`, `ConvertsTo*` and the
  `resolve*Ref` lookups answer null where they threw, and an impossible date
  is refused with a `FormatException`.
- **`fhir_r4_db` search follows R4B search.html more closely.** Number,
  quantity and date values are ranges and the prefixes are the range rules
  (`eq` is containment, so `probability=0.3` finds 0.31); a quantity is
  `[prefix][number]|[system]|[code]` and the old `5|mg` form is no longer
  read; `code=|X` and `subject:identifier=|42` match only values with no
  system; Period and Timing values, contained resources and the meta
  parameters (`_tag`, `_profile`, `_security`, `_source`) are indexed;
  `_include` names a search parameter (`Patient:organization`, not the
  element); a bare id that names resources of two types throws
  `AmbiguousReference`. Modifiers the store gives no meaning are refused with
  `UnsupportedSearchModifier` instead of being answered as something else
  (token and reference `:above` / `:below`, `name:text`, `subject:Foo`), as is
  `:missing=maybe` (`InvalidSearchValue`) and a `:in` / `:not-in` ValueSet
  whose compose cannot be evaluated (`UnsupportedValueSetCompose`).
- **An update keeps the submitted `meta`.** `saveResource` writes the
  submitted `profile` and `source` with the store's `versionId` and
  `lastUpdated`, and merges `tag` and `security` labels with the stored ones
  (`mergeTags: false` writes them as submitted). `preserveMeta: true` stores a
  fetched resource's server `meta` as received.

**The store upgrades itself.** `fhir_r4_db` 0.12.0 wrote schema 6; 0.14.0
(through `fhir_db` 0.15.1) is schema 15. The first open migrates, and the
search index, which is derived data, is rebuilt from the stored resources
twice, at the schema 10 step and at the schema 15 step. One rebuild was
measured at 467 s for 928,935 resources. A subclass that overrides
`migration` must call `rebuildSearchIndex()` itself. Because of the code
`system` change above, a store indexed by an older release needs that rebuild
for `status=<system>|final`, `:in` and `:not-in` to match `code` elements.

**New in these releases**: paged history with tombstones (`getHistory`,
`countHistory`, `getVersion`), `ifMatchVersion` on save and delete
(`VersionConflict`), compartment search (`CompartmentScope`), indexed
uploaded `SearchParameter`s, `FhirDb.rekey`, streaming NDJSON in
`fhir_r4_bulk` (`NdjsonStream.lines`, `resources`, `encode`, `write`) and the
Bulk Data 2.0.0 models (`BulkExportKickoff`, `BulkExportManifest`). See the
[fhir_r4_db](docs/fhir_r4_db) and [fhir_r4_bulk](docs/fhir_r4_bulk) pages.

---

## Upgrading fhir_r4 0.9.x → 0.12.0

The resource APIs did not change. All three releases are about `fhir_r*_db`
search, and two of them change what an existing call returns.

**0.10.0 — modifiers and comparators moved to where FHIR puts them.** They used
to be read off the end of the value (`family=Smith:exact`,
`birthdate=1980-01-01:gt`), a syntax FHIR does not have. The modifier now comes
from the parameter name (`family:exact=Smith`) and the comparator from the front
of the value (`birthdate=gt1980-01-01`). Values are no longer split at a colon,
and `\,`, `\|` and `\$` escapes are honoured. An unsupported modifier throws
`UnsupportedSearchModifier` instead of being ignored. Accents fold for the
default and `:contains` searches, and `:exact` is exact. **Schema 5 → 6**; the
string index is rebuilt from the stored resources on first open.

**0.11.0 — a repeated parameter is an AND, a comma is an OR.** Each element of a
parameter's value list is now one repetition and the elements are intersected.
Code that passed `['Anna', 'Beth']` to get *either* name must pass the single
element `'Anna,Beth'` instead; the comma split happens inside the package, where
escaping applies. This silently changed what subscription criteria matched in
one server built on the package, so check every multi-value search you make.

**0.12.0 — a save that cannot be indexed fails.** `saveResource` used to catch
indexing errors, print them, and return the resource anyway, leaving a record
that no search could find. It now throws, and writes the resource, its history
row and its index rows in one transaction, so a failed update keeps the
previous version.

---

## Upgrading fhir_r4 0.8.x → 0.9.0

Nothing in the resource APIs changed. Two things matter, both in
`fhir_r*_db`:

- **The database schema goes from 4 to 5, and migrates itself on first
  open.** The nine search-index tables gain `searchName` in their primary
  key. Without it a resource could hold only one parameter per path, so a
  second parameter reading the same element silently replaced the first. Your
  rows are preserved; you do not need to do anything, but the first open of
  an existing database does more work than usual.
- **Search parameters that were silently dropped now index.** 201 of them in
  R4, 193 in R5, 213 in R6. Every one used an `as` cast in its FHIRPath
  expression, which the generator's expression splitter did not handle, so
  the parameter compiled to nothing. `value-quantity`, `value-concept`,
  `medication` and Immunization `date` were among them, and `_has` reverse
  chaining can now chain through them.

  Parameters that could not be indexed before appear for resources saved
  after the upgrade. **Existing resources need re-saving to pick them up**,
  the same way a FHIR server reindexes after a SearchParameter is added.

`FhirDao.subjectOfCare(resourceType, id)` is new: it resolves any resource to
the patient whose record it is, reading the reference search index rather
than the resource. It uses only the subject-of-care parameters, so a
`performer` or `recorder` who happens to be a patient is never returned.

---

## Upgrading fhir_r4 0.7.x → 0.8.0

One breaking change, in `fhir_r*_path` and everything built on it
(`_mapping`, `_validation`, `_cql`). Both halves concern `memberOf`:

- **`memberOf` now throws `PathEngineException` when the value set cannot be
  resolved**, instead of returning an empty collection. The spec is explicit
  — "If the valueset cannot be resolved as a uri to a value set, an error is
  thrown" — and the old behaviour made `where(code.memberOf(...)).count()`
  answer a confident `0` that a caller could not tell apart from a genuine
  none. If you relied on the silent-empty behaviour, catch the exception at
  the call site and decide there what an unresolvable value set means for
  you.
- **`memberOf` now asks only whether the code is in the value set**, not
  whether it is also valid in its own code system. A value set enumerating
  SNOMED concepts is answerable from the enumeration alone, and SNOMED is
  licensed, so the wider question returned `false` offline for a code the
  value set plainly listed. The operator form had both defects and now
  matches the function form.

If you use `fhir_path` directly rather than through a binding, this arrived
in `fhir_path` 0.14.0.

---

## Upgrading fhir_r4 0.6.x → 0.7.0

0.7.0 is a breaking release, but the breaks are small and mechanical (they apply equally to `fhir_r5` and `fhir_r6`):

- **Enum renames (casing fix):** `MedicationrequestStatus` → `MedicationRequestStatus` and `MessageheaderResponseRequest` → `MessageHeaderResponseRequest` (along with their `...Enum` and `...CopyWithImpl` companions, and the `...Builder` variants in the mapping packages). The old names were generated from miscased tokens in HL7's own spec data. **Your existing code keeps compiling** — the old names remain as deprecated typedef aliases — but the analyzer will nudge you to rename; a find-and-replace is all that's needed.
- **`ClientLogger` in `fhir_r*_path`:** the `logFile` field (a dart:io `File?`) is now `logFilePath` (a `String?`). This was part of making the `_path`, `_bulk`, `_mapping`, `_validation`, and `_cql` packages web/WASM-compatible. The constructor is unchanged.

Nothing about serialization, the wire format, or resource APIs changed.
