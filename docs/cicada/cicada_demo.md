---
id: cicada_demo
title: Cicada Demo
---

# Live Demo

Try the Cicada immunization forecasting engine. Enter vaccine history or select a sample patient to see a CDC schedule forecast.

[Open full screen](https://fhir-fli.github.io/fhir_fli_documentation/cicada_demo/)

<iframe
  src="/fhir_fli_documentation/cicada_demo/index.html"
  sandbox="allow-scripts allow-same-origin"
  style={{
    width: '100%',
    height: '800px',
    border: 'none'
  }}
/>

## Sample Patients

The demo includes three sample patients:

| Patient | Age | Scenario |
|---------|-----|----------|
| **Baby Jordan** | 6 months | Infant with birth, 2-month, and 4-month visits complete. Due for 6-month doses. |
| **Mia Chen** | 5 years | Child with incomplete series — missed some doses, needs catch-up vaccines. |
| **Alex Rivera** | 30 years | Adult with childhood vaccines, needs routine boosters and annual vaccines. |

## What You're Seeing

- **Action Needed** — vaccines that are due now or overdue based on the CDC immunization schedule
- **Upcoming** — vaccines the patient will need in the future but aren't due yet
- **Complete** — vaccine series that have been fully completed
- **Dose Evaluations** — how each administered dose was evaluated (valid, not valid, extraneous) with reasons

## How It Works

1. Enter a date of birth and sex, or select a sample patient
2. Add vaccines from the searchable picker (supports abbreviations, disease names, and brand names)
3. Tap "Get Forecast" to run the CDC CDSi forecasting engine
4. Results show which vaccines are due, with earliest, recommended, and past-due dates

The forecast runs entirely in-browser using the [Cicada engine](cicada_overview) — no server calls required.
