---
id: enums
title: Enums
---

# "Enums"

## Understanding FHIR Code Enums

In FHIR, many resources and data types include fields that are restricted to specific coded values (enumerations). FHIR-FLI implements these as "code enums" - specialized `FhirCode` subclasses that combine the flexibility of FHIR's coded values with the convenience of Dart's enum pattern.

Unlike traditional Dart enums, FHIR code enums:

- Are not `const` (cannot be used directly in `switch` statements)
- Contain additional FHIR metadata like system, version, and display text
- Support serialization/deserialization with FHIR's element extensions
- Can be created dynamically with custom values

## Core Architecture

FHIR code enums extend the `FhirCodeEnum` class, which itself extends `FhirCode`. This gives them all the capabilities of primitive types while adding enum-like behavior.

```dart
abstract class FhirCodeEnum extends FhirCode {
  // Base implementation
}

class AccountStatus extends FhirCodeEnum {
  // Specific implementation
}
```

## Using FHIR Code Enums

### Accessing Predefined Values

Each code enum class provides static values that correspond to the codes defined in the FHIR specification:

```dart
// Access predefined values
final status = AccountStatus.active;
final error = AccountStatus.entered_in_error;

// Access the code's string value
print(status.valueString);  // 'active'

// Access additional metadata
print(status.display?.value);  // 'Active'
print(status.system?.value);   // 'http://hl7.org/fhir/ValueSet/account-status'
```

### Creating Custom Instances

You can also create custom instances when needed:

```dart
// Create a custom value
final customStatus = AccountStatus(
  'temporary',
  display: FhirString('Temporary Status'),
  system: FhirUri('http://example.org/custom-statuses'),
);
```

### Working with Resources

Code enums can be directly assigned to appropriate resource fields:

```dart
final account = Account(
  status: AccountStatus.active,
  // other fields...
);
```

### Comparing Values

When comparing code enums, you can use the equality operator to check for value equality:

```dart
if (account.status == AccountStatus.active) {
  // Handle active account
}
```

### In Conditional Logic

Since code enums are not Dart `const` enums, they cannot be used directly in `switch` statements. Instead, you can:

```dart
// Using if-else with the equality operator
if (account.status == AccountStatus.active) {
  // Handle active
} else if (account.status == AccountStatus.inactive) {
  // Handle inactive
}

// Using switch with string values
switch (account.status?.valueString) {
  case 'active':
    // Handle active
    break;
  case 'inactive':
    // Handle inactive
    break;
  default:
    // Handle other cases
}
```

## Structure of a FHIR Code Enum Class

Each FHIR code enum class follows a consistent pattern:

1. **Private Constructor**: Used internally
2. **Public Factory**: For custom creation
3. **Static Final Values**: For each predefined code
4. **Values List**: Containing all predefined values
5. **Helper Methods**: For cloning, modification, etc.

Here's a simplified example:

```dart
class AccountStatus extends FhirCodeEnum {
  // Private constructor
  AccountStatus._({
    required super.valueString,
    super.system,
    super.version,
    super.display,
    // ... other fields
  }) : super._();

  // Public factory
  factory AccountStatus(
    String? rawValue, {
    FhirUri? system,
    FhirString? version,
    FhirString? display,
    // ... other parameters
  }) {
    // Implementation
  }

  // Predefined values
  static final AccountStatus active = AccountStatus._(
    valueString: 'active',
    system: 'http://hl7.org/fhir/ValueSet/account-status'.toFhirUri,
    version: '4.3.0'.toFhirString,
    display: 'Active'.toFhirString,
  );

  static final AccountStatus inactive = AccountStatus._(
    valueString: 'inactive',
    // ... other fields
  );

  // ... other predefined values

  // Values list
  static final List<AccountStatus> values = [
    active,
    inactive,
    // ... other values
  ];

  // Helper methods
  // ...
}
```

## Serialization and Deserialization

FHIR code enums are serialized and deserialized like other FHIR primitives, with support for element extensions:

```dart
// Serialization
final json = accountStatus.toJson();
// {
//   'value': 'active',
//   '_value': { ... } // If element extensions exist
// }

// Deserialization
final fromJson = AccountStatus.fromJson({
  'value': 'active',
  '_value': { ... } // Optional element extensions
});
```

## Advanced Usage

### Element-Only Instances

Like other primitive types, code enums support element-only instances for carrying extensions without a value:

```dart
// Create an element-only instance
final elementOnly = AccountStatus.elementOnly;

// Add an element with extensions
final withExtensions = elementOnly.withElement(
  Element(
    extension_: [
      FhirExtension(
        url: FhirUri('http://example.org/my-extension'),
        valueString: FhirString('Extension value'),
      ),
    ],
  ),
);
```

### Dynamic Creation

In some cases, you might need to create a code enum value dynamically based on user input or other sources:

```dart
// From a string value
final userInput = getUserInput(); // Returns a string
final userStatus = AccountStatus(userInput);

// Check against known values
if (AccountStatus.values.any((v) => v.valueString == userStatus.valueString)) {
  // Valid predefined value
} else {
  // Custom value
}
```

### Value Validation

When creating a custom instance, the input is validated according to FHIR's code validation rules:

```dart
// Valid code
final valid = AccountStatus('custom-valid-code');

// Invalid code (contains spaces or special characters)
try {
  final invalid = AccountStatus('not a valid code');
} catch (e) {
  print('Validation error: $e');
}
```

## Best Practices

1. **Use Predefined Values** whenever possible:
   ```dart
   // Prefer this:
   final status = AccountStatus.active;
   
   // Over this:
   final status = AccountStatus('active');
   ```

2. **For Switch Statements**, use the string value:
   ```dart
   switch (status.valueString) {
     case 'active':
       // Handle active
       break;
     // More cases
   }
   ```

3. **Check for Null** before accessing:
   ```dart
   if (account.status?.valueString == 'active') {
     // Safe access
   }
   ```

4. **Use `values` List** for validation or iteration:
   ```dart
   // Check if value is a standard one
   if (AccountStatus.values.contains(status)) {
     // Standard value
   }
   
   // Iterate all possible values
   for (final value in AccountStatus.values) {
     print('${value.valueString}: ${value.display?.value}');
   }
   ```

5. **Remember Extension Support**:
   ```dart
   // Accessing extensions works the same as other primitives
   final extensions = status.element?.extension_;
   ```

## Common FHIR Code Enum Types

FHIR-FLI includes code enum classes for all coded value sets in FHIR, such as:

- `AdministrativeGender`
- `AppointmentStatus`
- `ContactPointSystem`
- `DeviceStatus`
- `ObservationStatus`
- `ResourceType`
- And many more...

## Limitations

1. **Not Dart `const` Enums**: Cannot be used directly in `switch` statements or with Dart's enum utilities
2. **Memory Usage**: Having all predefined values as static fields can increase memory usage compared to true Dart enums
3. **Type Safety**: Custom values can be created that aren't part of the predefined set, requiring additional validation if strict conformance is needed

## Working with Unknown or Extended Codes

In some cases, you might encounter codes not defined in the standard FHIR value sets. FHIR-FLI allows you to handle these situations:

```dart
// Create a custom code value
final extendedStatus = AccountStatus(
  'extended-status', 
  system: FhirUri('http://example.org/extended-statuses'),
  display: FhirString('Extended Status'),
);

// When receiving unknown values from external sources
try {
  final unknownStatus = AccountStatus.fromJson({'value': 'unknown-value'});
  // This will work as long as the value is a valid code format
} catch (e) {
  // Handle invalid code format
}
```

## Comparison with Dart Enums

| Feature | FHIR Code Enums | Dart Native Enums |
|---------|----------------|-------------------|
| `const` | No | Yes |
| Use in `switch` | By string value only | Direct |
| Additional metadata | Yes (system, display, etc.) | No |
| Custom/dynamic values | Yes | No |
| Extension support | Yes | No |
| Value validation | Yes | N/A |
| Memory footprint | Higher | Lower |