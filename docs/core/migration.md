---
id: migration
title: Migration
---

# Migration Guide: From fhir (old) to fhir_r4 (new)

## Introduction

This guide will help you migrate from the older `fhir` package to the newer, more robust `fhir_r4` package. While the syntax is mostly similar since both packages generate code from the same FHIR specification, there are important structural differences and improvements that require attention during migration.

The good news: Most of your resource construction code will work with minimal changes. The main differences are in how primitive types are handled, how polymorphic fields work, and some improved helper methods.

---

## Table of Contents

1. [Package Installation](#package-installation)
2. [Import Changes](#import-changes)
3. [Primitive Types - The Biggest Change](#primitive-types---the-biggest-change)
4. [Resource Construction](#resource-construction)
5. [Enums and Code Values](#enums-and-code-values)
6. [Polymorphic Types](#polymorphic-types)
7. [Serialization and Deserialization](#serialization-and-deserialization)
8. [Utility Methods](#utility-methods)
9. [Common Migration Patterns](#common-migration-patterns)
10. [Breaking Changes Checklist](#breaking-changes-checklist)

---

## Package Installation

### Old Package
```yaml
dependencies:
  fhir: ^0.x.x
```

### New Package
```yaml
dependencies:
  fhir_r4: ^0.4.2
```

**Action Required:** Update your `pubspec.yaml` and run `flutter pub get`.

---

## Import Changes

### Old Package
```dart
import 'package:fhir/fhir.dart';
```

### New Package
```dart
import 'package:fhir_r4/fhir_r4.dart';
```

**Action Required:** Find and replace all imports throughout your codebase.

---

## Primitive Types - The Biggest Change

This is where you'll encounter the most errors during migration. The old package handled primitive types differently than the new one.

### The Old Way

In the old package, primitive types were simpler wrapper classes:

```dart
// Old package
class FhirId {
  final String? _value;
  final bool _isValid;
  
  String? get value => _value;
  bool get isValid => _isValid;
}

// Usage
final id = FhirId('patient-123');
final idValue = id.value;  // Just the string
```

### The New Way

In the new package, ALL primitive types extend `PrimitiveType` and have a more structured approach:

```dart
// New package
class FhirId extends PrimitiveType {
  final String? valueString;  // The actual value
  final Element? element;     // Metadata/extensions
  
  // Note: No more .value getter in new package!
}

// Usage
final id = FhirId('patient-123');
final idValue = id.valueString;  // Note: .valueString, not .value
```

### Key Differences

| Old Package | New Package | Notes |
|-------------|-------------|-------|
| `.value` | `.valueString` | For accessing the string value |
| No element support | `.element` | Can now carry extensions |
| Simple constructors | Rich constructors | Support for element parameter |
| Limited metadata | Full FHIR support | Proper extension handling |

### Migration Actions

**1. Find and Replace `.value` with `.valueString`**

This is the most common change you'll need to make:

```dart
// Old
if (patient.id?.value == '123') { ... }
final name = patient.name?.first.given?.first.value;

// New
if (patient.id?.valueString == '123') { ... }
final name = patient.name?.first.given?.first.valueString;
```

**2. Update Primitive Type Constructors**

The new package has more ways to create primitives:

```dart
// Old
final str = FhirString('Hello');
final date = FhirDate('2024-01-01');
final id = FhirId('patient-123');

// New - Still works!
final str = FhirString('Hello');
final date = FhirDate('2024-01-01');
final id = FhirId('patient-123');

// New - Extension methods (recommended)
final str = 'Hello'.toFhirString;
final date = '2024-01-01'.toFhirDate;

// New - With element/extensions
final str = FhirString(
  'Hello',
  element: Element(
    extension_: [
      FhirExtension(
        url: FhirUri('http://example.org/ext'),
        valueString: FhirString('metadata'),
      ),
    ],
  ),
);
```

**3. Specific Primitive Type Changes**

Different primitive types have different getter names in the new package:

```dart
// Boolean
// Old: myBool.value  (bool?)
// New: myBool.valueBoolean  (bool?)

// Integer  
// Old: myInt.value  (int?)
// New: myInt.valueInteger  (int?)

// Decimal
// Old: myDecimal.value  (double?)
// New: myDecimal.valueDecimal  (double?)

// DateTime
// Old: myDateTime.value  (DateTime?)
// New: myDateTime.valueDateTime  (DateTime?)

// Date
// Old: myDate.value  (DateTime?)
// New: myDate.valueDateTime  (DateTime?)

// String types (FhirString, FhirMarkdown, etc.)
// Old: myString.value  (String?)
// New: myString.valueString  (String?)

// Uri types (FhirUri, FhirUrl, FhirCanonical, FhirOid, FhirUuid)
// Old: myUri.value  (String?)
// New: myUri.valueString  (String?) OR myUri.valueUri  (Uri?)

// Id
// Old: myId.value  (String?)
// New: myId.valueString  (String?)

// Code
// Old: myCode.value  (String?)
// New: myCode.valueString  (String?)
```

### Search and Replace Strategy

Here's a systematic approach:

1. **Global search for `.value` in your codebase**
2. **For each occurrence, determine the type**:
   - If it's a primitive FHIR type, replace with the appropriate getter
   - If it's not a FHIR type, leave it alone
3. **Use your IDE's type inference** to help identify what needs changing

**Tip:** You can do a regex search for common patterns:
```regex
\.value(?!\w)
```
This will find `.value` but not `.valueString`, `.valueBoolean`, etc.

---

## Resource Construction

Resource construction is largely unchanged, but with improved primitive type handling:

### Old Package
```dart
final patient = Patient(
  id: FhirId('123'),
  name: [
    HumanName(
      family: FhirString('Doe'),
      given: [FhirString('John')],
    ),
  ],
  birthDate: FhirDate('1990-01-01'),
);
```

### New Package
```dart
// Option 1: Same as old (still works!)
final patient = Patient(
  id: FhirId('123'),
  name: [
    HumanName(
      family: FhirString('Doe'),
      given: [FhirString('John')],
    ),
  ],
  birthDate: FhirDate('1990-01-01'),
);

// Option 2: Using extension methods (recommended)
final patient = Patient(
  id: '123'.toFhirId,
  name: [
    HumanName(
      family: 'Doe'.toFhirString,
      given: ['John'.toFhirString],
    ),
  ],
  birthDate: '1990-01-01'.toFhirDate,
);
```

**Migration Impact:** Minimal. Most construction code works as-is, but you should consider adopting extension methods for cleaner code.

---

## Enums and Code Values

This is another significant change. The old package used simpler enum handling, while the new package has a sophisticated dual-enum system.

### Old Package Approach

```dart
// Old package likely used string values or simple enums
final status = 'active';  // or
final status = AppointmentStatus.active;

// In resources
final appointment = Appointment(
  status: status,
  // ...
);

// Checking values
if (appointment.status == 'active') { ... }
```

### New Package Approach

The new package uses `FhirCodeEnum` classes that wrap FHIR codes AND provides native Dart enums:

```dart
// New package - Using the FhirCodeEnum class
final status = AppointmentStatus.booked;  // FhirCodeEnum

// In resources
final appointment = Appointment(
  status: AppointmentStatus.booked,
  // ...
);

// Checking values - Multiple ways:

// 1. Direct equality
if (appointment.status == AppointmentStatus.booked) { ... }

// 2. Using the native enum (recommended for switch statements)
switch (appointment.status?.valueEnum) {
  case AppointmentStatusEnum.booked:
    // Handle booked
    break;
  case AppointmentStatusEnum.cancelled:
    // Handle cancelled
    break;
  case AppointmentStatusEnum.pending:
    // Handle pending
    break;
  case null:
    // Handle null or custom values
    break;
}

// 3. String comparison
if (appointment.status?.valueString == 'booked') { ... }

// Accessing metadata
final system = AppointmentStatus.booked.system;  // FhirUri
final display = AppointmentStatus.booked.display;  // FhirString
```

### Migration Steps for Enums

1. **Replace string literals** with enum values:
```dart
// Old
final status = 'booked';

// New
final status = AppointmentStatus.booked;
```

2. **Update equality checks**:
```dart
// Old
if (status == 'booked') { ... }

// New - Recommended
if (status == AppointmentStatus.booked) { ... }
// OR
if (status?.valueEnum == AppointmentStatusEnum.booked) { ... }
```

3. **Convert switch statements** to use the new enum:
```dart
// Old
switch (status) {
  case 'booked':
    // ...
  case 'cancelled':
    // ...
}

// New - Much better with native enums!
switch (status?.valueEnum) {
  case AppointmentStatusEnum.booked:
    // ...
  case AppointmentStatusEnum.cancelled:
    // ...
  case null:
    // Handle custom or null values
}
```

### Important: Custom Enum Values

The new package supports custom/extended enum values:

```dart
// Create a custom status not in the standard set
final customStatus = AppointmentStatus('custom-value');

// Note: customStatus.valueEnum will be null
// But customStatus.valueString will be 'custom-value'

// Handling in code:
switch (appointment.status?.valueEnum) {
  case AppointmentStatusEnum.booked:
    // Standard value
    break;
  case null:
    // Could be custom or null
    if (appointment.status?.valueString == 'custom-value') {
      // Handle custom
    }
    break;
}
```

---

## Polymorphic Types

Polymorphic fields (those that can contain multiple types) are handled differently.

### Old Package
```dart
// Old package - Less type-safe approach
// Likely used dynamic or Object types
final extension = FhirExtension(
  url: FhirUri('http://example.org/ext'),
  value: FhirString('some value'),  // Could be various types
);

// Accessing required casting
final value = extension.value;
if (value is FhirString) {
  final stringValue = value.value;
}
```

### New Package
```dart
// New package - Type-safe with abstract classes
final extension = FhirExtension(
  url: FhirUri('http://example.org/ext'),
  valueX: FhirString('some value'),  // Note: valueX, not value
);

// Accessing with type-specific getters
final stringValue = extension.valueString;  // FhirString?
final boolValue = extension.valueBoolean;   // FhirBoolean?
final codeValue = extension.valueCode;       // FhirCode?

// Using the generic accessor
if (extension.valueX is FhirString) {
  final str = extension.valueX as FhirString;
  // Use str
}

// Or using the helper method
final str = extension.valueX?.isAs<FhirString>();
if (str != null) {
  // Use str
}
```

### Naming Convention Change

**Old:** Polymorphic fields might have been named `value`, `product`, `subject`, etc.

**New:** Polymorphic fields are named with an `X` suffix: `valueX`, `productX`, `subjectX`, `scheduledX`, etc.

### Migration for Polymorphic Fields

1. **Identify polymorphic fields** in your code (usually documented in FHIR spec as `[x]`)

2. **Rename the field access** to add `X` suffix:
```dart
// Old
final value = extension.value;
final product = carePlan.product;

// New
final value = extension.valueX;
final product = carePlan.productX;
```

3. **Use type-specific getters** instead of casting:
```dart
// Old
if (extension.value is FhirString) {
  final str = (extension.value as FhirString).value;
}

// New - Much cleaner!
if (extension.valueString != null) {
  final str = extension.valueString!.valueString;
}
```

4. **Update type checking**:
```dart
// Old
switch (value.runtimeType) {
  case FhirString:
    // ...
  case FhirBoolean:
    // ...
}

// New - Use getters
if (extension.valueString != null) {
  // It's a string
} else if (extension.valueBoolean != null) {
  // It's a boolean
} else if (extension.valueInteger != null) {
  // It's an integer
}
```

---

## Serialization and Deserialization

Both packages support JSON, but the new package adds YAML and convenience methods.

### JSON Serialization

**Old Package:**
```dart
// To JSON Map
final json = patient.toJson();

// To JSON String (two steps)
final jsonString = jsonEncode(patient.toJson());

// From JSON
final patient = Patient.fromJson(jsonMap);

// From JSON String (two steps)
final jsonMap = jsonDecode(jsonString);
final patient = Patient.fromJson(jsonMap);
```

**New Package:**
```dart
// To JSON Map (same)
final json = patient.toJson();

// To JSON String (one step!)
final jsonString = patient.toJsonString();

// From JSON (same)
final patient = Patient.fromJson(jsonMap);

// From JSON String (one step!)
final patient = Patient.fromJsonString(jsonString);
```

### YAML Support (New!)

```dart
// To YAML String
final yamlString = patient.toYaml();

// From YAML
final patient = Patient.fromYaml(yamlString);
// OR
final patient = Patient.fromYaml(yamlMap);  // YamlMap
```

### Migration Steps

1. **Replace two-step JSON string serialization**:
```dart
// Old
final jsonString = jsonEncode(patient.toJson());

// New
final jsonString = patient.toJsonString();
```

2. **Replace two-step JSON string deserialization**:
```dart
// Old
final patient = Patient.fromJson(jsonDecode(jsonString));

// New
final patient = Patient.fromJsonString(jsonString);
```

3. **Consider adding YAML support** where it makes sense (debugging, configuration, etc.)

---

## Utility Methods

The new package includes powerful reflection-like utilities that weren't in the old package.

### New Utility Methods

#### 1. `listChildrenNames()`
```dart
// Get all field names
final fieldNames = patient.listChildrenNames();
// Returns: ['id', 'meta', 'implicitRules', 'language', 'text', 'contained', ...]
```

#### 2. `getChildrenByName(String name)`
```dart
// Get specific fields by name
final names = patient.getChildrenByName('name');
// Returns: List<FhirBase> containing all name values
```

#### 3. `getChildByName(String name)`
```dart
// Get a single field by name
final id = patient.getChildByName('id');
// Returns: FhirBase? (the id field)
```

#### 4. `copyWith()`
```dart
// Create modified copies (improved from old package)
final updatedPatient = patient.copyWith(
  id: '456'.toFhirId,
  active: true.toFhirBoolean,
);

// New: Can now pass null to clear fields!
final patientWithoutName = patient.copyWith(
  name: null,  // This now works!
);
```

#### 5. `equalsDeep()`
```dart
// Deep equality comparison
final areEqual = patient1.equalsDeep(patient2);
```

### Migration Benefit

These new methods can simplify a lot of dynamic field access code you might have written in the old package.

**Example - Dynamic Field Access:**
```dart
// Old package - Had to know exact structure
String? getPatientName(Patient patient) {
  if (patient.name != null && patient.name!.isNotEmpty) {
    return patient.name!.first.family?.value;
  }
  return null;
}

// New package - Can use reflection-like methods
List<FhirBase> getFieldByName(Patient patient, String fieldName) {
  return patient.getChildrenByName(fieldName);
}

// Get all field names for introspection
void printAllFields(Patient patient) {
  for (final fieldName in patient.listChildrenNames()) {
    print('$fieldName: ${patient.getChildrenByName(fieldName)}');
  }
}
```

---

## Common Migration Patterns

### Pattern 1: Accessing Nested Primitive Values

**Old:**
```dart
final patientName = patient.name?.first.given?.first.value;
final birthDate = patient.birthDate?.value;
```

**New:**
```dart
final patientName = patient.name?.first.given?.first.valueString;
final birthDate = patient.birthDate?.valueDateTime;
```

### Pattern 2: Creating Resources with Primitives

**Old:**
```dart
final observation = Observation(
  status: ObservationStatus.final_,
  code: CodeableConcept(
    coding: [
      Coding(
        system: FhirUri('http://loinc.org'),
        code: FhirCode('8480-6'),
        display: FhirString('Systolic blood pressure'),
      ),
    ],
  ),
  valueQuantity: Quantity(
    value: FhirDecimal(120),
    unit: FhirString('mmHg'),
    system: FhirUri('http://unitsofmeasure.org'),
    code: FhirCode('mm[Hg]'),
  ),
);
```

**New (same structure, but consider extension methods):**
```dart
final observation = Observation(
  status: ObservationStatus.final_,
  code: CodeableConcept(
    coding: [
      Coding(
        system: 'http://loinc.org'.toFhirUri,
        code: '8480-6'.toFhirCode,
        display: 'Systolic blood pressure'.toFhirString,
      ),
    ],
  ),
  valueQuantity: Quantity(
    value: 120.0.toFhirDecimal,
    unit: 'mmHg'.toFhirString,
    system: 'http://unitsofmeasure.org'.toFhirUri,
    code: 'mm[Hg]'.toFhirCode,
  ),
);
```

### Pattern 3: Checking for Null Values

**Old:**
```dart
if (patient.name != null && 
    patient.name!.first.family != null && 
    patient.name!.first.family!.value != null) {
  print(patient.name!.first.family!.value);
}
```

**New:**
```dart
// Same null checking needed
if (patient.name != null && 
    patient.name!.first.family != null && 
    patient.name!.first.family!.valueString != null) {
  print(patient.name!.first.family!.valueString);
}

// OR use null-aware operators
final familyName = patient.name?.first.family?.valueString;
if (familyName != null) {
  print(familyName);
}
```

### Pattern 4: Working with Lists

**Old:**
```dart
final identifiers = patient.identifier?.map((id) => id.value?.value).toList();
```

**New:**
```dart
final identifiers = patient.identifier?.map((id) => id.value?.valueString).toList();
```

### Pattern 5: Polymorphic Extensions

**Old:**
```dart
final extension = FhirExtension(
  url: FhirUri('http://example.org/height'),
  value: Quantity(
    value: FhirDecimal(175),
    unit: FhirString('cm'),
  ),
);

// Accessing
if (extension.value is Quantity) {
  final quantity = extension.value as Quantity;
  final value = quantity.value?.value;
}
```

**New:**
```dart
final extension = FhirExtension(
  url: 'http://example.org/height'.toFhirUri,
  valueX: Quantity(
    value: 175.0.toFhirDecimal,
    unit: 'cm'.toFhirString,
  ),
);

// Accessing - Much cleaner!
final quantity = extension.valueQuantity;
if (quantity != null) {
  final value = quantity.value?.valueDecimal;
}
```

---

## Breaking Changes Checklist

Use this checklist to systematically update your code:

### 1. Imports
- [ ] Replace `import 'package:fhir/fhir.dart'` with `import 'package:fhir_r4/fhir_r4.dart'`
- [ ] Update pubspec.yaml

### 2. Primitive Types
- [ ] Find all `.value` accessors on FHIR primitive types
- [ ] Replace with appropriate typed getters (`.valueString`, `.valueInteger`, `.valueBoolean`, etc.)
- [ ] Update any primitive type constructors if using element/extensions

### 3. Enums
- [ ] Replace string literal enum values with FhirCodeEnum values
- [ ] Update equality checks to use enum values
- [ ] Convert switch statements to use native enums via `.valueEnum`

### 4. Polymorphic Fields
- [ ] Identify all polymorphic fields (those that can be multiple types)
- [ ] Rename field access to add `X` suffix (e.g., `value` → `valueX`)
- [ ] Use type-specific getters instead of casting
- [ ] Update type checking logic

### 5. Serialization
- [ ] Replace `jsonEncode(resource.toJson())` with `resource.toJsonString()`
- [ ] Replace `Resource.fromJson(jsonDecode(string))` with `Resource.fromJsonString(string)`
- [ ] Consider adding YAML support where useful

### 6. Testing
- [ ] Update all tests that check primitive values
- [ ] Update JSON serialization/deserialization tests
- [ ] Add tests for new utility methods if using them
- [ ] Test enum comparisons

### 7. Consider Adopting New Features
- [ ] Use extension methods for primitive type creation
- [ ] Use `copyWith()` with null values where needed
- [ ] Leverage `listChildrenNames()` and `getChildrenByName()` for dynamic access
- [ ] Use YAML for debugging/configuration

---

## Step-by-Step Migration Process

### Phase 1: Setup (30 minutes)
1. Create a new branch for migration
2. Update pubspec.yaml
3. Run `flutter pub get`
4. Update all imports

### Phase 2: Fix Compilation Errors (2-4 hours depending on codebase size)
1. **Start with primitive value accessors:**
   - Search for `.value` globally
   - For each FHIR primitive type, replace with appropriate getter
   - Start with most common types first (FhirString, FhirId, FhirCode)

2. **Fix polymorphic fields:**
   - Search for known polymorphic field names
   - Add `X` suffix
   - Update accessors to use type-specific getters

3. **Update enums:**
   - Replace string literals with enum values
   - Update comparisons

4. **Fix serialization:**
   - Replace two-step JSON operations with convenience methods

### Phase 3: Testing (1-2 hours)
1. Run all existing tests
2. Fix any test failures
3. Add tests for new patterns if needed

### Phase 4: Optimization (optional, 1-2 hours)
1. Adopt extension methods for cleaner code
2. Use new utility methods where beneficial
3. Add YAML support for debugging
4. Update documentation

---

## Quick Reference Table

| Task | Old Package | New Package |
|------|-------------|-------------|
| Get string value | `.value` | `.valueString` |
| Get int value | `.value` | `.valueInteger` |
| Get bool value | `.value` | `.valueBoolean` |
| Get DateTime value | `.value` | `.valueDateTime` |
| Get double value | `.value` | `.valueDecimal` |
| Create FhirString | `FhirString('text')` | `'text'.toFhirString` |
| Create FhirDate | `FhirDate('2024-01-01')` | `'2024-01-01'.toFhirDate` |
| Enum comparison | `status == 'active'` | `status == Status.active` |
| Polymorphic field | `.value` or `.product` | `.valueX` or `.productX` |
| Type-specific getter | Cast required | `.valueString`, `.valueInteger`, etc. |
| JSON to string | `jsonEncode(x.toJson())` | `x.toJsonString()` |
| String to JSON | `X.fromJson(jsonDecode(s))` | `X.fromJsonString(s)` |
| YAML support | Not available | `.toYaml()`, `.fromYaml()` |

---

## Troubleshooting Common Errors

### Error: "The getter 'value' isn't defined"

**Cause:** Using old `.value` accessor on primitive type.

**Solution:** Replace with typed getter:
```dart
// Error
final name = patient.name?.first.family?.value;

// Fix
final name = patient.name?.first.family?.valueString;
```

### Error: "The argument type 'String' can't be assigned to the parameter type 'AppointmentStatus'"

**Cause:** Trying to use string literal where enum is expected.

**Solution:** Use the enum value:
```dart
// Error
final appointment = Appointment(status: 'booked');

// Fix
final appointment = Appointment(status: AppointmentStatus.booked);
```

### Error: "The getter 'product' isn't defined"

**Cause:** Polymorphic field name changed.

**Solution:** Add `X` suffix:
```dart
// Error
final product = carePlan.detail?.first.product;

// Fix
final product = carePlan.detail?.first.productX;
```

### Error: "The operator '==' isn't defined for the type"

**Cause:** Enum comparison issue.

**Solution:** Use proper enum comparison:
```dart
// Error (comparing incompatible types)
if (status == 'active') { }

// Fix
if (status == AppointmentStatus.booked) { }
// OR
if (status?.valueEnum == AppointmentStatusEnum.booked) { }
```

---

## Example: Complete Migration

### Before (Old Package)
```dart
import 'package:fhir/fhir.dart';

void createPatient() {
  final patient = Patient(
    id: FhirId('patient-123'),
    name: [
      HumanName(
        family: FhirString('Smith'),
        given: [FhirString('John')],
      ),
    ],
    gender: 'male',
    birthDate: FhirDate('1980-05-15'),
    active: FhirBoolean(true),
  );

  // Accessing values
  final id = patient.id?.value;
  final lastName = patient.name?.first.family?.value;
  final firstName = patient.name?.first.given?.first.value;
  final birthDate = patient.birthDate?.value;
  final isActive = patient.active?.value;
  
  // Gender check
  if (patient.gender == 'male') {
    print('Male patient');
  }

  // Serialization
  final jsonString = jsonEncode(patient.toJson());
  
  // Deserialization
  final patientCopy = Patient.fromJson(jsonDecode(jsonString));
}
```

### After (New Package)
```dart
import 'package:fhir_r4/fhir_r4.dart';

void createPatient() {
  final patient = Patient(
    id: '123'.toFhirId,  // Using extension method
    name: [
      HumanName(
        family: 'Smith'.toFhirString,
        given: ['John'.toFhirString],
      ),
    ],
    gender: AdministrativeGender.male,  // Using enum
    birthDate: '1980-05-15'.toFhirDate,
    active: true.toFhirBoolean,
  );

  // Accessing values - Note the different getters!
  final id = patient.id?.valueString;  // Changed!
  final lastName = patient.name?.first.family?.valueString;  // Changed!
  final firstName = patient.name?.first.given?.first.valueString;  // Changed!
  final birthDate = patient.birthDate?.valueDateTime;  // Changed!
  final isActive = patient.active?.valueBoolean;  // Changed!
  
  // Gender check using enum
  if (patient.gender == AdministrativeGender.male) {
    print('Male patient');
  }
  
  // OR using native enum for switch
  switch (patient.gender?.valueEnum) {
    case AdministrativeGenderEnum.male:
      print('Male patient');
      break;
    case AdministrativeGenderEnum.female:
      print('Female patient');
      break;
    case AdministrativeGenderEnum.other:
    case AdministrativeGenderEnum.unknown:
    case null:
      print('Other/Unknown gender');
      break;
  }

  // Serialization - One step!
  final jsonString = patient.toJsonString();
  
  // Deserialization - One step!
  final patientCopy = Patient.fromJsonString(jsonString);
  
  // New: YAML support
  final yamlString = patient.toYaml();
  print(yamlString);  // Pretty-printed YAML
}
```

---

## Getting Help

If you run into issues during migration:

1. **Check the documentation** at the new package's repository
2. **Look at the generated code** - The new package is heavily documented
3. **Use your IDE's type system** - Hover over methods to see return types
4. **Search for similar patterns** in this guide
5. **Create minimal reproducible examples** when asking for help

---

## Summary

The migration from the old `fhir` package to `fhir_r4` involves these key changes:

1. **Primitive type accessors**: `.value` → `.valueString` (or `.valueInteger`, `.valueBoolean`, etc.)
2. **Enum handling**: String literals → FhirCodeEnum values with native enum support
3. **Polymorphic fields**: Add `X` suffix and use type-specific getters
4. **Serialization**: Use convenience methods (`.toJsonString()`, `.fromJsonString()`)
5. **New utilities**: `listChildrenNames()`, `getChildrenByName()`, improved `copyWith()`

While there are breaking changes, the migration is straightforward and systematic. Most errors will be caught at compile-time, making the process safe. The new package offers better type safety, cleaner syntax, and more powerful features that will make your FHIR code more maintainable.

**Estimated migration time:** 
- Small project (< 1000 lines): 2-3 hours
- Medium project (1000-5000 lines): 4-8 hours  
- Large project (5000+ lines): 1-2 days

The investment is worth it for the improved developer experience and type safety!

---

## Additional Resources

- New package documentation (check project README)
- FHIR R4 specification: https://hl7.org/fhir/R4/
- FHIRPath documentation (for integration with fhir_path package)

Good luck with your migration! 🚀