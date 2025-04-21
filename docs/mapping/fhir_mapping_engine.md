---
id: fhir_mapping_engine
title: FHIR Mapping Engine
---

# FHIR Mapping Engine in FHIR-FLI

## Understanding the Mapping Engine

The FHIR Mapping Engine is the component that executes StructureMap resources to transform data from one format to another. It implements the FHIR mapping standard, handling complex transformations while ensuring type safety and correctness.

## Key Components of the Mapping System

### Resource Cache Hierarchy

The mapping engine relies on a cache system to efficiently access and store canonical resources. FHIR-FLI provides three levels of resource caching:

#### 1. ResourceCache (Base Abstract Class)

```dart
abstract class ResourceCache {
  // Abstract methods for resource lookup
  Future<Resource?> findResourceById(String resourceType, String id);
  Future<Resource?> findResourceByUrl(String url);
  
  // Other abstract methods...
}
```

The base `ResourceCache` defines the interface for resource lookup operations. As an abstract class, it can't be instantiated directly.

#### 2. CanonicalResourceManager

```dart
class CanonicalResourceManager extends ResourceCache {
  // Implementation of resource caching with local storage
  
  // Save a resource to the local cache
  void saveCanonicalResource(Resource resource) {
    // Implementation...
  }
  
  // Other implemented methods...
}
```

This implementation provides local, in-memory caching of canonical resources. It only returns resources that have been explicitly stored in the cache.

#### 3. OnlineResourceManager

```dart
class OnlineResourceManager extends CanonicalResourceManager {
  // Implementation with both local caching and online lookup
  
  @override
  Future<Resource?> findResourceByUrl(String url) async {
    // First try local cache
    final localResource = await super.findResourceByUrl(url);
    if (localResource != null) {
      return localResource;
    }
    
    // If not found locally, try to fetch from online source
    // Implementation...
  }
  
  // Other implemented methods...
}
```

This extends the `CanonicalResourceManager` to add online lookup capabilities. If a resource isn't found in the local cache, it will attempt to fetch it from designated online endpoints.

### Resource Builders

FHIR resources are typically immutable and often have required fields. During mapping, resources need to be built incrementally, which creates challenges:

- A resource might not have all required fields until mapping is complete
- Mapping rules may need to modify fields during execution

To address this, FHIR-FLI implements the Builder pattern with classes that mirror FHIR resources:

```dart
// Normal immutable FHIR class
class Patient implements Resource {
  Patient({
    required this.name,  // Required field
    this.gender,
  });
  
  final List<HumanName> name;
  final FhirCode<PatientGender>? gender;
  
  // Other fields and methods...
}

// Mutable builder version
class PatientBuilder implements ResourceBuilder {
  PatientBuilder();
  
  List<HumanNameBuilder>? name;  // No longer required, can be nullable
  FhirCode<PatientGender>? gender;
  
  // Convert to immutable FHIR resource when complete
  Patient toResource() {
    // Validate required fields
    if (name == null || name!.isEmpty) {
      throw Exception('Required field missing: name');
    }
    
    // Convert builders to immutable objects
    final nameResources = name!.map((n) => n.toResource()).toList();
    
    // Return immutable resource
    return Patient(
      name: nameResources,
      gender: gender,
    );
  }
  
  // Other methods...
}
```

Key characteristics of builders:
- No required fields
- All fields are nullable
- Fields are mutable
- Provide methods to convert to immutable resources

## Creating and Using the Mapping Engine

### Engine Creation

Like the parser, the mapping engine must be created asynchronously:

```dart
// Create a resource cache
final resourceCache = CanonicalResourceManager();

// Load a StructureMap (possibly from the parser)
final structureMap = /* your StructureMap */;

// Create the mapping engine
final mapEngine = await FhirMapEngine.create(resourceCache, structureMap);
```

### Basic Transformation

The simplest way to transform data is with the `transform` or `transformFromFhir` methods:

```dart
// Transform a source resource to a target using the loaded map
Future<Resource> transformPatientToPerson(Patient patient) async {
  // If no target is provided, one will be created based on the map's target type
  final result = await mapEngine.transformFromFhir(
    patient,          // Source resource
    structureMap,     // The StructureMap to use
    null,             // Optional target resource (null means create new)
  );
  
  // Cast the result to the expected type
  return result as Person;
}
```

### Working with Builders

For more control or when dealing with partially constructed resources, you can work directly with builders:

```dart
Future<Resource?> transformWithBuilders(
  FhirBaseBuilder source,
  StructureMap map,
  FhirBaseBuilder? target,
) async {
  // Create the engine
  final mapEngine = await FhirMapEngine.create(resourceCache, map);
  
  // Transform using builders
  final transformedBuilder = await mapEngine.transformBuilder(
    '',        // Optional group name (empty uses the default group)
    source,    // Source resource builder
    map,       // The StructureMap to use
    target,    // Target resource builder (can be null)
  );
  
  // Convert the builder to a resource if transformation succeeded
  return transformedBuilder?.build();
}
```

### Extended Type Creation

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

## Advanced Mapping Features

### Working with Different Resource Caches

You can select the appropriate resource cache based on your needs:

```dart
// For local-only operation
final localCache = CanonicalResourceManager();
localCache.saveCanonicalResource(structureDefinitionA);
localCache.saveCanonicalResource(valueSetB);

// For mixed local/online operation
final onlineCache = OnlineResourceManager();
onlineCache.saveCanonicalResource(structureDefinitionA);  // Priority local cache
// Other resources will be fetched from online sources if needed
```

### Handling Transformation Context

The mapping engine maintains a transformation context during execution:

```dart
// The context is created automatically during engine creation
final context = TransformationContext(resolver);

// You can access the context during or after mapping
final generatedResources = context.getGeneratedResources();
```

### Pre-loading Required Resources

For optimal performance, pre-load resources the mapping will need:

```dart
// Pre-load structure definitions
final resourceCache = CanonicalResourceManager()
  ..saveCanonicalResource(structureDefinitionA)
  ..saveCanonicalResource(structureDefinitionB)
  ..saveCanonicalResource(valueSetC);

// Create the engine with the pre-loaded cache
final mapEngine = await FhirMapEngine.create(resourceCache, structureMap);
```

## Complete Example

Here's a complete example that demonstrates the mapping process:

```dart
import 'package:fhir_r4/fhir_r4.dart';
import 'package:fhir_r4_mapping/fhir_r4_mapping.dart';

Future<void> main() async {
  // Step 1: Set up resource cache
  final resourceCache = OnlineResourceManager();
  
  // Step 2: Pre-load any local resources
  resourceCache.saveCanonicalResource(await loadStructureDefinition('patient.json'));
  resourceCache.saveCanonicalResource(await loadStructureDefinition('person.json'));
  
  // Step 3: Create or load the StructureMap
  final parser = await StructureMapParser.create();
  final mapContent = await File('patient_to_person.map').readAsString();
  final structureMap = parser.parse(mapContent, 'fhirmap');
  
  // Step 4: Create the mapping engine
  final mapEngine = await FhirMapEngine.create(resourceCache, structureMap);
  
  // Step 5: Load source data
  final patientJson = jsonDecode(await File('sample_patient.json').readAsString());
  final patient = Patient.fromJson(patientJson);
  
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
  final person = result as Person;
  print('Transformed patient to person: ${person.name?.first.family}');
  
  // Step 9: Serialize the result if needed
  final personJson = person.toJson();
  await File('transformed_person.json').writeAsString(jsonEncode(personJson));
}

// Helper function to load structure definitions
Future<Resource> loadStructureDefinition(String filename) async {
  final json = jsonDecode(await File(filename).readAsString());
  return StructureDefinition.fromJson(json);
}
```

## Testing Mappings

For testing purposes, FHIR-FLI provides a convenience function:

```dart
Future<FhirBase?> fhirMappingEngine(
  FhirBaseBuilder source,
  StructureMap map,
  ResourceCache cache,
  FhirBaseBuilder? target, [
  FhirBaseBuilder? Function(String)? extendedEmptyFromType,
]) async {
  final mapEngine = await FhirMapEngine.create(cache, map)
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

## Best Practices

1. **Reuse engines** for repeated transformations of the same map
2. **Pre-load resources** in the cache for performance
3. **Select the appropriate cache level** based on your connectivity needs
4. **Use builders** for complex or incremental transformations
5. **Implement custom type handlers** for domain-specific resource types
6. **Test maps thoroughly** with representative data

## Limitations and Considerations

- Mapping complex nested structures may require multiple passes
- Some complex FHIR mapping features might have performance implications
- Resource resolution from online sources introduces latency
- Circular references in maps should be handled carefully

## Next Steps

With a solid understanding of the FHIR Mapping engine, you're ready to implement complex data transformations in your FHIR-FLI applications. Consider exploring the following:

- Creating mapping libraries for common transformations
- Integrating mapping with your application's data flow
- Developing domain-specific extensions to the mapping framework
- Contributing improvements back to the FHIR-FLI project