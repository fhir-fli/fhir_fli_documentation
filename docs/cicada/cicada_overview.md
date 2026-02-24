---
id: cicada_overview
title: Cicada Overview
---

# Cicada Immunization Forecasting Engine

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
| **Spec version** | CDSi v4.61-508 | WHO position papers (2025) |

Switch between modes at runtime with `ForecastMode.cdc` or `ForecastMode.who`.

## Test Results

Cicada has been extensively validated:

- **CDC Healthy Test Cases**: 1010/1014 (99.6%)
- **CDC Condition Test Cases**: 747/777 (96.1%)
- **NIST FITS (external)**: 167/169 (98.8%)

All remaining failures are verified as version mismatch issues between test data versions and engine version, not engine bugs.

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
