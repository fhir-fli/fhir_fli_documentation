---
id: drosophila_overview
title: Drosophila Overview
---

## Drosophila

**Clinical trial matching for oncology, powered by SMART on FHIR.**

Drosophila automatically identifies clinical trials a patient may be eligible for by extracting structured data from the EHR and comparing it against trial eligibility criteria from [ClinicalTrials.gov](https://clinicaltrials.gov).

### How It Works

Drosophila follows a two-stage EHR integration pattern:

1. **CDS Hooks** &mdash; A `patient-view` hook fires when a clinician opens a patient chart. Drosophila returns a CDS card summarizing potential trial matches with a SMART App Link to launch the full app.

2. **SMART on FHIR App** &mdash; The clinician clicks the card to launch the Drosophila app inside the EHR. The app authenticates via SMART, extracts patient data, searches ClinicalTrials.gov, and displays ranked trial matches.

```
EHR opens chart
    │
    ▼
CDS Hooks patient-view
    │
    ▼
CDS Card: "3 trials found, 2 likely eligible"
    │  [click: SMART App Link]
    ▼
SMART on FHIR Launch
    │
    ├─► Extract patient data (FHIR R4)
    │     Patient, Condition, Observation,
    │     MedicationRequest, Procedure
    │
    ├─► Search ClinicalTrials.gov (API v2)
    │     Condition-based query
    │
    ├─► Parse eligibility criteria
    │     Free text → structured criteria
    │
    ├─► Match patient to trials
    │     Each criterion: met / not met / indeterminate
    │
    └─► Display ranked results
```

### Architecture

Drosophila is split into two packages:

| Package | Description |
|---------|-------------|
| **drosophila_core** | Pure Dart. Criteria parsing, patient matching, trial ingestion. No Flutter dependency. |
| **drosophila_flutter** | Flutter UI. Screens, widgets, SMART launch service, CDS Hooks service, theme. |

#### Patient Data Extraction

On SMART launch, Drosophila requests these scopes and extracts:

| FHIR Resource | Extracted Data |
|---------------|----------------|
| Patient | Age, sex |
| Condition | Primary cancer diagnosis (ICD-10 / SNOMED), comorbidities |
| Observation | Staging (TNM), biomarkers (HER2, ER, PR, EGFR, ALK, BRAF, KRAS, PD-L1, etc.), labs, ECOG/Karnofsky |
| MedicationRequest | Current and past medications |
| Procedure | Surgical and treatment history |

Cancer detection uses ICD-10-CM ranges (C00-C96, D00-D09, D37-D48) and a curated set of ~200 mCODE SNOMED codes covering all major cancer types.

#### Eligibility Criteria Pipeline

ClinicalTrials.gov returns eligibility criteria as free text. Drosophila parses this into structured, matchable criteria:

1. **Split** &mdash; Separate inclusion and exclusion sections, extract individual criteria from bullet points
2. **Classify** &mdash; Categorize each criterion (demographics, staging, biomarker, lab, performance status, prior therapy, etc.)
3. **Extract** &mdash; Pull structured requirements (e.g., "age &ge; 18" &rarr; `AgeRange(min: 18)`)
4. **Match** &mdash; Compare against patient profile, producing a three-state verdict:
   - **Met** &mdash; Patient data satisfies the criterion
   - **Not Met** &mdash; Patient data contradicts the criterion
   - **Indeterminate** &mdash; Insufficient data to determine

#### Scoring

Each trial receives a match score (0&ndash;100%) based on the proportion of criteria met, with exclusion criteria weighted more heavily. Trials are ranked by score and categorized:

- **Eligible** &mdash; All evaluable criteria met, no exclusions triggered
- **Needs Review** &mdash; Some criteria indeterminate (missing data)
- **Not Eligible** &mdash; One or more exclusion criteria met (hidden by default)

### Trial Data

Drosophila fetches from the [ClinicalTrials.gov API v2](https://clinicaltrials.gov/data-api/api) using `format=json`. For each trial it extracts:

- NCT ID, title, status, phase
- Brief description
- Target conditions
- Interventions
- Sponsor
- Enrollment count
- Study locations
- Eligibility criteria (free text, parsed into structured form)

### Dependencies

Drosophila builds on several FHIR-FLI packages:

- **fhir_r4** &mdash; FHIR R4 resource models
- **fhir_r4_at_rest** &mdash; FHIR REST client for patient data extraction
- **fhir_r4_auth** &mdash; SMART on FHIR authentication
- **fhir_r4_cds_hooks** &mdash; CDS Hooks service definition and response building
