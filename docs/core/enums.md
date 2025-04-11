---
id: enums
title: Enums
---

# Enums

## Understanding FHIR Code Enums

In FHIR, many resources and data types include fields that are restricted to specific coded values (enumerations). FHIR-FLI implements these as "code enums" - specialized `FhirCode` subclasses that combine the flexibility of FHIR's coded values with the type safety of Dart's enum pattern.

FHIR-FLI provides two complementary approaches to enums:

1. **FHIR Code Enum Classes** - `FhirCodeEnum` subclasses with static values and FHIR metadata
2. **Native Dart Enums** - Standard Dart enums paired with FHIR Code Enum classes for maximum flexibility

This dual approach gives you both the rich metadata of FHIR coded values and the convenience of Dart's native enum pattern, including full support for switch statements.

## Core Architecture

FHIR code enums extend the `FhirCodeEnum` class, which itself extends `FhirCode`. This gives them all the capabilities of primitive types while adding enum-like behavior.

```dart
abstract class FhirCodeEnum extends FhirCode {
  // Base implementation
}

class ActionGroupingBehavior extends FhirCodeEnum {
  // Specific implementation with both approaches
}
```

## Using FHIR Code Enums

### Accessing Predefined Values

Each code enum class provides static values that correspond to the codes defined in the FHIR specification:

```dart
// Access predefined values
final groupingBehavior = ActionGroupingBehavior.visualGroup;
final appointmentStatus = AppointmentStatus.booked;

// Access the code's string value
print(groupingBehavior.valueString);  // 'visual-group'

// Access additional metadata
print(groupingBehavior.display?.value);  // 'Visual Group'
print(groupingBehavior.system?.value);   // 'http://hl7.org/fhir/ValueSet/action-grouping-behavior'
```

### Using Native Dart Enums

Each FHIR code enum class is now paired with a native Dart enum, accessible via the `valueEnum` property:

```dart
// Access the native enum value
final nativeEnum = ActionGroupingBehavior.visualGroup.valueEnum;  // ActionGroupingBehaviorEnum.visualGroup

// Use in switch statements
switch (nativeEnum) {
  case ActionGroupingBehaviorEnum.visualGroup:
    // Handle visual group
    break;
  case ActionGroupingBehaviorEnum.logicalGroup:
    // Handle logical group
    break;
  case ActionGroupingBehaviorEnum.sentenceGroup:
    // Handle sentence group
    break;
}
```

### Creating Custom Instances

You can still create custom instances when needed:

```dart
// Create a custom value
final customBehavior = ActionGroupingBehavior(
  'custom-behavior',
  display: FhirString('Custom Grouping Behavior'),
  system: FhirUri('http://example.org/custom-behaviors'),
);

// Note: Custom instances will have valueEnum == null since they don't match predefined enums
```

### Working with Resources

Code enums can be directly assigned to appropriate resource fields:

```dart
final appointment = Appointment(
  status: AppointmentStatus.booked,
  // other fields...
);
```

### Comparing Values

When comparing code enums, you can use the equality operator to check for value equality:

```dart
if (appointment.status == AppointmentStatus.booked) {
  // Handle booked appointment
}
```

### Enhanced Conditional Logic

The native enum integration enables more idiomatic Dart patterns:

```dart
// Traditional approach with equality checks
if (behavior == ActionGroupingBehavior.visualGroup) {
  // Handle visual group
} else if (behavior == ActionGroupingBehavior.logicalGroup) {
  // Handle logical group
}

// String value approach
switch (behavior.valueString) {
  case 'visual-group':
    // Handle visual group
    break;
  case 'logical-group':
    // Handle logical group
    break;
  default:
    // Handle other cases
}

// NEW: Native enum approach with switch statements
switch (behavior.valueEnum) {
  case ActionGroupingBehaviorEnum.visualGroup:
    // Handle visual group
    break;
  case ActionGroupingBehaviorEnum.logicalGroup:
    // Handle logical group
    break;
  case ActionGroupingBehaviorEnum.sentenceGroup:
    // Handle sentence group
    break;
  case null:
    // Handle custom or unknown values
    break;
}
```

## Structure of a FHIR Code Enum Class

Each FHIR code enum class now follows an enhanced pattern that includes a native Dart enum:

1. **Native Dart Enum**: Standard Dart enum for the coded values
2. **Private Constructor**: Used internally for the FHIR code enum class
3. **Public Factory**: For custom creation
4. **Static Const Values**: For each predefined code
5. **Values List**: Containing all predefined values
6. **Helper Methods**: For cloning, modification, etc.

Here's a simplified example based on the implementation:

```dart
// Part 1: Native Dart Enum
enum ActionGroupingBehaviorEnum {
  visualGroup,
  logicalGroup,
  sentenceGroup;

  String toJson() => toString();

  @override
  String toString() {
    switch (this) {
      case ActionGroupingBehaviorEnum.visualGroup:
        return 'visual-group';
      case ActionGroupingBehaviorEnum.logicalGroup:
        return 'logical-group';
      case ActionGroupingBehaviorEnum.sentenceGroup:
        return 'sentence-group';
    }
  }

  static ActionGroupingBehaviorEnum? fromJson(dynamic json) {
    // Implementation
  }

  static ActionGroupingBehaviorEnum? fromString(String? value) {
    // Implementation
  }
}

// Part 2: FHIR Code Enum Class
class ActionGroupingBehavior extends FhirCodeEnum {
  // Private constructor
  const ActionGroupingBehavior._({
    required super.valueString,
    this.valueEnum,
    super.system,
    super.version,
    super.display,
    super.element,
    // Other fields
  }) : super._();

  // Public factory
  factory ActionGroupingBehavior(
    String? rawValue, {
    FhirUri? system,
    FhirString? version,
    FhirString? display,
    // Other parameters
  }) {
    final valueString = 
        rawValue != null ? FhirCode._validateCode(rawValue) : null;
    final valueEnum = ActionGroupingBehaviorEnum.fromString(valueString);
    
    return ActionGroupingBehavior._(
      valueString: valueString,
      valueEnum: valueEnum,
      system: system,
      version: version,
      display: display,
      // Other fields
    );
  }

  // Native enum reference
  final ActionGroupingBehaviorEnum? valueEnum;

  // Predefined static const values
  static const ActionGroupingBehavior visualGroup = ActionGroupingBehavior._(
    valueString: 'visual-group',
    valueEnum: ActionGroupingBehaviorEnum.visualGroup,
    system: FhirUri._(
      valueString: 'http://hl7.org/fhir/ValueSet/action-grouping-behavior',
    ),
    version: FhirString._(valueString: '4.3.0'),
    display: FhirString._(
      valueString: 'Visual Group',
    ),
  );

  // Other predefined values
  static const ActionGroupingBehavior logicalGroup = /* ... */;
  static const ActionGroupingBehavior sentenceGroup = /* ... */;

  // Values list
  static final List<ActionGroupingBehavior> values = [
    visualGroup,
    logicalGroup,
    sentenceGroup,
  ];

  // Helper methods
  // ...
}
```

## Serialization and Deserialization

FHIR code enums are serialized and deserialized like other FHIR primitives, with support for element extensions:

```dart
// Serialization
final json = groupingBehavior.toJson();
// {
//   'value': 'visual-group',
//   '_value': { ... } // If element extensions exist
// }

// Deserialization
final fromJson = ActionGroupingBehavior.fromJson({
  'value': 'visual-group',
  '_value': { ... } // Optional element extensions
});

// The fromJson factory also sets the corresponding valueEnum
final enumValue = fromJson.valueEnum;  // ActionGroupingBehaviorEnum.visualGroup
```

## Advanced Usage

### Element-Only Instances

Like other primitive types, code enums support element-only instances for carrying extensions without a value:

```dart
// Create an element-only instance
final elementOnly = ActionGroupingBehavior(null, element: Element(/* ... */));

// Add extensions
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
final userInput = getUserInput();  // Returns a string
final userBehavior = ActionGroupingBehavior(userInput);

// Check against known values
if (userBehavior.valueEnum != null) {
  // Matches a predefined enum value
} else {
  // Custom value not in the standard set
}
```

### Value Validation

When creating a custom instance, the input is validated according to FHIR's code validation rules:

```dart
// Valid code
final valid = ActionGroupingBehavior('custom-valid-code');

// Invalid code (contains spaces or special characters)
try {
  final invalid = ActionGroupingBehavior('not a valid code');
} catch (e) {
  print('Validation error: $e');
}
```

## Best Practices

1. **Use Predefined Values** whenever possible:
   ```dart
   // Prefer this:
   final behavior = ActionGroupingBehavior.visualGroup;
   
   // Over this:
   final behavior = ActionGroupingBehavior('visual-group');
   ```

2. **Use Native Enums for Switch Statements**:
   ```dart
   // Preferred approach
   switch (behavior.valueEnum) {
     case ActionGroupingBehaviorEnum.visualGroup:
       // Handle visual group
       break;
     // More cases
     case null:
       // Handle custom/unknown values
       break;
   }
   ```

3. **Check for Null** before accessing:
   ```dart
   if (appointment.status?.valueEnum == AppointmentStatusEnum.booked) {
     // Safe access with enum comparison
   }
   ```

4. **Use `values` List** for validation or iteration:
   ```dart
   // Check if value is a standard one
   if (ActionGroupingBehavior.values.contains(behavior)) {
     // Standard value
   }
   
   // Iterate all possible values
   for (final value in ActionGroupingBehavior.values) {
     print('${value.valueString}: ${value.display?.value}');
   }
   ```

5. **Remember Extension Support**:
   ```dart
   // Accessing extensions works the same as other primitives
   final extensions = behavior.element?.extension_;
   ```

## Comparison with Previous FHIR-FLI Approach

| Feature | Current Approach | Previous Approach |
|---------|----------------|-------------------|
| Use in `switch` | Direct via `valueEnum` | By string value only |
| Type safety | Enhanced with native enums | Limited to equality checks |
| Additional metadata | Yes (system, display, etc.) | Yes (same) |
| Custom/dynamic values | Yes, with `valueEnum == null` | Yes |
| Extension support | Yes | Yes |
| Memory efficiency | Similar | Similar |

## Comparison with Standard Dart Enums

| Feature | FHIR Code Enums | Dart Native Enums Only |
|---------|----------------|-------------------|
| FHIR metadata | Yes | No |
| Custom/dynamic values | Yes | No |
| Extension support | Yes | No |
| Use in `switch` | Yes, via `valueEnum` | Yes |
| Memory footprint | Higher | Lower |

## Working with Unknown or Extended Codes

In some cases, you might encounter codes not defined in the standard FHIR value sets. FHIR-FLI allows you to handle these situations:

```dart
// Create a custom code value (will have valueEnum == null)
final extendedBehavior = ActionGroupingBehavior(
  'extended-behavior', 
  system: FhirUri('http://example.org/extended-behaviors'),
  display: FhirString('Extended Grouping Behavior'),
);

// When receiving unknown values from external sources
try {
  final unknownBehavior = ActionGroupingBehavior.fromJson({'value': 'unknown-value'});
  // This will work as long as the value is a valid code format
  // unknownBehavior.valueEnum will be null
} catch (e) {
  // Handle invalid code format
}

// Handling in switch statements
switch (behavior.valueEnum) {
  case ActionGroupingBehaviorEnum.visualGroup:
  case ActionGroupingBehaviorEnum.logicalGroup:
  case ActionGroupingBehaviorEnum.sentenceGroup:
    // Handle standard values
    break;
  case null:
    // This branch handles custom/unknown values
    // You can check behavior.valueString for specific custom values
    if (behavior.valueString == 'extended-behavior') {
      // Handle specific custom value
    } else {
      // Handle other unknown values
    }
    break;
}
```

## Conclusion

FHIR-FLI's enhanced enum approach provides the best of both worlds: the rich metadata and flexibility of FHIR's coded values, combined with the type safety and convenience of Dart's native enum pattern. By pairing each `FhirCodeEnum` class with a corresponding native Dart enum and exposing it via the `valueEnum` property, you can write more idiomatic and maintainable Dart code while still fully supporting the FHIR standard.