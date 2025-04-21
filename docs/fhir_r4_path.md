---
id: fhir_r4_path
title: FHIRPath Package
---

# FHIRPath Engine

The `fhir_r4_path` library provides a Dart implementation of the [FHIRPath](https://hl7.org/fhirpath/) specification, allowing you to query and manipulate FHIR resources using standardized expressions. This library follows the official HL7 FHIRPath specification and integrates seamlessly with the `fhir_r4` package.

### Installation

```yaml
dependencies:
  fhir_r4_path: ^0.4.3
  fhir_r4: ^0.4.1
```

## Basic Usage

There are two main approaches to using the FHIRPath engine:

### 1. Simple Approach: walkFhirPath (async)

The `walkFhirPath` function provides a straightforward way to evaluate a FHIRPath expression against a FHIR resource without having to manage an engine instance yourself:

```dart
import 'package:fhir_r4/fhir_r4.dart';
import 'package:fhir_r4_path/fhir_r4_path.dart';

void main() async {
  // Create a patient resource
  final patient = Patient(
    name: [
      HumanName(
        family: 'Doe'.toFhirString,
        given: ['John'.toFhirString],
        use: HumanNameUse.official,
      ),
    ],
  );

  // Evaluate a FHIRPath expression
  final result = await walkFhirPath(
    context: patient,
    pathExpression: "Patient.name.where(use = 'official').family",
  );

  // The result will be a List<FhirBase>
  print(result.map((e) => e.toString()).join(', ')); // Outputs: Doe
}
```

Parameters for `walkFhirPath`:

- `context`: The FHIR resource to query (required)
- `pathExpression`: The FHIRPath expression to evaluate (required)
- `resource`: The resource that contains the original node (defaults to context if null)
- `rootResource`: The container resource (if applicable)
- `environment`: A map of environment variables (keys must start with %)

### 2. Engine Approach: FHIRPathEngine (preferred for performance)

When you have multiple FHIRPath expressions or you need to evaluate many resources in a loop, the recommended approach is to create a reusable `FHIRPathEngine` instance. This is more efficient because you only parse expressions once and can share internal structures.

#### Creating the Engine

Because the engine initialization is asynchronous, you'll use the static `create(...)` factory method:

```dart
import 'package:fhir_r4/fhir_r4.dart';
import 'package:fhir_r4_path/fhir_r4_path.dart';

void main() async {
  // Create the FHIRPath engine (async)
  final fhirPathEngine = await FHIRPathEngine.create(WorkerContext());

  // Parse the expression once (can be reused)
  final node = fhirPathEngine.parse("Patient.name.where(use = 'official').family");

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
  final result1 = await fhirPathEngine.evaluate(patient1, node);
  final result2 = await fhirPathEngine.evaluate(patient2, node);

  print(result1); // [Smith]
  print(result2); // [Brown]
}
```

#### Evaluating Expressions

Once you have the `FHIRPathEngine` instance:

- `parse(String expression)`: Parses and returns an `ExpressionNode`.
- `evaluate(FhirBase? base, ExpressionNode node)`: Evaluates the parsed expression against the base resource.
- `evaluateWithContext(...)`: Allows you to provide additional context/resources or environment variables.

```dart
final result3 = await fhirPathEngine.evaluateWithContext(
  null,      // appContext (any object, e.g., a custom context or null)
  patient1,  // focusResource
  null,      // rootResource
  patient1,  // base (the immediate context for evaluation)
  node,
  environment: {
    '%var1': [42.toFhirInteger],
    '%var2': ['test'.toFhirString],
  },
);
```

## Common FHIRPath Expressions

Here are some examples of common FHIRPath expressions:

### Basic Navigation

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

### Functions

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

### Operators

```fhirpath
// Equality
Patient.gender = 'male'

// Comparison
Patient.name.count() > 1

// Logical operators
Patient.active = true and Patient.deceased = false
```

### Environment Variables

FHIRPath supports environment variables, which must be prefixed with `%`:

```dart
final environment = {
  '%pi': [3.14159.toFhirDecimal],
  '%today': [FhirDateTime('2023-01-01')],
};

final result = await walkFhirPath(
  context: patient,
  pathExpression: "Patient.birthDate < %today",
  environment: environment,
);
```

## Advanced Features

### Resource Cache

For advanced scenarios, the library provides a `ResourceCache` abstract class to cache canonical resources (like CodeSystem, ValueSet, StructureDefinition), potentially saving time on repeated lookups:

```dart
abstract class ResourceCache {
  Future<T?> getCanonicalResource<T extends CanonicalResource>(
    String url, [String? version]
  );
  
  Future<void> saveCanonicalResource(CanonicalResource resource);
  
  // ...
}
```

### Canonical Resource Manager

The `CanonicalResourceCache` extends `ResourceCache` to provide version-aware storage and retrieval of resources:

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

// Retrieve by URL
final retrieved = await manager.getCanonicalResource<ValueSet>(
  'http://example.org/fhir/ValueSet/my-codes'
);

// Retrieve by URL and version
final specificVersion = await manager.getCanonicalResource<ValueSet>(
  'http://example.org/fhir/ValueSet/my-codes',
  '1.0.0'
);
```

Key features of `CanonicalResourceCache`:

- Version-aware storage and retrieval
- Compatibility with semantic versioning
- Optional lazy loading through proxies
- Integration with HTTP clients for remote resource fetching

## Error Handling

The FHIRPath engine throws specific exceptions that give detailed information about evaluation issues:

```dart
try {
  final result = await walkFhirPath(
    context: patient,
    pathExpression: "Patient.invalid.expression",
  );
} on PathEngineException catch (e) {
  print('Expression error: ${e.message}');
  print('Expression: ${e.expression}');
} on PathEngineError catch (e) {
  print('Engine error: ${e.message}');
  print('Expression: ${e.expression}');
}
```

## Performance Considerations

For optimal performance in large-scale or batch operations:

### Reuse Parsed Expressions
Parse the expression once with `fhirPathEngine.parse()` and then evaluate repeatedly on different resources.

### Use a Dedicated Engine
Instead of `walkFhirPath()`, create and reuse a single `FHIRPathEngine` instance (via the async `create(...)` method).

### Leverage the Resource Cache
If your workflow requires repeated lookups of canonical resources, use `CanonicalResourceCache` to avoid redundant fetching or parsing.

## Integration with FHIR Mapping

The FHIRPath engine is also used by the FHIR Mapping engine (`fhir_r4_mapping`), which implements the FHIR Mapping Language for transforming FHIR resources or converting between FHIR and other data formats.

```dart
import 'package:fhir_r4/fhir_r4.dart';
import 'package:fhir_r4_mapping/fhir_r4_mapping.dart';

// Transform a resource using a StructureMap
final transformedResource = await fhirMappingEngine(
  source,
  structureMap,
  resourceCache,
);
```

## FHIRPath Specification Reference

For a complete reference of the FHIRPath language, see the [official specification](https://hl7.org/fhirpath/).

The implementation supports:

- Basic types (Boolean, String, Integer, Decimal, DateTime)
- Path selection and navigation
- Basic operators (equality, comparison, logical)
- Functions with and without arguments
- Environment variables

Currently not fully supported:

- Trace functionality
- Complete reflection capabilities
- System namespaces

## Appendix: Legacy Access Methods

While the new `FHIRPathEngine.create(...)` approach is recommended for most cases, the package includes a "legacy" or "simple" convenience method, `walkFhirPath()`. This is often sufficient for quick, single-use evaluations:

```dart
final result = await walkFhirPath(
  context: patient,
  pathExpression: '`Patient`.name.`given`[0]',
);
```

Under the hood, `walkFhirPath` uses the same engine but without exposing the details. This makes it easier for one-off expressions but less optimal for repeated operations.

Happy coding with FHIRPath in Dart!