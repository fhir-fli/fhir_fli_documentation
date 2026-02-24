---
id: cicada_who
title: WHO Support
---

# WHO Immunization Forecasting

Cicada supports WHO Expanded Programme on Immunization (EPI) recommendations alongside the CDC's CDSi schedule. This enables immunization forecasting for global health contexts where the U.S. schedule is not applicable.

## WHO Antigens

Cicada includes definitions for 22 WHO antigens:

### Core EPI Antigens (12)

| Antigen | Vaccine | Schedule | CVX |
|---------|---------|----------|-----|
| Tuberculosis (BCG) | BCG | Birth dose | 19 |
| Hepatitis B | HepB | Birth + 6/10/14 weeks | 43, 198 |
| Diphtheria | DTP | 6/10/14 weeks + boosters | 198, 01, 107 |
| Tetanus | TT/Td | 6/10/14 weeks + boosters | 198, 01, 09, 139 |
| Pertussis | DTP | 6/10/14 weeks + booster at 12-23mo (3p+1) | 198, 01, 107 |
| Hib | Hib | 6/10/14 weeks | 198, 49, 48 |
| Polio | OPV + IPV | 6/10/14 weeks OPV + IPV at 9 months | 178, 10, 89 |
| Measles | MR/MMR | 9 months + 15-18 months | 04, 03 |
| Rubella | MR/MMR | 9 months + 15-18 months | 04, 06 |
| PCV | PCV | 6/10/14 weeks | 152, 133 |
| Rotavirus | RV1/RV5 | 6/10 weeks (2-dose) or 6/10/14 weeks (3-dose) | 116, 119 |
| HPV | HPV | 9-14 years (1 dose); 15+ years (2 doses); immunocompromised (3 doses) | 165, 137, 62 |

### Context-Dependent Antigens (10)

| Antigen | When Recommended |
|---------|-----------------|
| Hepatitis A | Intermediate/high endemicity (1-dose) or low endemicity (2-dose) |
| Yellow Fever | Endemic/at-risk areas |
| Japanese Encephalitis | Endemic areas in Asia-Pacific |
| Meningococcal | Meningitis belt, outbreaks, travel |
| Typhoid | Endemic areas |
| Cholera | 1-dose emergency + 2-dose endemic |
| Rabies | High-risk areas, post-exposure |
| Mumps | Where programmatically feasible |
| Influenza | 6 WHO priority groups (healthcare workers, elderly, pregnant, chronic conditions, young children, older adults) |
| COVID-19 | Healthcare workers, older adults 60+, immunocompromised |

## Key Differences from CDC

### Vaccine Formulations

The WHO schedule uses different vaccine combinations than the U.S. schedule:

- **Pentavalent (CVX 198)**: DTP-HepB-Hib — a single vaccine covering 5 antigens, standard in the WHO EPI schedule but not used in the U.S.
- **OPV (CVX 178)**: Oral Polio Vaccine — WHO uses a mixed OPV+IPV schedule; the U.S. uses IPV only
- **MR (CVX 04)**: Measles-Rubella — WHO recommends MR; the U.S. uses MMR (which adds Mumps)
- **DTP (CVX 01)**: Whole-cell pertussis — WHO uses DTP (wP); the U.S. uses DTaP (aP)

### Timing

WHO doses are typically scheduled at **6, 10, and 14 weeks** with boosters at **12-23 months** and **4-7 years**. The U.S. schedule uses **2, 4, and 6 months** with later boosters.

### HPV

The WHO adopted a **single-dose HPV schedule** in 2022 for girls aged 9-14. Girls 15+ receive 2 doses. This differs from the U.S. 2-dose schedule for ages 9-14 and 3-dose for 15+.

### Multi-Antigen Groups

| WHO Group | Antigens |
|-----------|----------|
| DTP | Diphtheria, Tetanus, Pertussis |
| MR | Measles, Rubella |
| MMR | Measles, Mumps, Rubella |

The CDC groups are DTaP/Tdap/Td (Diphtheria, Tetanus, Pertussis) and MMR (Measles, Mumps, Rubella).

## Usage

### Switch to WHO Mode

```dart
import 'package:cicada/cicada.dart';

// Option 1: Pass mode to forecast function
final result = forecastFromParameters(input, mode: ForecastMode.who);

// Option 2: Set mode globally
setForecastMode(ForecastMode.who);
final result = forecastFromParameters(input);
```

### Check Active Mode

```dart
print(currentForecastMode); // ForecastMode.who

// Access the active data directly
final antigens = activeAntigenMap; // WHO antigen definitions
final schedule = activeScheduleData; // WHO schedule data
final groups = activeMultiAntigenGroups; // WHO multi-antigen groups
```

### Build WHO-Specific Input

The input format is the same FHIR `Parameters` resource. Use CVX codes appropriate for WHO vaccines:

```dart
final input = Parameters(parameter: [
  ParametersParameter(name: FhirString('2024-06-15')),
  ParametersParameter(
    name: FhirString('patient'),
    resource: Patient(
      birthDate: FhirDate('2024-01-15'),
      gender: PatientGender.female,
    ),
  ),
  // Pentavalent (DTP-HepB-Hib) at 6 weeks
  ParametersParameter(
    name: FhirString('immunization'),
    resource: Immunization(
      status: ImmunizationStatus.completed,
      vaccineCode: CodeableConcept(coding: [
        Coding(
          system: FhirUri('http://hl7.org/fhir/sid/cvx'),
          code: FhirCode('198'), // DTP-HepB-Hib (pentavalent)
        ),
      ]),
      occurrenceDateTime: FhirDateTime('2024-02-26'),
      patient: Reference(reference: FhirString('Patient/1')),
    ),
  ),
  // OPV at 6 weeks
  ParametersParameter(
    name: FhirString('immunization'),
    resource: Immunization(
      status: ImmunizationStatus.completed,
      vaccineCode: CodeableConcept(coding: [
        Coding(
          system: FhirUri('http://hl7.org/fhir/sid/cvx'),
          code: FhirCode('178'), // OPV, bivalent
        ),
      ]),
      occurrenceDateTime: FhirDateTime('2024-02-26'),
      patient: Reference(reference: FhirString('Patient/1')),
    ),
  ),
]);

final result = forecastFromParameters(input, mode: ForecastMode.who);
```

## WHO Schedule Data

### Observations

WHO-specific observation codes start at 1010+ to avoid collision with CDSi codes (001-280). There are 17 codes across two ranges:

| Code | Title |
|------|-------|
| 1010 | Lives in meningitis belt |
| 1011 | Lives in JE endemic area |
| 1012 | Lives in or traveling to YF endemic area |
| 1013 | Lives in cholera endemic/outbreak area |
| 1014 | Lives in typhoid endemic area |
| 1015 | High risk of rabies exposure |
| 1020 | Healthcare worker |
| 1021 | Older adult 60+ years |
| 1022 | Immunocompromised individual |
| 1023 | Pregnant |
| 1024 | Chronic medical condition |
| 1025 | WHO influenza priority — young child (6mo-5y) |
| 1026 | WHO influenza priority — older adult (65+) |
| 1027 | Lives in HepA intermediate/high endemicity area |
| 1070 | Serologic evidence of HepB immunity |
| 1071 | Laboratory evidence of Measles immunity |

### CVX-to-Antigen Mapping

The WHO schedule maps 55+ CVX codes to antigens, including WHO-specific combinations like pentavalent (CVX 198 maps to Diphtheria, Tetanus, Pertussis, HepB, and Hib).

### Live Virus Conflicts

14 live virus conflict entries covering BCG, OPV, MMR, MR, Rotavirus, Yellow Fever, Measles, Rubella, Mumps, and Varicella.

## ImmDS Server

Cicada's HTTP server exposes both CDC and WHO endpoints:

```bash
# Start the server
dart run bin/server.dart -p 8080

# CDC forecast (default)
curl -X POST http://localhost:8080/\$immds-forecast \
  -H 'Content-Type: application/fhir+json' \
  -d @input.json

# WHO forecast
curl -X POST http://localhost:8080/\$immds-forecast-who \
  -H 'Content-Type: application/fhir+json' \
  -d @input.json
```

Both endpoints accept identical FHIR `Parameters` input and return the same output format. The only difference is which schedule is used for evaluation and forecasting.

## Generator

WHO supporting data is generated from Excel source files (the source of truth):

```bash
# Generate WHO supporting data from Excel → JSON → Dart
dart cicada_generator/lib/main.dart --who
```

The generated files are written to `cicada/lib/generated_files/who/` and include:
- 22 antigen `.dart` files (one per antigen)
- `who_schedule_supporting_data.dart` (schedule data)
- `who_antigen_supporting_data.dart` (barrel file with map and list)
- `who_generated_supporting_data.dart` (top-level barrel export)

Source data: 22 `.xlsx` antigen files in `cicada_generator/lib/WHO/antigen/` and 5 `.xlsx` schedule files in `cicada_generator/lib/WHO/schedule/`.
