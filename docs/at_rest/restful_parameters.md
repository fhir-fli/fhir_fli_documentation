---
id: restful_parameters
title: Parameters
---

# RESTful Parameters

## Introduction

The `fhir_r4_at_rest` library provides a streamlined approach to constructing FHIR query parameters through the `RestfulParameters` class and resource-specific search classes. This system allows for type-safe, fluent construction of complex queries without having to manually build query strings.

## Basic Usage

The base `RestfulParameters` class provides a flexible way to add common parameters to any FHIR request:

```dart
final parameters = RestfulParameters()
  .requestPretty()          // Pretty-print the response
  .addCount(20)             // Limit results to 20 items
  .add('_sort', 'date')     // Sort by date
  .add('_include', 'Patient:organization');  // Include referenced Organization resources
```

This can be passed to any `FhirRequest` class:

```dart
final request = FhirReadRequest(
  base: Uri.parse('http://hapi.fhir.org/baseR4'),
  resourceType: 'Patient',
  id: '12345',
  parameters: parameters,
);
```

## Common Parameter Methods

The `RestfulParameters` class includes several convenience methods for commonly used parameters:

### General Parameters

```dart
// Limit results count
parameters.addCount(20);

// Request a specific page
parameters.addPage(2);

// Request pretty-printed responses
parameters.requestPretty();

// Specify response format
parameters.addFormat('json');

// Request summary data
parameters.requestSummary(Summary.true_);
// Other summary options: data, text, count
```

### Custom Parameters

For any parameter not covered by the convenience methods, you can use the generic `add` method:

```dart
// Sort by date descending
parameters.add('_sort', '-date');

// Filter by tag
parameters.add('_tag', 'http://example.org/tags|needs-review');

// Include referenced resources
parameters.add('_include', 'Patient:organization');

// Request elements subset
parameters.add('_elements', 'name,birthDate,gender');
```

## Resource-Specific Search Classes

For more precise control over resource-specific search parameters, the library provides generated search classes for each resource type:

```dart
// Create a Patient search
final patientSearch = SearchPatient()
  .name(FhirString('Smith'))
  .gender(FhirString('male'))
  .birthdate(
    FhirDateTime('1970-01-01'),
    modifier: SearchModifier.ge, // Greater than or equal to
  );

// Use in a search request
final request = FhirSearchRequest(
  base: Uri.parse('http://hapi.fhir.org/baseR4'),
  resourceType: 'Patient',
  search: patientSearch,
);
```

The search classes provide type-safe methods for all valid search parameters defined in the FHIR specification for each resource type.

## Search Modifiers

Many search parameters support modifiers that change how the search is performed:

```dart
// Patient with birthdate greater than or equal to 1970-01-01
patientSearch.birthdate(
  FhirDateTime('1970-01-01'),
  modifier: SearchModifier.ge,
);

// Patient with birthdate less than 2000-01-01
patientSearch.birthdate(
  FhirDateTime('2000-01-01'),
  modifier: SearchModifier.lt,
);

// Patient with a name that exactly equals "John Smith"
patientSearch.name(
  FhirString('John Smith'),
  modifier: SearchModifier.eq,
);
```

Available modifiers depend on the parameter type:

| Parameter Type | Supported Modifiers | Description |
|----------------|---------------------|-------------|
| String | `eq`, `ne` | Exact match, not equal |
| Quantity | `gt`, `lt`, `ge`, `le`, `ap` | Numeric comparisons |
| Date | `gt`, `lt`, `ge`, `le`, `ap` | Date comparisons |

* Token and Reference Search Modifiers are not yet available

## Chaining Multiple Conditions

The fluent API allows for building complex queries by chaining multiple conditions:

```dart
// Find all female patients born after 1980 with the last name "Smith"
final search = SearchPatient()
  .gender(FhirString('female'))
  .birthdate(
    FhirDateTime('1980-01-01'),
    modifier: SearchModifier.gt,
  )
  .family(FhirString('Smith'));

// The resulting query would be:
// Patient?gender=female&gtbirthdate=1980-01-01&family=Smith
```

## Token Parameters

Token parameters (like identifiers) allow for system and value pairs:

```dart
// Search for a patient with a specific MRN
final search = SearchPatient()
  .identifier(
    FhirString('12345'),
    system: FhirUri('http://hospital.example.org/identifiers/mrn'),
  );

// The resulting query would be:
// Patient?identifier=http://hospital.example.org/identifiers/mrn|12345
```

## Quantity Parameters

Quantity parameters include value, unit, and system:

```dart
// Search for observations with systolic blood pressure over 140 mmHg
final search = SearchObservation()
  .code(
    FhirString('8480-6'),
    system: FhirUri('http://loinc.org'),
  )
  .valueQuantity(
    FhirDecimal(140.0),
    unit: FhirString('mm[Hg]'),
    system: FhirUri('http://unitsofmeasure.org'),
    modifier: SearchModifier.gt,
  );
```

## Missing Values

You can search for resources where a parameter is missing using the special `:missing` modifier:

```dart
// Add a parameter directly
parameters.add('gender:missing', 'true');

// Or use the search classes (this will need to be added in a future version)
```

## Combined Searches

For complex searches across multiple resources, you can use the `FhirSearchRequest` with type "All":

```dart
// Search for all resources mentioning "Smith"
final search = SearchResource()
  .parameters.addAll({
    '_type': 'Patient,Practitioner',
    'name': 'Smith',
  });

final request = FhirSearchRequest(
  base: Uri.parse('http://hapi.fhir.org/baseR4'),
  resourceType: 'All',
  search: search,
);
```

## POST Search

For very long or complex queries, you can use POST instead of GET:

```dart
final request = FhirSearchRequest(
  base: Uri.parse('http://hapi.fhir.org/baseR4'),
  resourceType: 'Patient',
  search: patientSearch,
  usePost: true,  // Use POST method
);
```

This will send the search parameters in the request body instead of the URL.

## Building the Query String

When you need to access the raw query string for debugging or other purposes:

```dart
final queryString = parameters.buildQuery();
print(queryString); // _count=20&_pretty=true&_sort=date
```

## Examples of Common Searches

### Patient Search Examples

```dart
// Find patients with a specific MRN
final search = SearchPatient()
  .identifier(
    FhirString('12345'),
    system: FhirUri('http://hospital.example.org/identifiers/mrn'),
  );

// Find patients by name and birthdate range
final search = SearchPatient()
  .name(FhirString('Smith'))
  .birthdate(
    FhirDateTime('1950-01-01'),
    modifier: SearchModifier.ge,
  )
  .birthdate(
    FhirDateTime('1970-01-01'),
    modifier: SearchModifier.le,
  );

// Find patients by address
final search = SearchPatient()
  .addressCity(FhirString('Boston'))
  .addressState(FhirString('MA'));
```

### Observation Search Examples

```dart
// Find blood pressure observations
final search = SearchObservation()
  .code(
    FhirString('85354-9'),
    system: FhirUri('http://loinc.org'),
  )
  .date(
    FhirDateTime('2023-01-01'),
    modifier: SearchModifier.gt,
  );

// Find observations by value range
final search = SearchObservation()
  .code(
    FhirString('8867-4'),
    system: FhirUri('http://loinc.org'),
  ) // Heart rate
  .valueQuantity(
    FhirDecimal(100.0),
    unit: FhirString('/min'),
    modifier: SearchModifier.gt,
  );
```

## Conclusion

The RESTful parameters system in `fhir_r4_at_rest` provides a powerful, type-safe approach to constructing FHIR query parameters. By using the fluent API and resource-specific search classes, you can build complex queries with confidence, knowing that the parameter names and types are validated against the FHIR specification.