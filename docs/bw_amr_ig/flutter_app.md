---
id: bw_amr_ig_flutter
title: Flutter Application
---

# Flutter Data Capture Application

The Botswana AMR platform includes a Flutter/Dart application for capturing AMR culture and susceptibility data at the point of care.

## Architecture

The Flutter app captures structured data and stores it as FHIR resources on a FHIR R4 server:

```
┌─────────────────────────┐
│   Flutter App            │
│   ├── Data entry forms   │
│   ├── Dart model classes │
│   └── fhir_r4 package   │
└─────────┬───────────────┘
          │ FHIR REST API
          ▼
┌─────────────────────────┐
│   FHIR R4 Server        │
│   (e.g., FHIR ANT)      │
│   ├── Resource storage   │
│   └── $export-whonet     │
└─────────────────────────┘
```

## Model Classes

The app includes builder classes that construct FHIR resources from form data:

| Model | FHIR Resource | Key Fields |
|-------|---------------|------------|
| `BotswanaAMRPatientBuilder` | Patient | Name, DOB, gender, Omang (national ID) |
| `BotswanaAMREncounterBuilder` | Encounter | Ward type, admission date, facility, location |
| `BotswanaAMRSpecimenBuilder` | Specimen | Specimen type, collection date, body site |
| `BotswanaAMROrganismObservationBuilder` | Observation | Organism (SNOMED CT), isolate number, hasMember links |
| `BotswanaAMRSusceptibilityObservationBuilder` | Observation | Antibiotic (LOINC), S/I/R, MIC/zone diameter, AST method |
| `BotswanaAMRSpecialTestObservationBuilder` | Observation | ESBL, carbapenemase, MRSA detection results |
| `BotswanaAMRGramStainObservationBuilder` | Observation | Gram stain morphology |
| `BotswanaAMRDiagnosticReportBuilder` | DiagnosticReport | Ties all observations, specimen, encounter together |

Each builder class has a `buildResource()` method that returns a fully conformant FHIR resource using the [fhir_r4](../core/fhir_r4) package.

## ValueSets in Dart

Pre-generated Dart files provide ValueSet coding constants for dropdowns and validation:

- Organism codes (SNOMED CT + local)
- Antibiotic susceptibility panel codes (LOINC)
- Specimen types, body sites
- S/I/R interpretation codes
- AST methods (disk diffusion, MIC, Etest, automated)
- Ward types (inpatient, outpatient, emergency, ICU)

## Installation

```yaml
dependencies:
  fhir_r4: ^0.13.0
```

The Flutter models are in the `flutter/` directory of the [bw-amr-ig repository](https://github.com/Dokotela/bw-amr-ig/tree/main/flutter).
