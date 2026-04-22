---
id: cicada_architecture
title: Architecture
---

## Architecture

Cicada's forecasting pipeline processes FHIR input through a series of steps that mirror the CDSi Logic Specification.

### Pipeline Overview

```
FHIR Parameters (input)
       │
  1. Parse ──────────▶ VaxPatient (demographics, doses, observations)
       │
  2. Map ────────────▶ Map<String, VaxAntigen> (one per target disease)
       │
  3. Evaluate ───────▶ Each dose checked against series requirements
       │
  4. Forecast ───────▶ Series determines need + recommended dates
       │
  5. Select Best ────▶ VaxGroup scores and picks best series
       │
  6. Aggregate ──────▶ Vaccine group forecasts (multi-antigen grouping)
       │
FHIR Parameters (output)
```

#### Step 1: Parse

The `PatientForAssessment` Riverpod provider extracts a `VaxPatient` from the FHIR `Parameters` input. It parses:
- Patient demographics (birth date, sex)
- Immunization history (CVX codes, dates administered)
- Clinical conditions, allergies, observations, procedures, and medications

Each clinical resource is cross-referenced against the observation crosswalk to identify CDSi observation codes (e.g., "patient is immunocompromised", "patient is pregnant").

#### Step 2: Map

`antigenMap()` distributes each administered dose to the antigens it targets. A single CVX code (e.g., CVX 94 for MMR-Varicella) may map to multiple antigens (Measles, Mumps, Rubella, Varicella). The CVX-to-antigen mapping comes from the schedule supporting data.

#### Step 3: Evaluate

Each `VaxAntigen` contains one or more `VaxGroup`s, each containing one or more `VaxSeries`. For each series, doses are evaluated in order per CDSi Figure 6-1:

1. **Inadvertent Administration** — Was the vaccine given inadvertently?
2. **Age Validity** — Was the patient within the valid age range?
3. **Interval** — Was the minimum interval from the previous dose met?
4. **Live Virus Conflict** — Was there a conflicting live virus vaccine given too recently?
5. **Vaccine Type** — Was the administered vaccine an allowable type for this dose?

The first failing check determines the evaluation reason. Valid doses are added to the series' evaluated dose list.

#### Step 4: Forecast

Each series determines its forecast need:
- Check for **immunity** (clinical evidence or completed series)
- Check for **contraindications** (both preferable and allowable vaccines)
- Determine **series completeness** (all target doses satisfied?)
- If not complete, calculate **forecast dates** using conditional skip logic and interval calculations

#### Step 5: Select Best Series

`VaxGroup` scores and prioritizes series using CDSi Table 8-14:
- Complete/Immune series are preferred over in-process
- In-process preferred over zero-dose
- Among ties, standard series preferred over risk series
- Score considers number of valid doses, number of not-valid doses, and closest forecast date

#### Step 6: Aggregate

Multi-antigen vaccine groups (e.g., DTaP/Tdap/Td covers Diphtheria + Tetanus + Pertussis) aggregate recommendations from constituent antigens. The `administerFullVaccineGroup` flag determines whether to recommend the full combination or allow individual components.

### Model Hierarchy

```
VaxPatient
 └── VaxAntigen (one per target disease: Measles, Tetanus, HepB, etc.)
      └── VaxGroup (groups series by vaccine group: MMR, DTaP/Tdap/Td, etc.)
           └── VaxSeries (one CDSi series: standard, risk, evaluation-only)
                └── VaxDose (one administered dose with evaluation status)
```

#### VaxPatient

Parsed patient with demographics, past doses, and observations. Created by the `PatientForAssessment` provider from FHIR `Parameters`.

#### VaxAntigen

One instance per target disease (e.g., Measles). Contains groups, handles immunity and contraindication checks. The set of antigens comes from `activeAntigenMap` (CDC or WHO depending on `ForecastMode`).

#### VaxGroup

Groups related series by vaccine group. Implements the CDSi series scoring and best-series selection algorithm. A vaccine group like MMR contains multiple series (e.g., standard 2-dose MMR, catch-up).

#### VaxSeries

Tracks one CDSi series definition. Evaluates administered doses against target dose requirements, manages conditional skip logic ("if patient already received X, skip dose Y"), and generates forecast dates with earliest/recommended/past-due/latest.

Series types:
- **Standard** — Always included for evaluation
- **Risk** — Only included when patient has a matching observation (e.g., immunocompromised) and falls within the indication age range
- **Evaluation-only** — Used for dose evaluation but does not generate forecasts

#### VaxDose

An individual administered dose with its evaluation outcome:
- **Valid** — Meets all requirements for the target dose
- **Not Valid** — Fails one or more checks (with specific reason)
- **Sub-standard** — Partially valid (e.g., grace period)
- **Extraneous** — Not needed by the series

### Key Types

#### VaxDate

Extends `DateTime` with CDSi date arithmetic:

```dart
final birthDate = VaxDate(2024, 1, 15);
final sixMonths = birthDate.change('6 months');    // 2024-07-15
final dueDate = birthDate.change('6 months 4 days'); // 2024-07-19

// Sentinel values
VaxDate.min(); // 1900-01-01
VaxDate.max(); // 2999-12-31
```

#### AntigenSupportingData

Immutable data class containing the complete definition for one antigen: target disease, vaccine group, series definitions (with dose rules, intervals, allowable vaccines), immunity criteria, and contraindications. Deserialized from generated JSON.

#### ScheduleSupportingData

Global schedule data shared across all antigens: live virus conflicts, vaccine groups, vaccine-group-to-antigen map, CVX-to-antigen map, and observation definitions (clinical condition crosswalk).

### State Management

Cicada uses Riverpod (non-Flutter variant) with `ProviderContainer` for managing shared state during a forecast run:

- `patientForAssessmentProvider` — Parses FHIR Parameters into VaxPatient
- `observationsProvider` — Shared observation state across evaluation
- `seriesGroupCompleteProvider` — Tracks series group completion across antigens (used for conditional skip logic)
- `operationOutcomesProvider` — Collects OperationOutcome issues (errors/warnings)

A new `ProviderContainer` is created for each forecast invocation, ensuring thread safety and isolation.

### Generated Code

Supporting data files in `cicada/lib/generated_files/` are produced by the generator pipeline and should not be hand-edited:

- **CDC**: One `.dart` file per antigen + `schedule_supporting_data.dart` + barrel file
- **WHO**: Same structure in `generated_files/who/` with `who` prefix on variable names

The generator reads from CDSi XML/Excel specifications (CDC) or Excel workbooks (WHO) and produces Dart files with `AntigenSupportingData.fromJson()` and `ScheduleSupportingData.fromJson()` calls containing the full specification data. WHO Excel source files live in `cicada_generator/lib/WHO/antigen/` (22 `.xlsx`) and `WHO/schedule/` (5 `.xlsx`).
