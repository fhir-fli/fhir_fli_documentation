---
id: fhir_r4_path
title: FHIRPath Package
---

## FHIRPath Engine

The `fhir_r4_path` library provides a Dart implementation of the [FHIRPath](https://hl7.org/fhirpath/) specification, allowing you to query and manipulate FHIR resources using standardized expressions.

As of version 0.6.0, the FHIRPath engine itself lives in the standalone, model-independent [`fhir_path`](https://pub.dev/packages/fhir_path) package ([github.com/fhir-fli/fhir_path](https://github.com/fhir-fli/fhir_path)). The engine has zero FHIR-version coupling — it navigates any model through the `FhirNode` contract from `package:fhir_node`. `fhir_r4_path` is the **R4 binding** over that engine: it supplies the R4 `WorkerContext`, the R4 value factory, and the terminology/validation plumbing, then re-exports the engine. Depend on this one package and you get both the engine and its R4 model bindings. (Identical bindings exist for R5 and R6 as `fhir_r5_path` and `fhir_r6_path`.)

#### Installation

```yaml
dependencies:
  fhir_r4_path: ^0.6.0
  fhir_r4: ^0.6.1
```

### Basic Usage

The API is `FHIRPathEngine`. Create the engine once (creation is async — it initializes its worker context), **parse each expression once**, then **evaluate it against as many resources as you like**. Parsing is the expensive step, so the recommended pattern is parse-once / evaluate-many.

```dart
import 'package:fhir_r4/fhir_r4.dart';
import 'package:fhir_r4_path/fhir_r4_path.dart';

void main() async {
  // Create the FHIRPath engine (async)
  final engine = await FHIRPathEngine.create(WorkerContext());

  // Parse the expression once (can be reused)
  final node = engine.parse("Patient.name.where(use = 'official').family");

  // Create some resources to test against
  final patient1 = Patient(
    name: [
      HumanName(
        family: 'Smith'.toFhirString,
        given: ['Jane'.toFhirString],
        use: HumanNameUse.official,
      ),
    ],
  );

  final patient2 = Patient(
    name: [
      HumanName(
        family: 'Brown'.toFhirString,
        given: ['Charlie'.toFhirString],
        use: HumanNameUse.official,
      ),
    ],
  );

  // Evaluate against different patients
  final result1 = await engine.evaluate(patient1, node);
  final result2 = await engine.evaluate(patient2, node);

  print(result1); // [Smith]
  print(result2); // [Brown]
}
```

#### The Core API

Once you have a `FHIRPathEngine` instance:

- `parse(String expression)`: Parses the expression (synchronously) and returns an `ExpressionNode`. Throws on invalid syntax — including trailing garbage after a valid expression.
- `isValid(String expression)`: Returns `true` if the expression parses cleanly, `false` otherwise.
- `evaluate(FhirNode? base, ExpressionNode node)`: Evaluates a parsed expression against a resource. Async — returns `Future<List<FhirNode>>`.
- `evaluateWithContext(...)`: Like `evaluate`, but lets you supply the app context, `%resource` / `%rootResource`, and user-defined environment variables.
- `evaluateFromPath(FhirNode? base, String path)`: Convenience that parses and evaluates in one call — only for genuinely one-off expressions.

#### Working with Results

Evaluation returns `List<FhirNode>` — the model-independent node contract the engine works in. In an R4 context every node the engine produces is a `FhirBase`, so when you need the typed R4 classes, narrow the list back:

```dart
final results = await engine.evaluate(patient, node);
final typed = results.cast<FhirBase>();
```

For display purposes, `toString()` on primitive results gives you the value directly (as in the `[Smith]` output above).

#### evaluateWithContext and Environment Variables

`evaluateWithContext` takes the full set of FHIRPath evaluation inputs as positional parameters, plus a named `environment` map:

```dart
final node = engine.parse('Patient.birthDate < %cutoffDate');

final result = await engine.evaluateWithContext(
  null,     // appContext (any app-defined object, or null)
  patient,  // focusResource — what %resource resolves to
  null,     // rootResource — what %rootResource resolves to
  patient,  // base — the node evaluation starts from
  node,
  environment: {
    'cutoffDate': ['2000-01-01'.toFhirDate],
  },
);
```

Notes on the `environment` map:

- **Keys do not include the `%` prefix.** An expression referencing `%cutoffDate` is resolved against the map key `'cutoffDate'`.
- **Values are lists** of FHIR values (a FHIRPath variable is a collection), e.g. `[5.toFhirInteger]` or `['Male'.toFhirString]`.
- **Lazy loading:** a value may also be a zero-argument function returning such a list; it is only invoked if the variable is actually accessed during evaluation.

The built-in variables `%resource`, `%rootResource`, and `%context` come from the positional parameters, and the standard constants (`%sct`, `%loinc`, `%ucum`, plus the `` %`vs-...` `` / `` %`cs-...` `` / `` %`ext-...` `` URL shorthands) are always available.

### Common FHIRPath Expressions

Here are some examples of common FHIRPath expressions:

#### Basic Navigation

```fhirpath
// Access a field
Patient.active

// Access an array element
Patient.name[0]

// Access a field in an array
Patient.name.family

// Access a field with a specific value
Patient.name.where(use = 'official')
```

#### Functions

```fhirpath
// Count elements
Patient.name.count()

// Check if telecom exists
Patient.telecom.exists()

// Filter with conditions
Patient.telecom.where(system = 'phone')

// First/last elements
Patient.name.first()
Patient.name.last()
```

#### Operators

```fhirpath
// Equality
Patient.gender = 'male'

// Comparison
Patient.name.count() > 1

// Logical operators
Patient.active = true and Patient.deceased = false
```

### Advanced Features

#### Resource Cache

For advanced scenarios, the library provides a `ResourceCache` abstract class for caching canonical resources (like `CodeSystem`, `ValueSet`, `StructureDefinition`), saving time on repeated lookups:

```dart
abstract class ResourceCache {
  Future<T?> getCanonicalResource<T extends CanonicalResource>(
    String url, [String? version]
  );

  Future<void> saveCanonicalResource(CanonicalResource resource);

  Future<StructureDefinition?> getStructureDefinition(String url);
  Future<List<StructureDefinition>> getStructureDefinitions();
  Future<CodeSystem?> getCodeSystem(String url, [String? version]);
  // ...
}
```

#### Canonical Resource Cache

`CanonicalResourceCache` is the standard in-memory implementation, with version-aware storage and retrieval:

```dart
import 'package:fhir_r4/fhir_r4.dart';
import 'package:fhir_r4_path/fhir_r4_path.dart';

// Create a manager
final manager = CanonicalResourceCache();

// Store a canonical resource
final valueSet = ValueSet(
  url: 'http://example.org/fhir/ValueSet/my-codes'.toFhirUri,
  version: '1.0.0'.toFhirString,
  name: 'MyCodes'.toFhirString,
);
manager.see(valueSet);

// Retrieve by URL (latest version)
final retrieved = await manager.getCanonicalResource<ValueSet>(
  'http://example.org/fhir/ValueSet/my-codes'
);

// Retrieve by URL and version
final specificVersion = await manager.getCanonicalResource<ValueSet>(
  'http://example.org/fhir/ValueSet/my-codes',
  '1.0.0'
);
```

`OnlineResourceCache` extends `CanonicalResourceCache` and falls back to an HTTP GET (with `Accept: application/fhir+json`) when a resource is not cached locally, then caches what it fetched. To give the engine a cache, pass it to the worker context:

```dart
final engine = await FHIRPathEngine.create(
  WorkerContext(resourceCache: OnlineResourceCache()),
);
```

### Error Handling

Parsing errors are thrown synchronously by `parse` (as `FHIRLexerException`, a subclass of `PathEngineException`); evaluation problems surface as `PathEngineException` or `PathEngineError`:

```dart
final engine = await FHIRPathEngine.create(WorkerContext());

try {
  final node = engine.parse('Patient.name.where(');
  final result = await engine.evaluate(patient, node);
} on PathEngineException catch (e) {
  print('Expression error: ${e.message}');
  print('Expression: ${e.expression}');
} on PathEngineError catch (e) {
  print('Engine error: ${e.message}');
}
```

### Performance Considerations

For optimal performance in large-scale or batch operations:

#### Reuse the Engine
`FHIRPathEngine.create(...)` does real initialization work — create one engine and share it.

#### Reuse Parsed Expressions
Parse each expression once with `engine.parse()` and then evaluate repeatedly on different resources.

#### Leverage the Resource Cache
If your workflow requires repeated lookups of canonical resources, use `CanonicalResourceCache` (or `OnlineResourceCache`) to avoid redundant fetching or parsing.

### Integration with FHIR Mapping

The FHIRPath engine is also used by the FHIR Mapping engine (`fhir_r4_mapping`), which implements the FHIR Mapping Language for transforming FHIR resources or converting between FHIR and other data formats. `FhirMapEngine` creates its own `FHIRPathEngine` internally, wired up with host services for the mapping language's FHIRPath evaluation.

### Legacy API

Earlier versions of this package were built around a `walkFhirPath()` convenience function. It still exists for backwards compatibility but is **deprecated**: it re-creates an engine and re-parses the expression on every call. Migrate any remaining `walkFhirPath` (or `parseFhirPath` / `executeFhirPath`) call sites to the `FHIRPathEngine` API shown above.

### FHIRPath Specification Reference

For a complete reference of the FHIRPath language, see the [official specification](https://hl7.org/fhirpath/).

The implementation is a Dart port of the HL7 Java reference implementation's FHIRPath engine and is validated against the official FHIRPath test suite, covering:

- Literals and the full type system (Boolean, String, Integer, Decimal, Date, DateTime, Time, Quantity)
- Path selection and navigation
- The full operator set (equality, equivalence, comparison, logical, math, type operators)
- The FHIRPath function library (including `trace()`, `aggregate()`, type reflection, and math functions)
- Environment variables and the standard constants

Happy coding with FHIRPath in Dart!
