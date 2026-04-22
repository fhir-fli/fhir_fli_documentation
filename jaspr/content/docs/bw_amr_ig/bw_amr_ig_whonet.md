---
id: bw_amr_ig_whonet
title: WHONET Export
---

## WHONET and GLASS Export

### Overview

Laboratory data stored as FHIR resources can be exported to flat-file formats for use with [WHONET](https://whonet.org/) or submission to WHO [GLASS](https://www.who.int/initiatives/glass) (Global Antimicrobial Resistance and Use Surveillance System).

The `$export-whonet` operation on DiagnosticReport flattens the FHIR resource hierarchy into one row per isolate, with a column per antibiotic for S/I/R interpretation and MIC values.

### Operation

```
POST [base]/DiagnosticReport/$export-whonet
```

#### Parameters

| Parameter | Type | Description |
|-----------|------|-------------|
| `start` | date | Specimen collection date range start |
| `end` | date | Specimen collection date range end |
| `facility` | string | Filter by facility name |
| `format` | code | `whonet` (pipe-delimited) or `glass` (GLASS CSV) |

#### Output

A `Binary` resource with `contentType: text/csv` containing the flattened data.

### How It Works

1. Query DiagnosticReports matching the date range and facility filters
2. For each report, resolve the Encounter (ward type, admission date), Patient (demographics), and Specimen (type, collection date)
3. For each OrganismObservation in `result[organism]`, create one row
4. Pivot each SusceptibilityObservation under that organism into columns
5. Output as pipe-delimited text or GLASS batch CSV

### GLASS Classification

The Encounter profile captures data needed for GLASS origin classification:

- **Ward type** (`Encounter.class`): Inpatient, outpatient, ICU, or emergency
- **Admission date** (`Encounter.period.start`): A specimen collected ≥ 2 calendar days after admission is classified as hospital-acquired
- **Facility** (`Encounter.serviceProvider`): Maps to the GLASS laboratory/institution identifier

### Workflow

```
Flutter app → FHIR server → $export-whonet → WHONET / GLASS
    │                              │
    │  captures AMR data           │  generates flat files
    │  stores as FHIR resources    │  on demand
    └──────────────────────────────┘
```

ConceptMaps are used server-side during export to translate FHIR terminology codes to WHONET-native codes. The Flutter application does not need the ConceptMaps — it works with standard FHIR terminologies.

### `bw_amr_export` Dart Package

The export logic is implemented as a standalone Dart package (`export/` in the [bw-amr-ig repository](https://github.com/Dokotela/bw-amr-ig/tree/main/export)). It can be used from a FHIR server, a web application, or a CLI tool.

#### Components

| Class | Purpose |
|-------|---------|
| `ConceptMapIndex` | Builds reverse lookup tables from ConceptMap JSON (LOINC→WHONET, SNOMED→WHONET, WHONET→ATC) |
| `ResourceResolver` | Walks DiagnosticReport→OrganismObservation→SusceptibilityObservation and produces `IsolateRow`s |
| `WhonetExporter` | Generates WHONET pipe-delimited output with dynamic antibiotic columns |
| `GlassExporter` | Generates WHO GLASS CSV with ATC codes and HA/CO origin classification |
| `IsolateRow` | Data model for a single flattened isolate row |

#### Usage

```dart
import 'dart:io';
import 'package:bw_amr_export/bw_amr_export.dart';
import 'package:fhir_r4/fhir_r4.dart';

// 1. Build the ConceptMap index from JSON files
final index = ConceptMapIndex.fromJson(
  antibioticToLoincJson: File('ConceptMap-whonet-antibiotic-to-loinc.json').readAsStringSync(),
  antibioticToAtcJson: File('ConceptMap-whonet-antibiotic-to-atc.json').readAsStringSync(),
  organismToSnomedJson: File('ConceptMap-whonet-organism-to-snomed.json').readAsStringSync(),
);

// 2. Resolve FHIR resources into flat isolate rows
final resolver = ResourceResolver(index: index);
final rows = resolver.resolve(bundleResources); // List<Resource>

// 3. Export as WHONET pipe-delimited or GLASS CSV
final whonetOutput = WhonetExporter().export(rows);
final glassOutput = GlassExporter(index: index).export(rows);
```

#### Installation

```yaml
dependencies:
  bw_amr_export:
    git:
      url: https://github.com/Dokotela/bw-amr-ig.git
      path: export
```
