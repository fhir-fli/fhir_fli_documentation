---
id: class_structure
title: Class Structure
---

# Class Utility Methods

This document explains the structure and utility methods available in FHIR-FLI classes that allow for flexible manipulation and access to FHIR data.

## Class Structure

Each FHIR resource in the FHIR-FLI libraries is implemented as a Dart class with a consistent structure. Let's examine the key components:

### Constructor and Fields

FHIR classes have a primary constructor with named parameters for all fields defined in the FHIR specification. Fields may be required or optional, and follow the FHIR data model.

```dart
const Age({
  super.id,
  super.extension_,
  super.value,
  super.comparator,
  super.unit,
  super.system,
  super.code,
  super.disallowExtensions,
  super.objectPath = 'Age',
});
```

### Empty Constructor

Each class provides an `.empty()` factory constructor that creates an instance with placeholder values for required fields. This is particularly useful for FHIR mapping operations where you need to initialize objects without specific data yet.

```dart
// Create an empty Age object with minimal initialization
final age = Age.empty();
```

The empty constructor is primarily used in FHIR mapping scenarios and not typically needed by most developers in everyday use.

## Common Utility Methods and Properties

### fhirType Property

The `fhirType` getter returns a string representation of the FHIR type as defined in the FHIR specification:

```dart
@override
String get fhirType => 'Age';
```

It's important to note that the `fhirType` is not always identical to the Dart class name. In cases where a FHIR type name conflicts with Dart keywords or common types (e.g., "List"), the Dart class is named differently (e.g., "FhirList"), but the `fhirType` property still returns the correct FHIR type name ("List").

### Reflection-Like Functionality

Since Flutter doesn't fully support Dart reflection, FHIR-FLI implements several methods to enable reflection-like capabilities:

#### listChildrenNames()

Returns a list of all available field names in the FHIR resource:

```dart
// Get all field names for an Age object
final fieldNames = age.listChildrenNames();
// Result: ['id', 'extension', 'value', 'comparator', 'unit', 'system', 'code']
```

#### getChildrenByName()

Retrieves all matching fields by name. It returns a list of objects, regardless of whether the underlying field is a single value or a list:

```dart
// Get the 'unit' field from an Age object
final units = age.getChildrenByName('unit');
```

Important notes about `getChildrenByName()`:
- The name passed should be the name used in FHIR JSON (not necessarily the exact Dart field name)
- For polymorphic types, you can use the base name, the base name with an "X", or a specific type name
- The optional `checkValid` parameter will throw an error if the field name is invalid

#### getChildByName()

Retrieves a single field value by name:

```dart
// Get the 'value' field from an Age object
final value = age.getChildByName('value');
```

This method will throw an error if the field contains multiple values.

#### setChildByName()

Updates a field by name and returns a new instance with the updated value:

```dart
// Set the 'value' field on an Age object
final newAge = age.setChildByName('value', FhirDecimal(10));
```

#### typeByElementName()

Returns the Dart type(s) that a field can contain:

```dart
// Get the type of the 'value' field
final valueType = age.typeByElementName('value');
// Result: ['FhirDecimal']
```

For polymorphic fields, this method may return multiple possible types.

### Object Manipulation Methods

#### createProperty()

Creates an empty object at a specified field location, primarily used in FHIR mapping operations:

```dart
// Create an empty 'unit' property
final ageWithUnit = age.createProperty('unit');
```

#### clear()

Clears specific fields by setting them to null. This method is necessary because `copyWith()` cannot directly set fields to null:

```dart
// Clear the 'unit' and 'code' fields
final clearedAge = age.clear(unit: true, code: true);
```

#### copyWith()

Creates a new instance with specific fields updated:

```dart
// Create a new Age object with updated value
final updatedAge = age.copyWith(
  value: FhirDecimal(5),
  unit: FhirString('years'),
);
```

#### equalsDeep()

Performs a deep comparison between two instances, checking if all field values are equal:

```dart
// Check if two Age objects are deeply equal
final areEqual = age1.equalsDeep(age2);
```

## Usage Example

Here's how these utility methods might be used together:

```dart
final age = Age(
  value: FhirDecimal(65),
  unit: FhirString('years'),
  system: FhirUri('http://unitsofmeasure.org'),
  code: FhirCode('a'),
);

// Get the FHIR type
print(age.fhirType); // Output: Age

// Get the value field
final valueField = age.getChildByName('value');
print(valueField?.toString()); // Output: 65

// Update a field by name
final updatedAge = age.setChildByName('unit', FhirString('months')) as Age;
print(updatedAge.unit?.value); // Output: months

// Clear a field
final clearedAge = age.clear(system: true);
print(clearedAge.system); // Output: null
```

These utility methods allow for dynamic and flexible manipulation of FHIR resources, even without traditional reflection capabilities.