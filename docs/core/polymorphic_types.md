---
id: polymorphic_types
title: Polymprhic Types
---

# Polymorphic Types in FHIR-FLI

## Understanding Polymorphic Fields

FHIR resources often include polymorphic fields - fields that can contain different types of data depending on the context. For example, a field might accept a date, a datetime, a period, or even a string in different scenarios. This flexibility is powerful but creates implementation challenges, especially in strongly-typed languages like Dart.

## How FHIR-FLI Handles Polymorphism

FHIR-FLI uses a consistent approach to handle polymorphic fields through abstract classes and clear naming conventions:

### 1. The "X" Naming Convention

Polymorphic fields in FHIR-FLI are typically named with an "X" suffix (e.g., `scheduledX`, `productX`, `subjectX`). This naming convention clearly indicates that the field can contain multiple possible types.

```dart
// Example from CarePlanDetail class
final ScheduledXCarePlanDetail? scheduledX;
final ProductXCarePlanDetail? productX;
```

### 2. Abstract Base Classes

For each polymorphic field, FHIR-FLI defines an abstract class that all potential types for that field will implement:

```dart
// Example abstract class (simplified)
abstract class ScheduledXCarePlanDetail implements FhirBase {
  // Common interface methods
}

// Classes that can be used in this field
class Timing implements ScheduledXCarePlanDetail { ... }
class Period implements ScheduledXCarePlanDetail { ... }
class FhirString implements ScheduledXCarePlanDetail { ... }
```

This approach allows the compiler to verify type safety while maintaining flexibility.

### 3. Type-Specific Getters

To make working with polymorphic fields more intuitive, FHIR-FLI includes type-specific getter methods that return the value only if it matches the requested type:

```dart
// Getters for the scheduledX field in CarePlanDetail
Timing? get scheduledTiming => scheduledX?.isAs<Timing>();
Period? get scheduledPeriod => scheduledX?.isAs<Period>();
FhirString? get scheduledString => scheduledX?.isAs<FhirString>();
```

These getters make it easy to access the field in its correct type without worrying about type casting or runtime errors.

## Working with Polymorphic Fields

### Setting Values

When creating or updating a FHIR resource, you can directly use any valid type for a polymorphic field:

```dart
// Setting a polymorphic field with a specific type
final carePlanDetail = CarePlanDetail(
  status: CarePlanActivityStatus.active,
  scheduledX: Timing(
    repeat: TimingRepeat(
      frequency: FhirPositiveInt(1),
      period: FhirDecimal(1),
      periodUnit: UnitsOfTime.d,
    ),
  ),
  // Other fields...
);

// Alternatively, create with a different type
final anotherCarePlanDetail = CarePlanDetail(
  status: CarePlanActivityStatus.active,
  scheduledX: Period(
    start: FhirDateTime('2023-01-01'),
    end: FhirDateTime('2023-12-31'),
  ),
  // Other fields...
);
```

The library handles the proper serialization and deserialization based on the type provided.

### Checking and Accessing Types

You can check the specific type of a polymorphic field and access it in several ways:

#### 1. Using type-specific getters:

```dart
// Check if scheduledX is a Timing and access it
if (carePlanDetail.scheduledTiming != null) {
  final timing = carePlanDetail.scheduledTiming;
  // Work with timing...
}
```

#### 2. Using the isAs\<T\>() method:

```dart
// Check if productX is a CodeableConcept
if (carePlanDetail.productX?.isAs<CodeableConcept>() != null) {
  final concept = carePlanDetail.productX!.isAs<CodeableConcept>()!;
  // Work with concept...
}
```

#### 3. Using type checking:

```dart
if (carePlanDetail.productX is CodeableConcept) {
  final concept = carePlanDetail.productX as CodeableConcept;
  // Work with concept...
}
```

## Important Considerations

1. **Single Type Limitation**: A polymorphic field can only contain one type at a time. For example, if `scheduledX` contains a `Timing`, it cannot simultaneously contain a `Period` or `FhirString`.

2. **Type Safety**: The abstract class implementation ensures that only valid types can be assigned to polymorphic fields, providing compile-time type safety.

3. **Naming Patterns**: When searching for fields by name, you can use:
   - The base field name with an "X" suffix (e.g., `scheduledX`)
   - The specific type name (e.g., `scheduledTiming`, `scheduledPeriod`)
   - For `getChildrenByName()`, using the specific type name will only return values if the field contains that specific type

4. **Serialization**: When serialized to JSON, the field will be appropriately labeled based on its type, following the FHIR specification.

## Example with Polymorphic Types

Here's a complete example showing how to work with the polymorphic `scheduledX` field in `CarePlanDetail`:

```dart
// Create a CarePlanDetail with a Timing scheduledX
final carePlanWithTiming = CarePlanDetail(
  status: CarePlanActivityStatus.active,
  scheduledX: Timing(
    repeat: TimingRepeat(
      frequency: FhirPositiveInt(2),
      periodUnit: UnitsOfTime.d,
    ),
  ),
);

// Create a CarePlanDetail with a Period scheduledX
final carePlanWithPeriod = CarePlanDetail(
  status: CarePlanActivityStatus.active,
  scheduledX: Period(
    start: FhirDateTime('2023-01-01'),
    end: FhirDateTime('2023-12-31'),
  ),
);

// Accessing the values safely
void processSchedule(CarePlanDetail detail) {
  // Approach 1: Using specific getters
  if (detail.scheduledTiming != null) {
    print('This is a timing-based schedule');
    final frequency = detail.scheduledTiming?.repeat?.frequency?.value;
    print('Frequency: $frequency times');
  } else if (detail.scheduledPeriod != null) {
    print('This is a period-based schedule');
    final start = detail.scheduledPeriod?.start?.value;
    final end = detail.scheduledPeriod?.end?.value;
    print('Period: $start to $end');
  } else if (detail.scheduledString != null) {
    print('This is a string-based schedule');
    print('Description: ${detail.scheduledString?.value}');
  }
}
```

This approach to polymorphic types allows FHIR-FLI to accurately represent the flexibility of the FHIR specification while maintaining the benefits of Dart's strong typing system.