---
id: drosophila_demo
title: Drosophila Demo
---

## Live Demo

Try Drosophila with sample patient data. Select a patient to see matched clinical trials from ClinicalTrials.gov.

[Open full screen](https://fhir-fli.github.io/fhir_fli_documentation/drosophila/)

<iframe
  src="drosophila/index.html"
  sandbox="allow-scripts allow-same-origin"
  style="width: 100%; height: 800px; border: none;">
</iframe>

### Sample Patients

The demo includes three sample oncology patients:

| Patient | Cancer Type | Key Features |
|---------|-------------|--------------|
| **Maria Santos** | Breast Cancer | HER2+, ER+, PR+, Stage IIIA |
| **James Chen** | Non-Small Cell Lung Cancer | EGFR+, Stage IV |
| **Aisha Williams** | Triple-Negative Breast Cancer | Stage IIB |

Each patient has a complete profile including demographics, staging, biomarkers, labs, medications, and procedures. The demo searches ClinicalTrials.gov in real time and matches the patient against actual trial eligibility criteria.

### What You're Seeing

- **Trial cards** show a match score (0&ndash;100%), verdict badge, phase, and summary counts of met/not-met/indeterminate criteria
- **Filter chips** let you toggle between all trials, likely eligible, and needs review
- **Trial detail** (tap a card) shows every criterion with its match status, the patient value used, and the trial's requirement
- Trials where the patient is clearly not eligible are filtered out by default
