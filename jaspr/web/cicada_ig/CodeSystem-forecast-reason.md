# Cicada Forecast Reason Code System - The Cicada Vaccine Forecasting Engine and Guide v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Cicada Forecast Reason Code System**

## CodeSystem: Cicada Forecast Reason Code System 

| | |
| :--- | :--- |
| *Official URL*:http://fhirfli.dev/fhir/ig/cicada/CodeSystem/forecast-reason | *Version*:0.1.0 |
| Draft as of 2026-09-02 | *Computable Name*:CicadaForecastReasonCS |

 
Why the engine forecast what it did. The ImmDS ForecastReason code system covers four of these; the rest have no ImmDS concept, and the ImmDS binding on ImmunizationRecommendation.recommendation.forecastReason is example strength, so they travel as a second coding rather than being dropped. 

 This Code system is referenced in the content logical definition of the following value sets: 

* [CicadaForecastReasonVS](ValueSet-forecast-reason-vs.md)



## Resource Content

```json
{
  "resourceType" : "CodeSystem",
  "id" : "forecast-reason",
  "url" : "http://fhirfli.dev/fhir/ig/cicada/CodeSystem/forecast-reason",
  "version" : "0.1.0",
  "name" : "CicadaForecastReasonCS",
  "title" : "Cicada Forecast Reason Code System",
  "status" : "draft",
  "date" : "2026-09-02T22:18:14-04:00",
  "publisher" : "FHIR-FLI",
  "contact" : [
    {
      "name" : "FHIR-FLI",
      "telecom" : [
        {
          "system" : "url",
          "value" : "http://fhirfli.dev"
        }
      ]
    }
  ],
  "description" : "Why the engine forecast what it did. The ImmDS ForecastReason code system covers four of these; the rest have no ImmDS concept, and the ImmDS binding on ImmunizationRecommendation.recommendation.forecastReason is example strength, so they travel as a second coding rather than being dropped.",
  "caseSensitive" : true,
  "content" : "complete",
  "count" : 10,
  "concept" : [
    {
      "code" : "series-complete",
      "display" : "Patient series is complete",
      "definition" : "Every target dose in the series is satisfied. Maps to ImmDS #complete."
    },
    {
      "code" : "not-recommended-history",
      "display" : "Not recommended at this time due to past immunization history",
      "definition" : "Maps to ImmDS #notRecommended."
    },
    {
      "code" : "exceeded-maximum-age",
      "display" : "Patient has exceeded the maximum age",
      "definition" : "Maps to ImmDS #maximumAge."
    },
    {
      "code" : "past-seasonal-end",
      "display" : "Past seasonal recommendation end date",
      "definition" : "Maps to ImmDS #seasonalPast."
    },
    {
      "code" : "complete-for-the-season",
      "display" : "Patient is complete for the season",
      "definition" : "The series is complete for the current season and a further dose falls in a later one. Maps to ImmDS #seasonalComplete. A deliberate deviation from CDSi, which has no such reason: ACIP defines influenza and RSV recommendations by season, and without this a patient who has had this year's dose is indistinguishable from one who never needs another."
    },
    {
      "code" : "evidence-of-immunity",
      "display" : "Patient has evidence of immunity",
      "definition" : "No ImmDS concept."
    },
    {
      "code" : "contraindication",
      "display" : "Patient has a contraindication",
      "definition" : "No ImmDS concept."
    },
    {
      "code" : "cannot-finish-before-maximum-age",
      "display" : "Patient is unable to finish the series prior to the maximum age",
      "definition" : "No ImmDS concept."
    },
    {
      "code" : "below-minimum-age-to-start",
      "display" : "Patient has not reached the minimum age to start",
      "definition" : "No ImmDS concept."
    },
    {
      "code" : "shared-clinical-decision-making",
      "display" : "Recommended by shared clinical decision-making",
      "definition" : "ACIP recommends this series by shared clinical decision-making rather than routinely, so it is not a care gap. Read from CDC's own marking in the series name, and for HPV from the 27-45 year band CDC states in its guidance. No CDSi or ImmDS concept; ICE calls it CLINICAL_PATIENT_DISCRETION."
    }
  ]
}

```
