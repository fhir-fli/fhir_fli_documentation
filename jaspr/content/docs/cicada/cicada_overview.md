---
id: cicada_overview
title: Cicada Immunization Forecasting
---

Cicada is a Dart immunization forecasting engine that evaluates past vaccine doses and recommends future immunizations. It implements the CDC's [Clinical Decision Support for Immunization (CDSi)](https://www.cdc.gov/iis/cdsi/) specification and WHO Expanded Programme on Immunization (EPI) recommendations.

## What It Does

Given a patient's demographics, immunization history, and clinical conditions, Cicada:

1. **Evaluates** each administered dose against the immunization schedule (age validity, minimum intervals, live virus conflicts, vaccine type matching)
2. **Forecasts** future immunization needs with earliest, recommended, past-due, and latest dates
3. **Recommends** specific vaccines by vaccine group with a forecast status (Complete, Not Complete, Immune, Contraindicated, Not Recommended, Aged Out)
4. **Serves** forecasts over HTTP via `$immds-forecast` (CDC) and `$immds-forecast-who` (WHO) endpoints

## FHIR R4 Interface

Cicada uses FHIR R4 resources for both input and output:

**Input** — A FHIR `Parameters` resource containing:
- `Patient` (birth date, sex)
- `Immunization` resources (past doses with CVX codes and administration dates)
- `Condition` resources (clinical conditions)
- `AllergyIntolerance` resources (allergies and contraindications)
- `Observation`, `Procedure`, `MedicationStatement` resources (additional clinical context)
- Assessment date (the date to evaluate against)

**Output** — A FHIR `Parameters` resource containing:
- `ImmunizationEvaluation` resources (one per evaluated dose per antigen, with valid/not valid status and reason)
- `ImmunizationRecommendation` resources (one per vaccine group with forecast dates and status)

## Dual Schedule Support

Cicada supports two immunization schedules:

| | CDC (CDSi) | WHO (EPI) |
|---|---|---|
| **Schedule** | U.S. immunization schedule | WHO global recommendations |
| **Antigens** | 30+ (U.S. formulations) | 22 (global formulations) |
| **Typical vaccines** | DTaP, IPV, MMR | DTP, OPV+IPV, MR, pentavalent |
| **Dose timing** | 2/4/6 months | 6/10/14 weeks |
| **Spec version** | CDSi v4.65-508 | WHO position papers (2025) |

Switch between modes at runtime with `ForecastMode.cdc` or `ForecastMode.who`.

## Test Results

Measured 2026-11-01 against CDSi supporting data 4.65-508:

- **CDC healthy test cases**: 1063/1064 agree with CDC's expected result.
- **CDC underlying-conditions test cases**: 312/337 agree.
- **NIST FITS (external)**: forecasts pass (22 cases, 70 forecast values correct, 0 errors, run 2026-08-29). Dose evaluations have never matched.

All 26 disagreements are written up case by case in the repository (`CDSI-DISPUTED-CASES.md`), with an evidence review against current ACIP recommendations. Most of those reviews rule for Cicada against an outdated CDC test row. Three are defects in CDC's supporting data. In one case, `2016-UC-0198`, the review found CDC's row clinically right, but the only rule that made Cicada pass appears in no CDSi specification. That rule was removed and the case is left failing. The test suite checks each of the 26 against its recorded difference. A new difference, or a case that starts to agree, fails the build.

Earlier versions of this page quoted 99.6%, 96.1% and 98.8%. Those numbers are withdrawn. The 99.6% came from a test file that made no assertions. The 96.1% used a denominator of 777 that included 439 empty rows. The 98.8% counted forecasts only.

## Installation

```yaml
dependencies:
  cicada:
    git:
      url: https://github.com/fhir-fli/cicada.git
      path: cicada
```

```bash
cd cicada && dart pub get
```

## Source Code

- **Repository**: [github.com/fhir-fli/cicada](https://github.com/fhir-fli/cicada)
- **Implementation Guide**: [Cicada Vaccination IG](https://fhir-fli.github.io/fhir_fli_documentation/cicada_ig/index.html)
