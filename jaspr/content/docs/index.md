---
title: Getting Started
description: Install the FHIR-FLI libraries and work with your first resource.
---

FHIR-FLI (<b>F</b>ast <b>H</b>ealthcare <b>I</b>nteroperability <b>R</b>esources - with <b>F</b>lutter <b>L</b>ibrary <b>I</b>ntegration) is a set of Dart libraries that enable Flutter developers to easily work with [FHIR](docs/core/fhir_r4) data. These libraries provide common functionality that is needed for working with FHIR, including serialization/deserialization, making [RESTful](docs/at_rest/fhir_r4_at_rest) requests, [SMART on FHIR](docs/auth/fhir_r4_auth) authentication, [local secure storage](docs/fhir_r4_db), [FHIRPath](docs/fhir_r4_path), [FHIR Bulk Data](docs/fhir_r4_bulk), [FHIR Mapping](docs/mapping/fhir_mapping), [CQL](docs/fhir_r4_cql), and [resource validation](docs/fhir_r4_validation).

## Quick start

Add the core package to your `pubspec.yaml`:

```yaml
dependencies:
  fhir_r4: ^0.12.0
```

Then build a resource, serialize it, and read it back:

```dart
import 'package:fhir_r4/fhir_r4.dart';

void main() {
  final patient = Patient(
    id: FhirString('123'),
    name: [
      HumanName(
        family: 'Doe'.toFhirString,
        given: ['John'.toFhirString],
      ),
    ],
    birthDate: '1990-01-01'.toFhirDate,
  );

  final json = patient.toJson();
  print(json['resourceType']); // Patient

  final restored = Patient.fromJson(json);
  print(restored.name?.first.family?.valueString); // Doe
}
```

Every resource and data type is immutable, validates its primitives on
construction, and round-trips through `toJson()` / `fromJson()`. The
[Basic Object](docs/core/basic_object), [Serialization](docs/core/serialization)
and [Primitive Types](docs/core/primitive_types) pages cover the details.

## Architecture

The family is built in three layers:

1. **Model-independent engines** - standalone packages with no dependency on any FHIR version: [`fhir_path`](https://pub.dev/packages/fhir_path) (FHIRPath engine), [`cql`](https://pub.dev/packages/cql) (CQL engine), [`ucum`](https://pub.dev/packages/ucum) (units of measure), and [`fhir_node`](https://pub.dev/packages/fhir_node) (the reflection contract that lets the engines navigate any FHIR model).
2. **Version cores** - `fhir_r4`, `fhir_r5`, and `fhir_r6` provide the generated resource models for each FHIR version. Every class implements the `FhirNode` contract, which is how the engines above work across all three versions unchanged.
3. **Companion packages** - thin bindings and utilities per version (`fhir_r4_path` binds the `fhir_path` engine to R4, `fhir_r4_cql` binds `cql`, plus REST, auth, database, bulk data, mapping, and validation packages).

## FHIR version support

All packages are available for **FHIR R4, R5, and R6**. The APIs are identical across versions - just swap the package name:

| Package | R4 | R5 | R6 |
|---------|----|----|-----|
| Core types | `fhir_r4` | `fhir_r5` | `fhir_r6` |
| REST client | `fhir_r4_at_rest` | `fhir_r5_at_rest` | `fhir_r6_at_rest` |
| Auth (SMART) | `fhir_r4_auth` | `fhir_r5_auth` | `fhir_r6_auth` |
| Bulk data | `fhir_r4_bulk` | `fhir_r5_bulk` | `fhir_r6_bulk` |
| CQL | `fhir_r4_cql` | `fhir_r5_cql` | `fhir_r6_cql` |
| Database | `fhir_r4_db` | `fhir_r5_db` | `fhir_r6_db` |
| Mapping | `fhir_r4_mapping` | `fhir_r5_mapping` | `fhir_r6_mapping` |
| FHIRPath | `fhir_r4_path` | `fhir_r5_path` | `fhir_r6_path` |
| Validation | `fhir_r4_validation` | `fhir_r5_validation` | `fhir_r6_validation` |

The documentation focuses on R4 examples, but all code works identically with R5 and R6 by changing the import.

## Official HL7 references

- [FHIR](https://www.hl7.org/fhir/overview.html)
- [FHIR RESTful API](https://www.hl7.org/fhir/http.html)
- [SMART App Launch](http://hl7.org/fhir/smart-app-launch/)
- [FHIRPath](https://hl7.org/fhirpath/N1/)
- [FHIR Bulk Data](https://build.fhir.org/ig/HL7/bulk-data/)
- [FHIR Mapping](https://build.fhir.org/mapping-language.html)
- [Clinical Quality Language (CQL)](https://cql.hl7.org/)
