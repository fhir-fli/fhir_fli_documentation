---
id: fhir_r4_cql
title: CQL (Clinical Quality Language)
---

## FHIR R4 CQL

The `fhir_r4_cql` package provides a Clinical Quality Language (CQL) implementation in Dart. It can parse CQL source into an Expression Logic Model (ELM) representation and execute CQL expressions against FHIR data.

Also available as `fhir_r5_cql` and `fhir_r6_cql` for FHIR R5 and R6 with identical APIs.

**Status:** Early development (`0.0.0-dev1`). Pure Dart package.

### What is CQL?

[Clinical Quality Language (CQL)](https://cql.hl7.org/) is a high-level, domain-specific language for expressing clinical knowledge. It is used in:

- **Clinical Quality Measures (CQMs)** - Defining measure logic
- **Clinical Decision Support (CDS)** - Encoding clinical rules
- **Electronic Clinical Quality Improvement (eCQI)** - Quality reporting

CQL works alongside FHIR to express computable clinical logic that can be evaluated against patient data.

### Installation

```yaml
dependencies:
  fhir_r4_cql: ^0.0.0-dev1
  fhir_r4: ^0.4.4
  fhir_r4_path: ^0.4.6
```

### Architecture

The package has four major modules:

#### CQL-to-ELM Translator (`cql_to_elm/`)

Converts CQL source text into ELM expression trees using an ANTLR4-generated parser:

```
CQL Source → Lexer → Parser → AST → Visitors → CqlExpression tree
```

#### Execution Engine (`engine/`)

Evaluates CQL expressions at runtime. Supports 150+ expression types including:

- **Aggregates:** Count, Sum, Avg, Min, Max, StdDev, Variance, Median, Mode
- **Arithmetic:** Abs, Ceiling, Floor, Truncate, Round, Negate, Ln, Log, Power
- **Comparison:** Greater, Less, GreaterOrEqual, LessOrEqual, Equivalent
- **DateTime:** After, Before, SameAs, SameOrAfter, SameOrBefore, DurationBetween
- **Intervals:** Contains, In, Includes, Meets, Overlaps, Starts, Ends, Width
- **Lists:** Union, Intersect, Except, Distinct, Flatten, First, Last, IndexOf
- **Strings:** Combine, Split, IndexOf, PositionOf, Matches, Length, Upper, Lower
- **Clinical:** CalculateAge, InValueSet, InCodeSystem, Retrieve

#### Model Information (`model/`)

Pre-generated type metadata for FHIR (versions 1.0.2 through 4.0.1), QDM, and QUICK models. Loaded at runtime by `StandardModelInfoProvider`.

#### Type System (`engine/types/`)

CQL-specific types: `CqlCode`, `CqlConcept`, `CqlValueSet`, `CqlCodeSystem`, `CqlInterval`, `CqlTuple`.

### Usage

#### Evaluating CQL Expressions

```dart
import 'package:fhir_r4_cql/fhir_r4_cql.dart';
import 'package:fhir_r4/fhir_r4.dart' as fhir;

// Create and evaluate expressions directly
final list = ListExpression(element: [
  LiteralInteger(value: '1'),
  LiteralInteger(value: '2'),
  LiteralInteger(value: '3'),
]);

final count = Count(source: list);
final result = await count.execute({});
// result == fhir.FhirInteger(3)
```

#### Working with CQL Libraries

```dart
// Parse a CQL library
final library = CqlLibrary.fromCql(cqlSource);

// Execute the library
final context = <String, dynamic>{};
final result = await library.execute(context);
```

### Key Dependencies

- **antlr4** - Parser runtime for the CQL grammar
- **fhir_r4** / **fhir_r4_path** - Core FHIR types and FHIRPath evaluation engine
- **ucum** - Units of measure conversion

### CLI Tool

Convert CQL files to ELM JSON (requires a local CQL translation service on port 8080):

```bash
dart run bin/cql_to_json.dart
```

### Resources

- [CQL Specification](https://cql.hl7.org/)
- [CQL Author's Guide](https://cql.hl7.org/02-authorsguide.html)
- [ELM Specification](https://cql.hl7.org/04-logicalspecification.html)
- [GitHub Repository](https://github.com/fhir-fli/fhir_r4)
