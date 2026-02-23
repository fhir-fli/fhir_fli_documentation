---
id: ucum
title: UCUM Package
---

# UCUM — Unified Code for Units of Measure

The `ucum` package provides a Dart implementation of the [UCUM](https://unitsofmeasure.org/) standard, enabling unit validation, conversion, comparison, and arithmetic for healthcare and scientific measurements. Translated from the official Java reference implementation, it supports all 2000+ UCUM-defined units with arbitrary-precision decimal arithmetic.

### Installation

```yaml
dependencies:
  ucum: ^0.7.0
```

## Quick Start

```dart
import 'package:ucum/ucum.dart';

void main() {
  final ucum = UcumService();

  // Validate a unit string
  final error = ucum.validate('mg/dL');
  print(error); // null — unit is valid

  // Convert 100 mg to grams
  final result = ucum.convert(
    UcumDecimal.fromString('100'),
    'mg',
    'g',
  );
  print(result.asUcumDecimal()); // 0.1

  // Check if two units are comparable
  print(ucum.isComparable('mg', 'g')); // true
  print(ucum.isComparable('mg', 'mL')); // false
}
```

## UcumService

`UcumService` is the main public API. It is a singleton — calling `UcumService()` always returns the same instance.

### Validation

```dart
final ucum = UcumService();

// Returns null if the unit is valid, or an error message
final error = ucum.validate('kg');
print(error); // null

final bad = ucum.validate('not_a_unit');
print(bad); // "not_a_unit is not a valid UCUM unit"
```

### Conversion

```dart
final ucum = UcumService();

// Convert a value from one unit to another
final grams = ucum.convert(
  UcumDecimal.fromString('2.5'),
  'kg',
  'g',
);
print(grams.asUcumDecimal()); // 2500

// Convert temperature
final fahrenheit = ucum.convert(
  UcumDecimal.fromString('37'),
  'Cel',
  '[degF]',
);
print(fahrenheit.asUcumDecimal()); // 98.6
```

### Multiplication and Division

Multiply and divide quantities using `Pair` objects (value + unit):

```dart
final ucum = UcumService();

// Multiply: 5 m * 3 m = 15 m2
final area = ucum.multiply(
  Pair(value: UcumDecimal.fromString('5'), unit: 'm'),
  Pair(value: UcumDecimal.fromString('3'), unit: 'm'),
);
print('${area.value.asUcumDecimal()} ${area.unit}'); // 15 m2

// Divide: 100 mg / 2 dL = 50 mg/dL
final concentration = ucum.divideBy(
  Pair(value: UcumDecimal.fromString('100'), unit: 'mg'),
  Pair(value: UcumDecimal.fromString('2'), unit: 'dL'),
);
print('${concentration.value.asUcumDecimal()} ${concentration.unit}');
// 50 mg/dL
```

### Analysis and Canonical Forms

```dart
final ucum = UcumService();

// Get canonical (base SI) units
print(ucum.getCanonicalUnits('km/h')); // m/s

// Analyse a unit string
print(ucum.analyse('mg/dL')); // g/L

// Get canonical form with converted value
final canonical = ucum.getCanonicalForm(
  Pair(value: UcumDecimal.fromString('60'), unit: 'km/h'),
);
print('${canonical.value.asUcumDecimal()} ${canonical.unit}');
// 16.6666666666666666666667 m/s
```

### Search

```dart
final ucum = UcumService();

// Search for units by name
final results = ucum.search(ConceptKind.unit, 'gram', false);
for (final concept in results) {
  print('${concept.code} — ${concept.names.first}');
}
```

## UcumDecimal

`UcumDecimal` provides arbitrary-precision decimal arithmetic, avoiding floating-point rounding errors that are critical to avoid in healthcare calculations. It tracks precision (significant figures) through all operations.

### Constructors

```dart
// From a string (preserves precision from the string representation)
final a = UcumDecimal.fromString('1.50');  // precision = 3
final b = UcumDecimal.fromString('100');   // precision = 3

// From native numbers
final c = UcumDecimal.fromInt(42);
final d = UcumDecimal.fromDouble(3.14);
final e = UcumDecimal.fromNum(100);
final f = UcumDecimal.fromBigInt(BigInt.from(999));

// Named constructors
final zero = UcumDecimal.zero();
final one = UcumDecimal.one();
```

### Arithmetic

```dart
final a = UcumDecimal.fromString('10.5');
final b = UcumDecimal.fromString('3.2');

final sum = a.add(b);        // 13.7
final diff = a.subtract(b);  // 7.3
final prod = a.multiply(b);  // 33.60
final quot = a.divide(b);    // 3.3

// Integer division and modulo
final intDiv = a.divInt(b);  // 3
final mod = a.modulo(b);     // 0.9
```

### Comparison

```dart
final a = UcumDecimal.fromString('10.0');
final b = UcumDecimal.fromString('10.00');

// String equality (exact representation)
a.equals(b);      // false — different precision

// Numeric value equality
a.equalsValue(b);  // true — same numeric value

// Comparison (-1, 0, 1)
a.comparesTo(b);   // 0
```

## ValidatedQuantity

`ValidatedQuantity` combines a `UcumDecimal` value with a validated UCUM unit string. It supports full arithmetic operators and unit conversion.

### Constructors

```dart
// Standard constructor
final q1 = ValidatedQuantity(
  value: UcumDecimal.fromString('5.0'),
  unit: 'mg',
);

// Parse from string ("value unit" format)
final q2 = ValidatedQuantity.fromString('5.0 mg');

// From native number
final q3 = ValidatedQuantity.fromNumber(5.0, unit: 'mg');
```

### Arithmetic Operators

`ValidatedQuantity` supports `+`, `-`, `*`, `/`, `~/`, and `%` with automatic unit handling:

```dart
final weight1 = ValidatedQuantity.fromString('70 kg');
final weight2 = ValidatedQuantity.fromString('5 kg');

final total = weight1 + weight2;   // 75 kg
final diff = weight1 - weight2;    // 65 kg

// Cross-unit arithmetic converts automatically
final mg = ValidatedQuantity.fromString('500 mg');
final g = ValidatedQuantity.fromString('1 g');
final sum = mg + g;  // 1500 mg (converts to left operand's unit)
```

### Comparison Operators

```dart
final a = ValidatedQuantity.fromString('1 kg');
final b = ValidatedQuantity.fromString('500 g');

print(a > b);   // true (1 kg > 500 g)
print(a == b);   // false
print(a >= b);   // true
```

### Unit Conversion

```dart
final temp = ValidatedQuantity.fromString('100 Cel');
final fahrenheit = temp.convertTo('[degF]');
print(fahrenheit); // 212 [degF]
```

### Duration Support

`ValidatedQuantity` recognizes time units and provides convenient accessors:

```dart
final duration = ValidatedQuantity.fromString('90 min');
print(duration.isDuration);    // true
print(duration.hours);         // 1
print(duration.minutes);       // 30
```

## Pair

`Pair` is a lightweight container holding a `UcumDecimal` value and a unit string. It is the input/output type for `UcumService.multiply()`, `UcumService.divideBy()`, and `UcumService.getCanonicalForm()`.

```dart
final pair = Pair(
  value: UcumDecimal.fromString('100'),
  unit: 'mg',
);

print(pair.value.asUcumDecimal()); // 100
print(pair.unit);                  // mg
```

## Common Healthcare Unit Conversions

```dart
final ucum = UcumService();

// Weight
ucum.convert(UcumDecimal.fromString('1'), '[lb_av]', 'kg');
// 0.45359237 kg

ucum.convert(UcumDecimal.fromString('1'), 'kg', '[lb_av]');
// 2.20462262184877580996888 lb

// Volume
ucum.convert(UcumDecimal.fromString('1'), 'L', 'mL');
// 1000 mL

// Temperature
ucum.convert(UcumDecimal.fromString('37'), 'Cel', '[degF]');
// 98.6 degF

ucum.convert(UcumDecimal.fromString('98.6'), '[degF]', 'Cel');
// 37 Cel

// Length
ucum.convert(UcumDecimal.fromString('1'), '[in_i]', 'cm');
// 2.54 cm

// Time
ucum.convert(UcumDecimal.fromString('1'), 'h', 'min');
// 60 min

// Lab values
ucum.convert(UcumDecimal.fromString('1'), 'mmol/L', 'mol/L');
// 0.001 mol/L
```

## Integration with FHIR

The `ucum` package is used by other FHIR-FLI packages for unit-aware calculations:

- **fhir_r4_path**: The FHIRPath engine uses UCUM for quantity comparisons and arithmetic in expressions like `Observation.value.where(value > 100 'mg')`.
- **FHIR Quantity type**: FHIR resources use UCUM codes in `Quantity.code` fields. Use `UcumService.validate()` to ensure codes are valid UCUM expressions.

```dart
// Validate a FHIR Quantity's unit code
final ucum = UcumService();
final code = 'mg/dL';
final error = ucum.validate(code);
if (error != null) {
  print('Invalid UCUM code: $error');
}
```

The package has no dependency on any FHIR packages and can be used independently in any Dart application that needs unit handling.

## UCUM Specification Reference

For the complete UCUM specification, see [unitsofmeasure.org](https://unitsofmeasure.org/). The package implements the full specification including:

- All 7 SI base units (meter, kilogram, second, ampere, kelvin, mole, candela)
- 20 SI prefixes (yocto through yotta)
- 2000+ defined units across all domains
- Special unit handlers for non-linear conversions (Celsius, Fahrenheit, pH, etc.)
- Arbitrary-precision arithmetic preserving significant figures
