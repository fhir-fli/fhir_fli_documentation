---
id: fhir_mapping_engine
title: FHIR Mapping Engine
---

## FHIR Mapping Engine in FHIR-FLI

### Understanding the Mapping Engine

The FHIR Mapping Engine is the component that executes StructureMap resources to transform data from one format to another. It implements the FHIR mapping standard, handling complex transformations while ensuring type safety and correctness.

### Key Components of the Mapping System

#### Resource Cache Hierarchy

The mapping engine relies on a cache system to efficiently access and store canonical resources. The cache classes are provided by the `fhir_r4_path` package (a dependency of `fhir_r4_mapping`) and come in three levels:

##### 1. ResourceCache (Base Abstract Class)

```dart
abstract class ResourceCache {
  // Fetches a CanonicalResource (StructureDefinition, ValueSet, etc.)
  // by canonical URL, optionally by version
  Future<T?> getCanonicalResource<T extends CanonicalResource>(
    String url, [
    String? version,
  ]);

  // Saves a CanonicalResource to the cache
  Future<void> saveCanonicalResource(CanonicalResource resource);

  // Convenience lookups
  Future<StructureDefinition?> getStructureDefinition(String url);
  Future<List<StructureDefinition>> getStructureDefinitions();
  Future<CodeSystem?> getCodeSystem(String url, [String? version]);
  Future<Map<String, dynamic>?> getResourceMap(String url);
  Future<List<String>> getResourceNames();
}
```

The base `ResourceCache` defines the interface for canonical resource lookup operations. As an abstract class, it can't be instantiated directly.

##### 2. CanonicalResourceCache

This implementation provides local, in-memory caching of canonical resources. It only returns resources that have been explicitly stored in the cache:

```dart
final cache = CanonicalResourceCache();
await cache.saveCanonicalResource(myStructureDefinition);

final sd = await cache.getStructureDefinition(
  'http://hl7.org/fhir/StructureDefinition/Patient',
);
```

##### 3. OnlineResourceCache

```dart
final cache = OnlineResourceCache();
```

This extends `CanonicalResourceCache` to add online lookup capabilities. If a resource isn't found in the local cache, it will attempt to fetch it over HTTP from its canonical URL, caching the result for subsequent lookups. You can optionally pass your own `http` `Client`.

#### Resource Builders

FHIR resources are typically immutable and often have required fields. During mapping, resources need to be built incrementally, which creates challenges:

- A resource might not have all required fields until mapping is complete
- Mapping rules may need to modify fields during execution

To address this, `fhir_r4_mapping` ships a complete Builder tree mirroring the FHIR classes: every class in `fhir_r4` has a mutable `Builder` counterpart (e.g. `PatientBuilder` for `Patient`):

```dart
// Create an empty builder and fill it in incrementally
final builder = PatientBuilder.empty();
builder.name = [
  HumanNameBuilder.empty()..family = FhirStringBuilder('Doe'),
];

// Convert to the immutable FHIR class when complete
final Patient patient = builder.build();

// Convert an immutable resource back into a builder
final builderAgain = patient.toBuilder;
```

Key characteristics of builders:
- No required fields — all fields are nullable and mutable
- `build()` converts a builder (sub)tree back into the immutable FHIR class
- Every immutable class exposes `toBuilder` for the reverse direction
- `FhirBaseBuilder.setChildByName` allows dynamic, name-based writes — this is what the mapping engine uses to set fields while executing rules (the immutable classes only support dynamic *reads* via `getChildrenByName`)

### Creating and Using the Mapping Engine

#### Engine Creation

Like the parser, the mapping engine must be created asynchronously. It takes a single argument — the resource cache; the StructureMap itself is passed to each transform call:

```dart
// Create a resource cache
final resourceCache = CanonicalResourceCache();

// Create the mapping engine
final mapEngine = await FhirMapEngine.create(resourceCache);
```

#### Basic Transformation

The simplest way to transform data is with the `transformFromFhir` method:

```dart
// Transform a source resource to a target using a StructureMap
Future<Person> transformPatientToPerson(
  Patient patient,
  StructureMap structureMap,
) async {
  // If no target is provided, one will be created based on the map's
  // target type
  final result = await mapEngine.transformFromFhir(
    patient,          // Source resource
    structureMap,     // The StructureMap to use
    null,             // Optional target resource (null means create new)
  );
  
  // Cast the result to the expected type
  return result as Person;
}
```

Note that on failure the engine does not throw: it returns an `OperationOutcome` describing the error, so check the runtime type of the result before casting.

#### Working with Builders

For more control or when dealing with partially constructed resources, you can work directly with builders. `transformBuilder` accepts builders for source and target and returns the already-built (immutable) result:

```dart
Future<FhirBase> transformWithBuilders(
  FhirBaseBuilder source,
  StructureMap map,
  FhirBaseBuilder? target,
) async {
  // Create the engine
  final mapEngine = await FhirMapEngine.create(resourceCache);
  
  // Transform using builders
  final result = await mapEngine.transformBuilder(
    '',        // appInfo (application context; pass '' if unused)
    source,    // Source resource builder
    map,       // The StructureMap to use
    target,    // Target resource builder (can be null)
  );
  
  // result is the built FHIR object (or an OperationOutcome on failure)
  return result;
}
```

#### Extended Type Creation

Sometimes mapping needs to create resources dynamically based on type names. You can provide a callback to handle custom resource creation:

```dart
// Define a function to create empty builders for custom types
FhirBaseBuilder? customEmptyFromType(String type) {
  final fhirType = type.toLowerCase();
  switch (fhirType) {
    case 'mycustomtype':
      return MyCustomTypeBuilder.empty();
    case 'anothercustomtype':
      return AnotherCustomTypeBuilder.empty();
    default:
      return null;  // Let the default handler try
  }
}

// Set the callback on the engine
mapEngine.extendedEmptyFromType = customEmptyFromType;
```

### Advanced Mapping Features

#### Working with Different Resource Caches

You can select the appropriate resource cache based on your needs:

```dart
// For local-only operation
final localCache = CanonicalResourceCache();
await localCache.saveCanonicalResource(structureDefinitionA);
await localCache.saveCanonicalResource(valueSetB);

// For mixed local/online operation
final onlineCache = OnlineResourceCache();
await onlineCache.saveCanonicalResource(structureDefinitionA);  // Priority local cache
// Other resources will be fetched from online sources if needed
```

#### Pre-loading Required Resources

For optimal performance (and for offline operation), pre-load resources the mapping will need:

```dart
// Pre-load structure definitions
final resourceCache = CanonicalResourceCache();
await resourceCache.saveCanonicalResource(structureDefinitionA);
await resourceCache.saveCanonicalResource(structureDefinitionB);
await resourceCache.saveCanonicalResource(valueSetC);

// Create the engine with the pre-loaded cache
final mapEngine = await FhirMapEngine.create(resourceCache);
```

### Complete Example

Here's a complete example that demonstrates the mapping process:

```dart
import 'dart:convert';
import 'dart:io';

import 'package:fhir_r4/fhir_r4.dart';
import 'package:fhir_r4_mapping/fhir_r4_mapping.dart';

Future<void> main() async {
  // Step 1: Set up resource cache
  final resourceCache = OnlineResourceCache();
  
  // Step 2: Pre-load any local resources
  await resourceCache
      .saveCanonicalResource(await loadStructureDefinition('patient.json'));
  await resourceCache
      .saveCanonicalResource(await loadStructureDefinition('person.json'));
  
  // Step 3: Create or load the StructureMap
  final parser = await StructureMapParser.create();
  final mapContent = await File('patient_to_person.map').readAsString();
  final structureMap = parser.parse(mapContent, 'fhirmap');
  
  // Step 4: Create the mapping engine
  final mapEngine = await FhirMapEngine.create(resourceCache);
  
  // Step 5: Load source data
  final patientJson = jsonDecode(await File('sample_patient.json').readAsString());
  final patient = Patient.fromJson(patientJson as Map<String, dynamic>);
  
  // Step 6: Define custom builder handler (if needed)
  mapEngine.extendedEmptyFromType = (String type) {
    // Custom builder creation logic
    return null;  // Return null for default handling
  };
  
  // Step 7: Perform the transformation
  final result = await mapEngine.transformFromFhir(
    patient,
    structureMap,
    null,  // No existing target, create new
  );
  
  // Step 8: Use the transformed data
  // (on failure the engine returns an OperationOutcome instead)
  final person = result as Person;
  print('Transformed patient to person: ${person.name?.first.family}');
  
  // Step 9: Serialize the result if needed
  final personJson = person.toJson();
  await File('transformed_person.json').writeAsString(jsonEncode(personJson));
}

// Helper function to load structure definitions
Future<StructureDefinition> loadStructureDefinition(String filename) async {
  final json = jsonDecode(await File(filename).readAsString());
  return StructureDefinition.fromJson(json as Map<String, dynamic>);
}
```

### Testing Mappings

For testing purposes, FHIR-FLI provides a convenience function:

```dart
Future<FhirBase?> fhirMappingEngine(
  FhirBaseBuilder source,
  StructureMap map,
  ResourceCache cache,
  FhirBaseBuilder? target, [
  FhirBaseBuilder? Function(String)? extendedEmptyFromType,
]) async {
  final mapEngine = await FhirMapEngine.create(cache)
    ..extendedEmptyFromType = extendedEmptyFromType;
  final transform = await mapEngine.transformBuilder('', source, map, target);
  return transform;
}
```

This simplifies testing by encapsulating the engine creation and transformation:

```dart
test('Patient to Person mapping', () async {
  final result = await fhirMappingEngine(
    PatientBuilder.fromJson(sourceData),
    structureMapPatientToPerson,
    resourceCache,
    PersonBuilder.empty(),
  );
  
  expect(result?.toJson(), equals(expectedResult));
});
```

### Best Practices

1. **Reuse engines** for repeated transformations of the same map
2. **Pre-load resources** in the cache for performance
3. **Select the appropriate cache level** based on your connectivity needs
4. **Use builders** for complex or incremental transformations
5. **Implement custom type handlers** for domain-specific resource types
6. **Test maps thoroughly** with representative data

### Limitations and Considerations

- Mapping complex nested structures may require multiple passes
- Some complex FHIR mapping features might have performance implications
- Resource resolution from online sources introduces latency
- Circular references in maps should be handled carefully

### Next Steps

With a solid understanding of the FHIR Mapping engine, you're ready to implement complex data transformations in your FHIR-FLI applications. Consider exploring the following:

- Creating mapping libraries for common transformations
- Integrating mapping with your application's data flow
- Developing domain-specific extensions to the mapping framework
- Contributing improvements back to the FHIR-FLI project