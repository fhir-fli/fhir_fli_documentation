---
id: fhir_r4_cql
title: CQL (Clinical Quality Language)
---

## FHIR R4 CQL

The `fhir_r4_cql` package is the FHIR R4 binding for the model-independent [`cql`](https://pub.dev/packages/cql) engine. The `cql` package translates Clinical Quality Language source into ELM (Expression Logic Model) and executes it, but it is deliberately FHIR-free: all access to FHIR data goes through its `ModelResolver` / `TerminologyProvider` boundary interfaces. `fhir_r4_cql` supplies the FHIR R4 implementations of those interfaces — the analogue of cqframework's `engine.fhir` / `cql-exec-fhir`.

Also available as `fhir_r5_cql` and `fhir_r6_cql` for FHIR R5 and R6 with identical APIs.

### What is CQL?

[Clinical Quality Language (CQL)](https://cql.hl7.org/) is a high-level, domain-specific language for expressing clinical knowledge. It is used in:

- **Clinical Quality Measures (CQMs)** - Defining measure logic
- **Clinical Decision Support (CDS)** - Encoding clinical rules
- **Electronic Clinical Quality Improvement (eCQI)** - Quality reporting

CQL works alongside FHIR to express computable clinical logic that can be evaluated against patient data.

### Installation

```yaml
dependencies:
  fhir_r4_cql: ^0.7.0
```

`fhir_r4_cql` re-exports `package:cql/cql.dart`, so this single dependency gives you the whole engine plus the R4 wiring. If you don't need FHIR at all, you can depend on the engine directly instead (`cql: ^0.6.3`).

### Architecture

The package family splits into two layers:

#### The `cql` engine (model-independent)

Translates CQL source into an executable ELM library and evaluates it. The engine supports the CQL System types and 150+ expression types, including:

- **Aggregates:** Count, Sum, Avg, Min, Max, StdDev, Variance, Median, Mode
- **Arithmetic:** Abs, Ceiling, Floor, Truncate, Round, Negate, Ln, Log, Power
- **Comparison:** Greater, Less, GreaterOrEqual, LessOrEqual, Equivalent
- **DateTime:** After, Before, SameAs, SameOrAfter, SameOrBefore, DurationBetween
- **Intervals:** Contains, In, Includes, Meets, Overlaps, Starts, Ends, Width
- **Lists:** Union, Intersect, Except, Distinct, Flatten, First, Last, IndexOf
- **Strings:** Combine, Split, IndexOf, PositionOf, Matches, Length, Upper, Lower
- **Clinical:** CalculateAge, InValueSet, InCodeSystem, Retrieve

The engine's curated public API exposes `libraryFromCql`, the `CqlLibrary` it returns, the CQL System result types (`CqlInteger`, `CqlDecimal`, `CqlBoolean`, `CqlString`, `CqlDate`, `CqlTime`, `CqlDateTime`, `CqlCode`, `CqlConcept`, `CqlValueSet`, `CqlInterval`, …), and the data-model boundary interfaces. The ELM expression tree and the ANTLR-based translator internals are implementation details and are not exported.

#### The `fhir_r4_cql` binding

- **`R4ModelResolver`** — type checks (`is`/`as`), FHIRPath-based property navigation, and the boundary conversions between FHIR R4 types and CQL System types (`FhirBoolean` ↔ `Boolean`, `Coding` → `Code`, `CodeableConcept` → `Concept`, `Quantity` → `System.Quantity`, `Period` → `Interval<DateTime>`, `Range` → `Interval<Quantity>`, …).
- **`R4TerminologyProvider`** — resolves value-set membership by fetching the FHIR `ValueSet` resource (through `fhir_r4_path`'s canonical-resource cache) and checking codes with its `ValueSetChecker`.

### Usage

#### Translating and Executing a CQL Library

```dart
import 'package:fhir_r4_cql/fhir_r4_cql.dart';

Future<void> main() async {
  const source = '''
library Example version '1.0.0'

define "Greeting": 'Hello, CQL'
define "Sum": 1 + 2 + 3
define "IsAdult": 21 >= 18
define "Evens": (List{1, 2, 3, 4, 5, 6}) X where X mod 2 = 0
''';

  // 1. Translate CQL source to an executable ELM library. Translation
  //    problems are recorded on `library.annotation` (mirroring the
  //    reference translator) rather than thrown.
  final library = libraryFromCql(source);

  // 2. Execute. The R4ModelResolver wires in FHIR R4 data access;
  //    expressions that retrieve (e.g. [Patient], [Observation]) resolve
  //    through it. `execute` returns the run context, keyed by define name.
  final results = await library.execute(
    <String, dynamic>{},
    const R4ModelResolver(),
  ) as Map<String, dynamic>;

  print(results['Sum']); // 6
}
```

#### Working with Results

Execution results use the CQL System primitive wrapper types, each with a typed accessor for the underlying Dart value:

```dart
final sum = results['Sum'] as CqlInteger;
print(sum.valueInt); // 6

final isAdult = results['IsAdult'] as CqlBoolean;
print(isAdult.valueBoolean); // true

final greeting = results['Greeting'] as CqlString;
print(greeting.valueString); // Hello, CQL
```

`CqlDecimal` exposes `valueNum`; `CqlDate`, `CqlTime`, and `CqlDateTime` expose their canonical string form via `valueString`.

#### ELM JSON Round-Trips

Translated libraries round-trip through ELM JSON, so they can be stored and reloaded without re-translating:

```dart
// Serialize the translated library
final elmJson = library.toJson();

// Reload it later
final reloaded = CqlLibrary.fromJson(elmJson);
final results = await reloaded.execute(
  <String, dynamic>{},
  const R4ModelResolver(),
);
```

### Terminology

`R4TerminologyProvider` resolves `in "MyValueSet"` membership tests. By default it fetches `ValueSet` resources over the network; pass a pre-populated `CanonicalResourceCache` to resolve offline:

```dart
final terminology = R4TerminologyProvider();

// Or, offline:
final offlineTerminology = R4TerminologyProvider(resourceCache: myCache);
```

Libraries that only use locally-supplied expansions can instead place them directly in the execution context under `_valueSets` and need no provider.

### The fhir-fli CQL family

| Package | Role |
| --- | --- |
| [`cql`](https://pub.dev/packages/cql) | Model-independent CQL→ELM translator + engine |
| [`fhir_r4_cql`](https://pub.dev/packages/fhir_r4_cql) | The FHIR R4 binding |
| [`fhir_r5_cql`](https://pub.dev/packages/fhir_r5_cql) | The FHIR R5 binding |
| [`fhir_r6_cql`](https://pub.dev/packages/fhir_r6_cql) | The FHIR R6 binding |

### Resources

- [CQL Specification](https://cql.hl7.org/)
- [CQL Author's Guide](https://cql.hl7.org/02-authorsguide.html)
- [ELM Specification](https://cql.hl7.org/04-logicalspecification.html)
- [cql engine repository](https://github.com/fhir-fli/cql)
- [fhir_r4_cql repository](https://github.com/fhir-fli/fhir_r4)
