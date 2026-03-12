---
id: bw_amr_ig_whonet
title: WHONET Export
---

# WHONET and GLASS Export

## Overview

Laboratory data stored as FHIR resources can be exported to flat-file formats for use with [WHONET](https://whonet.org/) or submission to WHO [GLASS](https://www.who.int/initiatives/glass) (Global Antimicrobial Resistance and Use Surveillance System).

The `$export-whonet` operation on DiagnosticReport flattens the FHIR resource hierarchy into one row per isolate, with a column per antibiotic for S/I/R interpretation and MIC values.

## Operation

```
POST [base]/DiagnosticReport/$export-whonet
```

### Parameters

| Parameter | Type | Description |
|-----------|------|-------------|
| `start` | date | Specimen collection date range start |
| `end` | date | Specimen collection date range end |
| `facility` | string | Filter by facility name |
| `format` | code | `whonet` (pipe-delimited) or `glass` (GLASS CSV) |

### Output

A `Binary` resource with `contentType: text/csv` containing the flattened data.

## How It Works

1. Query DiagnosticReports matching the date range and facility filters
2. For each report, resolve the Encounter (ward type, admission date), Patient (demographics), and Specimen (type, collection date)
3. For each OrganismObservation in `result[organism]`, create one row
4. Pivot each SusceptibilityObservation under that organism into columns
5. Output as pipe-delimited text or GLASS batch CSV

## GLASS Classification

The Encounter profile captures data needed for GLASS origin classification:

- **Ward type** (`Encounter.class`): Inpatient, outpatient, ICU, or emergency
- **Admission date** (`Encounter.period.start`): A specimen collected ≥ 2 calendar days after admission is classified as hospital-acquired
- **Facility** (`Encounter.serviceProvider`): Maps to the GLASS laboratory/institution identifier

## Workflow

```
Flutter app → FHIR server → $export-whonet → WHONET / GLASS
    │                              │
    │  captures AMR data           │  generates flat files
    │  stores as FHIR resources    │  on demand
    └──────────────────────────────┘
```

ConceptMaps are used server-side during export to translate FHIR terminology codes to WHONET-native codes. The Flutter application does not need the ConceptMaps — it works with standard FHIR terminologies.
