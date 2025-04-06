---
id: primitive_types
title: Primitive Types
---

# Primitive Types in FHIR-FLI

## Understanding FHIR Primitive Types

Primitive types are the fundamental building blocks of FHIR resources. While they appear simple (booleans, strings, numbers, etc.), FHIR defines specific validation rules and formats for each primitive type that differ from standard Dart types. FHIR-FLI implements these with strong typing and additional functionality.

In FHIR-FLI, all primitive types:

- Are subclasses of `PrimitiveType`, which extends `FhirBase`
- Store their values internally as strings for consistent serialization
- Include optional metadata via the `Element` class
- Provide appropriate getters to access values in their natural Dart types
- Support polymorphism and can be used in various resource fields

## Core Architecture

### Internal Representation

All FHIR primitive types in FHIR-FLI store their primary value as a string:

```dart
// Inside PrimitiveType class
final String? valueString;
```

This approach ensures consistent serialization and supports FHIR's extensibility model. When you create a primitive type instance, your input value is validated and converted to a string representation.

### Element Metadata

FHIR primitive types can include an `Element` instance that contains metadata like extensions:

```dart
// Inside PrimitiveType class
final Element? element;
```

This allows primitives to carry extensions and other metadata alongside their core value.

## Common Primitive Type Structure

All primitive types follow a consistent pattern:

1. **Extension methods** on relevant Dart types for easy conversion
2. **Private constructor** for internal use
3. **Public factories** for instance creation
4. **JSON/YAML constructors** for serialization/deserialization
5. **Convenience getters** for accessing the value in appropriate Dart types
6. **Boolean state checkers** for checking value/element presence
7. **Utility methods** for manipulation and comparison

Here's a class diagram showing the inheritance and common interface for primitive types:

```
FhirBase
   |
   +--> PrimitiveType
            |
            +--> FhirBoolean
            +--> FhirDecimal
            +--> FhirInteger
            +--> FhirString
            +--> FhirUri
            +--> FhirDateTime
            +--> FhirDate
            +--> FhirTime
            +--> FhirInstant
            ...
```

## Working with Primitive Types

### Creating Primitive Types

You can create primitive types in several ways:

```dart
// Direct constructor with native type
final myBoolean = FhirBoolean(true);
final myDecimal = FhirDecimal(42.5);

// From string representation
final myUri = FhirUri('http://example.org');

// Using extension methods
final boolFromNative = true.toFhirBoolean;
final uriFromNative = 'http://example.org'.toFhirUri;
```

### Reading Values

Each primitive type provides typed getters to access its value in the appropriate Dart type:

```dart
// Boolean example
final bool? nativeValue = myBoolean.valueBoolean;

// DateTime example
final DateTime? dateTimeValue = myFhirDateTime.valueDateTime;

// Uri example
final Uri? uriValue = myUri.valueUri;
```

### Value-only vs Element-only vs Both

FHIR primitives can exist in three states:

1. **Value-only**: Contains just the primitive value
2. **Element-only**: Contains just metadata (extensions)
3. **Value and Element**: Contains both value and metadata

Helper properties let you check which state applies:

```dart
if (myBoolean.valueOnly) {
  // Just a boolean value, no extensions
}

if (myBoolean.hasElementOnly) {
  // Contains extensions but no value
}

if (myBoolean.valueAndElement) {
  // Contains both a value and extensions
}
```

## Specific Primitive Types

### Boolean (FhirBoolean)

Represents FHIR `boolean` type:

```dart
// Creating a boolean
final myBoolean = FhirBoolean(true);

// Using extension method
final myBoolean2 = true.toFhirBoolean;

// Accessing the value
final bool? value = myBoolean.valueBoolean;
```

### String Types (FhirString, FhirCode, FhirId, FhirMarkdown, etc.)

Various string-based types with different validation rules:

```dart
// Creating string types
final myString = FhirString('Hello, FHIR!');
final myCode = FhirCode('active');
final myId = FhirId('patient-123');

// Using extension method
final myString2 = 'Hello, FHIR!'.toFhirString;

// Accessing values
final String? stringValue = myString.value;
```

### URI Types (FhirUri, FhirUrl, FhirCanonical, FhirOid)

URI-based types with different validation rules:

```dart
// Creating URI types
final myUri = FhirUri('http://example.org');
final myUrl = FhirUrl('http://example.org/fhir/Patient/123');

// From Uri object
final dartUri = Uri.parse('http://example.org');
final myUri2 = dartUri.toFhirUri;

// Using extension method
final myUri3 = 'http://example.org'.toFhirUri;

// Accessing values
final Uri? uriValue = myUri.valueUri;
final String? stringValue = myUri.valueString;

// Additional URI helpers
final host = myUri.host;         // 'example.org'
final pathSegments = myUri.pathSegments;
```

### Numeric Types (FhirInteger, FhirDecimal, etc.)

Various numeric types with different validation rules:

```dart
// Creating numeric types
final myInteger = FhirInteger(42);
final myDecimal = FhirDecimal(3.14159);
final myPositiveInt = FhirPositiveInt(10);

// Using extension methods
final myInt2 = 42.toFhirInteger;
final myDecimal2 = 3.14159.toFhirDecimal;

// Accessing values
final int? intValue = myInteger.valueInteger;
final double? decimalValue = myDecimal.valueDecimal;
```

### Date and Time Types

FHIR has multiple date/time types, all inherited from a common base:

```dart
// Creating date/time types
final myDateTime = FhirDateTime('2023-06-15T13:30:45Z');
final myDate = FhirDate('2023-06-15');
final myTime = FhirTime('13:30:45');
final myInstant = FhirInstant('2023-06-15T13:30:45.123Z');

// From DateTime object
final dartDateTime = DateTime.now();
final myDateTime2 = dartDateTime.toFhirDateTime;

// Using extension methods
final myDateTime3 = '2023-06-15T13:30:45Z'.toFhirDateTime;

// Accessing components
final int? year = myDateTime.year;
final int? month = myDateTime.month;
final int? day = myDateTime.day;
final int? hour = myDateTime.hour;

// Accessing as DateTime
final DateTime? dateTimeValue = myDateTime.valueDateTime;

// Comparing dates
if (myDateTime > someOtherDateTime) {
  // Date comparison
}

// Arithmetic with dates (using ExtendedDuration)
final oneWeekLater = myDateTime + ExtendedDuration(weeks: 1);
final oneDayEarlier = myDateTime - ExtendedDuration(days: 1);
```

## Date/Time Precision and Comparisons

FHIR date/time types follow FHIRPath rules for precision when comparing values. For example:

- A date-only value (`2023-06-15`) represents the entire day
- A date-time without seconds (`2023-06-15T13:30`) represents the entire minute
- Comparing values with different precisions follows specific rules

```dart
// Per FHIRPath rules, comparing different precision levels returns null (empty)
final dateOnly = FhirDate('2023-06-15');
final dateTimeWithHour = FhirDateTime('2023-06-15T13:00:00');

dateTimeWithHour > dateOnly; // returns null, not true
dateTimeWithHour == dateOnly; // returns null, not true or false
```

## JSON Serialization: The FHIR Element Pattern

FHIR primitive types have a unique serialization pattern that stems from FHIR's XML origins. In XML, primitives can have attributes (like extensions), but JSON doesn't have a native way to attach metadata to primitives. FHIR solves this with a special pattern:

### The "_value" Pattern

For every primitive field in FHIR JSON, there can be a corresponding metadata field with the same name prefixed by an underscore:

```json
{
  "active": true,         // The primitive value
  "_active": {            // The Element with metadata for "active"
    "extension": [{
      "url": "http://example.org/some-extension",
      "valueString": "Some extension value"
    }]
  }
}
```

### How FHIR-FLI Implements This Pattern

FHIR-FLI's primitive types implement special JSON handling to support this pattern:

```dart
// Serializing to JSON
final myBoolean = FhirBoolean(true);
myBoolean.toJson();  // Returns: {"value": true}

// With extensions
final myBooleanWithExt = FhirBoolean(
  true,
  element: Element(
    extension_: [
      FhirExtension(
        url: FhirUri('http://example.org/some-extension'),
        valueString: FhirString('Some extension value')
      )
    ]
  )
);

myBooleanWithExt.toJson();
// Returns: {
//   "value": true,
//   "_value": {
//     "extension": [{
//       "url": "http://example.org/some-extension",
//       "valueString": "Some extension value"
//     }]
//   }
// }

// Deserializing from JSON
final myBooleanFromJson = FhirBoolean.fromJson({
  'value': true,
  '_value': {
    'extension': [
      {
        'url': 'http://example.org/some-extension',
        'valueString': 'Some extension value'
      }
    ]
  }
});
```

### Special Handling in Resources

When primitive types are used within FHIR resources, the resource's `toJson()` and `fromJson()` methods automatically handle the field name transformation:

```dart
// Resource with primitive fields
final patient = Patient(
  active: FhirBoolean(true, 
    element: Element(extension_: [someExtension])
  ),
  // other fields...
);

patient.toJson();
// Returns: {
//   "resourceType": "Patient",
//   "active": true,
//   "_active": {
//     "extension": [...]
//   },
//   // other fields...
// }
```

### List Handling

For lists of primitives, FHIR uses parallel arrays:

```dart
// JSON representation
{
  "name": ["John", "Johnny", "J"],  // Values array
  "_name": [                        // Parallel metadata array
    null,                           // No metadata for "John"
    {                               // Metadata for "Johnny"
      "extension": [...]
    },
    null                            // No metadata for "J"
  ]
}
```

FHIR-FLI handles this with special list methods:

```dart
// Create a list of primitives with metadata
final names = [
  FhirString("John"),
  FhirString("Johnny", element: Element(extension_: [...])),
  FhirString("J")
];

// Convert to parallel arrays JSON
final json = FhirString.toJsonList(names);
// Returns: {
//   "value": ["John", "Johnny", "J"],
//   "_value": [null, {...}, null]
// }

// Parse from parallel arrays
final parsedNames = FhirString.fromJsonList(
  json['value'] as List<dynamic>,
  json['_value'] as List<dynamic>?
);
```

### Important Considerations

1. **Different from Other Classes**: Primitive types have special JSON handling that differs from other FHIR classes to accommodate the FHIR JSON specification.

2. **Field Names**: Within resources, the field name is used for the value and `_fieldName` for metadata. Inside primitive types, these become `value` and `_value`.

3. **Automatic Handling**: Resource classes automatically handle this transformation, so it's only relevant when directly using primitive types' JSON methods.

4. **Complete Serialization**: This approach ensures all metadata (extensions, etc.) is properly preserved when serializing/deserializing FHIR resources.


## Polymorphic Usage

Primitive types implement various interfaces to support polymorphic fields:

```dart
// Example: FhirBoolean implements ValueXExtension
// This allows it to be used in an Extension's value field
final extension = FhirExtension(
  url: FhirUri('http://example.org/my-boolean-extension'),
  valueX: FhirBoolean(true), // Polymorphic usage
);

// You can retrieve the boolean using type-specific getters
final boolValue = extension.valueBoolean?.valueBoolean;
```

## Utility Methods

All primitive types include utility methods for common operations:

```dart
// Equality checks
if (myBoolean == anotherBoolean) { ... }
if (myBoolean.equals(true)) { ... }  // Works with native types too
if (myBoolean.equalsDeep(anotherBoolean)) { ... }  // Deep comparison

// Cloning
final clonedBoolean = myBoolean.clone();

// Creating modified copies
final updatedBoolean = myBoolean.copyWith(newValue: false);

// Clearing fields
final clearedElement = myBoolean.clear(extension_: true);
```

## Best Practices

1. **Use extension methods** for cleaner code when converting from native types:
   ```dart
   // Prefer this:
   final myBoolean = true.toFhirBoolean;
   
   // Over this:
   final myBoolean = FhirBoolean(true);
   ```

2. **Check for null** before accessing value getters:
   ```dart
   final valueOrNull = myBoolean.valueBoolean;
   if (valueOrNull != null) {
     // Use value
   }
   ```

3. **Use typed getters** instead of accessing `valueString` directly:
   ```dart
   // Prefer this:
   final boolValue = myBoolean.valueBoolean;
   
   // Over this:
   final boolString = myBoolean.valueString;
   final boolValue = boolString == 'true';
   ```

4. **Be aware of date/time precision** when comparing values:
   ```dart
   // Different precision requires careful comparison
   if (dateTime1.year == dateTime2.year &&
       dateTime1.month == dateTime2.month &&
       dateTime1.day == dateTime2.day) {
     // Same day regardless of time components
   }
   ```

5. **Use the appropriate type** for each FHIR field:
   ```dart
   // Use the correct type based on the FHIR specification
   final patient = Patient(
     active: FhirBoolean(true),  // Boolean
     birthDate: FhirDate('1990-01-15'),  // Date
     telecom: [ContactPoint(
       value: FhirString('+1-555-123-4567'),  // String
       system: ContactPointSystem.phone,  // Code
     )],
   );
   ```

## Common Pitfalls and Solutions

1. **Problem**: Comparison across different date/time types
   **Solution**: Use the appropriate comparison methods or convert to consistent precision

2. **Problem**: Working with extensions on primitive types
   **Solution**: Check both `valueX` and `_valueX` when deserializing  

3. **Problem**: Unexpected serialization behavior
   **Solution**: Remember that primitives serialize as both `value` and `_value` keys

4. **Problem**: Lost extensions when updating values
   **Solution**: Use `copyWith()` to preserve extensions when changing values