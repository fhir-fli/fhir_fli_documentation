---
id: fhir_r4_validation
title: Validation Package
---

# FHIR R4 Validation

The `fhir_r4_validation` library provides comprehensive validation functionality for FHIR R4 resources. It validates resources against their StructureDefinitions, checking structure, cardinality, bindings, extensions, and invariants to ensure compliance with the FHIR specification.

## Installation

```yaml
dependencies:
  fhir_r4_validation: ^0.4.0
  fhir_r4: ^0.4.3
  fhir_r4_path: ^0.4.4
```

## Key Features

- **Structure Validation**: Validates that resources conform to their StructureDefinition
- **Cardinality Validation**: Ensures required fields are present and cardinality constraints are met
- **Binding Validation**: Validates code bindings against ValueSets and CodeSystems
- **Extension Validation**: Validates extensions and their structure
- **Invariant Validation**: Validates FHIRPath invariants defined in StructureDefinitions
- **Questionnaire Response Validation**: Specialized validation for QuestionnaireResponse resources

## Basic Usage

### Validating a FHIR Resource

The simplest way to validate a FHIR resource is using the `FhirValidationEngine`:

```dart
import 'package:fhir_r4/fhir_r4.dart';
import 'package:fhir_r4_validation/fhir_r4_validation.dart';

void main() async {
  // Create a patient resource
  final patient = Patient(
    name: [
      HumanName(
        family: 'Doe'.toFhirString,
        given: ['John'.toFhirString],
      ),
    ],
  );

  // Create validation engine
  final validator = FhirValidationEngine();

  // Validate the resource
  final results = await validator.validateFhirResource(
    structureToValidate: patient,
  );

  // Check for errors
  if (results.hasErrors) {
    print('Validation errors found:');
    for (final error in results.results.where((r) => r.severity == Severity.error)) {
      print('  ${error.path}: ${error.diagnostics}');
    }
  } else {
    print('Resource is valid!');
  }
}
```

### Validating from JSON

You can also validate resources from JSON strings or maps:

```dart
// From JSON string
final jsonString = '''
{
  "resourceType": "Patient",
  "name": [{
    "family": "Doe",
    "given": ["John"]
  }]
}
''';

final results = await validator.validateFhirString(
  structureToValidate: jsonString,
);

// From JSON map
final jsonMap = {
  'resourceType': 'Patient',
  'name': [
    {
      'family': 'Doe',
      'given': ['John']
    }
  ]
};

final results = await validator.validateFhirMap(
  structureToValidate: jsonMap,
);
```

## Validation Results

The `ValidationResults` class provides detailed information about validation outcomes:

```dart
final results = await validator.validateFhirResource(
  structureToValidate: patient,
);

// Check if there are any errors
if (results.hasErrors) {
  // Handle errors
}

// Access all results
for (final result in results.results) {
  print('${result.severity}: ${result.path} - ${result.diagnostics}');
}

// Get results by severity
final errors = results.results.where((r) => r.severity == Severity.error);
final warnings = results.results.where((r) => r.severity == Severity.warning);
final info = results.results.where((r) => r.severity == Severity.information);

// Convert to JSON
final jsonResults = results.toJson();
```

### ValidationDiagnostics

Each validation result contains:

- `path`: The path to the element that failed validation
- `diagnostics`: A description of the validation issue
- `severity`: The severity level (error, warning, or information)
- `line` and `column`: Location information (if available)

## Validation Types

The validation engine performs several types of validation:

### 1. Structure Validation

Validates that the resource structure matches its StructureDefinition:

```dart
// Validates:
// - All elements are defined in the StructureDefinition
// - Element types are correct
// - Nested structures are valid
```

### 2. Cardinality Validation

Ensures that required fields are present and cardinality constraints are met:

```dart
// Validates:
// - Required elements (min > 0) are present
// - Maximum cardinality is not exceeded
// - Array sizes are within bounds
```

### 3. Binding Validation

Validates code bindings against ValueSets and CodeSystems:

```dart
// Validates:
// - Code values are valid according to the binding
// - CodeSystem references are correct
// - ValueSet expansions are valid
```

### 4. Extension Validation

Validates extensions and their structure:

```dart
// Validates:
// - Extension URLs are valid
// - Extension structures match their definitions
// - Required extension elements are present
```

### 5. Invariant Validation

Validates FHIRPath invariants defined in StructureDefinitions:

```dart
// Validates:
// - FHIRPath expressions evaluate correctly
// - Invariant conditions are met
```

## Providing StructureDefinitions

By default, the validator will attempt to fetch StructureDefinitions automatically. However, you can provide your own:

```dart
// Provide a StructureDefinition
final structureDef = StructureDefinition(
  url: 'http://hl7.org/fhir/StructureDefinition/Patient'.toFhirUri,
  // ... structure definition content
);

final results = await validator.validateFhirResource(
  structureToValidate: patient,
  structureDefinition: structureDef,
);
```

## Questionnaire Response Validation

The package includes specialized validation for QuestionnaireResponse resources:

```dart
import 'package:fhir_r4_validation/fhir_r4_validation.dart';

// Validate a QuestionnaireResponse against its Questionnaire
final results = await validateQuestionnaireResponse(
  questionnaireResponse: questionnaireResponse,
  questionnaire: questionnaire,
  resourceCache: resourceCache,
);
```

## Error Handling

The validator provides detailed error information:

```dart
try {
  final results = await validator.validateFhirResource(
    structureToValidate: patient,
  );
  
  if (results.hasErrors) {
    // Process errors
    for (final error in results.results.where((r) => r.severity == Severity.error)) {
      print('Error at ${error.path}: ${error.diagnostics}');
    }
  }
} catch (e) {
  print('Validation failed: $e');
}
```

## Advanced Usage

### Custom HTTP Client

You can provide a custom HTTP client for fetching StructureDefinitions:

```dart
import 'package:http/http.dart';

final client = Client();
final results = await validator.validateFhirResource(
  structureToValidate: patient,
  client: client,
);
```

### Resource Cache

For better performance when validating multiple resources, you can use a resource cache:

```dart
import 'package:fhir_r4_path/fhir_r4_path.dart';

final resourceCache = CanonicalResourceCache();

// The validator will use the cache to avoid re-fetching StructureDefinitions
```

## Example: Complete Validation Workflow

```dart
import 'package:fhir_r4/fhir_r4.dart';
import 'package:fhir_r4_validation/fhir_r4_validation.dart';

Future<void> validatePatient(Patient patient) async {
  final validator = FhirValidationEngine();
  
  final results = await validator.validateFhirResource(
    structureToValidate: patient,
  );
  
  if (results.hasErrors) {
    print('Validation failed with ${results.results.where((r) => r.severity == Severity.error).length} errors:');
    
    for (final error in results.results.where((r) => r.severity == Severity.error)) {
      print('  ❌ ${error.path}: ${error.diagnostics}');
    }
    
    for (final warning in results.results.where((r) => r.severity == Severity.warning)) {
      print('  ⚠️  ${warning.path}: ${warning.diagnostics}');
    }
  } else {
    print('✅ Patient resource is valid!');
    
    if (results.results.any((r) => r.severity == Severity.warning)) {
      print('Warnings:');
      for (final warning in results.results.where((r) => r.severity == Severity.warning)) {
        print('  ⚠️  ${warning.path}: ${warning.diagnostics}');
      }
    }
  }
  
  // Export results as JSON
  final jsonResults = results.toJson();
  print('\nValidation results (JSON):');
  print(jsonEncode(jsonResults));
}
```

## Performance Considerations

- StructureDefinitions are cached automatically to avoid redundant fetching
- For batch validation, reuse the `FhirValidationEngine` instance
- Consider providing StructureDefinitions directly if you have them available
- Use a `ResourceCache` for better performance with multiple validations

## Integration with Other Packages

The validation package integrates seamlessly with other FHIR-FLI packages:

- **fhir_r4**: Uses FHIR resource models
- **fhir_r4_path**: Uses FHIRPath for invariant validation
- **fhir_r4_db**: Can validate resources before saving to the database
- **fhir_r4_at_rest**: Can validate resources before sending to a FHIR server

## Conclusion

The `fhir_r4_validation` package provides comprehensive validation capabilities for FHIR resources, ensuring they conform to the FHIR specification. Whether you're validating resources before saving them, before sending them to a server, or as part of a data quality pipeline, this package provides the tools you need to ensure FHIR compliance.

