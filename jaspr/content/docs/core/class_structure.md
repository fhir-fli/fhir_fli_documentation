---
id: class_structure
title: Class Structure
---

## Class Utility Methods

This document explains the structure and utility methods available in FHIR-FLI classes that allow for flexible manipulation and access to FHIR data.

### Class Structure

Each FHIR resource in the FHIR-FLI libraries is implemented as a Dart class with a consistent structure. Let's examine the key components:

#### Constructor and Fields

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
});
```

All of these classes are immutable. If you need mutable objects (for example, to build up a resource incrementally during a FHIR mapping operation), the [fhir_r4_mapping](docs/mapping/fhir_mapping) package provides a parallel set of mutable Builder classes for that purpose.

### Common Utility Methods and Properties

#### fhirType Property

The `fhirType` getter returns a string representation of the FHIR type as defined in the FHIR specification:

```dart
@override
String get fhirType => 'Age';
```

It's important to note that the `fhirType` is not always identical to the Dart class name. In cases where a FHIR type name conflicts with Dart keywords or common types (e.g., "List"), the Dart class is named differently (e.g., "FhirList"), but the `fhirType` property still returns the correct FHIR type name ("List").

#### Reflection-Like Functionality

Since Flutter doesn't fully support Dart reflection, FHIR-FLI implements several methods to enable reflection-like capabilities. These methods (`fhirType`, `listChildrenNames`, `getChildrenByName`, `getChildByName`, and friends) make up the `FhirNode` contract from [`package:fhir_node`](https://pub.dev/packages/fhir_node), which `FhirBase` implements - it's the same contract the model-independent `fhir_path` and `cql` engines use to navigate resources.

##### listChildrenNames()

Returns a list of all available field names in the FHIR resource:

```dart
// Get all field names for an Age object
final fieldNames = age.listChildrenNames();
// Result: ['id', 'extension', 'value', 'comparator', 'unit', 'system', 'code']
```

##### getChildrenByName()

Retrieves all matching fields by name. It returns a list of objects, regardless of whether the underlying field is a single value or a list:

```dart
// Get the 'unit' field from an Age object
final units = age.getChildrenByName('unit');
```

Important notes about `getChildrenByName()`:
- The name passed should be the name used in FHIR JSON (not necessarily the exact Dart field name)
- For polymorphic types, you can use the base name, the base name with an "X", or a specific type name
- The optional `checkValid` parameter will throw an error if the field name is invalid

##### getChildByName()

Retrieves a single field value by name:

```dart
// Get the 'value' field from an Age object
final value = age.getChildByName('value');
```

This method will throw an error if the field contains multiple values.

For polymorphic fields, this method may return multiple possible types.

#### Object Manipulation Methods

##### copyWith()

Creates a new instance with specific fields updated:

```dart
// Create a new Age object with updated value
final updatedAge = age.copyWith(
  value: FhirDecimal(5),
  unit: FhirString('years'),
);
```

Importantly, similar to freezed, you CAN now pass a null value to clear a field if you so wish. (If the field is required by the FHIR specification, passing null keeps the current value instead of clearing it.)

##### equalsDeep()

Performs a deep comparison between two instances, checking if all field values are equal:

```dart
// Check if two Age objects are deeply equal
final areEqual = age1.equalsDeep(age2);
```

There are also null-safe static helpers on `FhirBase` for comparing possibly-null values and lists:

```dart
// Both may be null - two nulls are considered equal
final sameValue = FhirBase.equalsDeepWithNull(age1.value, age2.value);

// Element-by-element deep comparison of two lists
final sameNames = FhirBase.listEquals(patient1.name, patient2.name);
```

### Usage Example

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

// Update a field with copyWith
final updatedAge = age.copyWith(unit: FhirString('months'));
print(updatedAge.unit?.valueString); // Output: months

```

These utility methods allow for dynamic and flexible manipulation of FHIR resources, even without traditional reflection capabilities.