# Cicada Data Integrity Code System - The Cicada Vaccine Forecasting Engine and Guide v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Cicada Data Integrity Code System**

## CodeSystem: Cicada Data Integrity Code System 

| | |
| :--- | :--- |
| *Official URL*:http://fhirfli.dev/fhir/ig/cicada/CodeSystem/data-integrity | *Version*:0.1.0 |
| Draft as of 2026-09-02 | *Computable Name*:DataIntegrityCS |

 
Records that cannot describe an administration. CDSi evaluates a vaccine dose administered and defines the assessment date as the current date, so these doses are excluded from evaluation and forecasting and reported in an OperationOutcome. They are statements about the data, never about the patient's immunity, which is why they are not evaluation statuses. 

 This Code system is referenced in the content logical definition of the following value sets: 

* [DataIntegrityVS](ValueSet-data-integrity-vs.md)



## Resource Content

```json
{
  "resourceType" : "CodeSystem",
  "id" : "data-integrity",
  "url" : "http://fhirfli.dev/fhir/ig/cicada/CodeSystem/data-integrity",
  "version" : "0.1.0",
  "name" : "DataIntegrityCS",
  "title" : "Cicada Data Integrity Code System",
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
  "description" : "Records that cannot describe an administration. CDSi evaluates a vaccine dose administered and defines the assessment date as the current date, so these doses are excluded from evaluation and forecasting and reported in an OperationOutcome. They are statements about the data, never about the patient's immunity, which is why they are not evaluation statuses.",
  "caseSensitive" : true,
  "content" : "complete",
  "count" : 3,
  "concept" : [
    {
      "code" : "dose-before-birth",
      "display" : "Dose dated before the date of birth",
      "definition" : "The administration date precedes the patient's date of birth, so the dose was not given to this patient. Check the birth date, the administration date, and that the record belongs to this patient."
    },
    {
      "code" : "dose-after-assessment",
      "display" : "Dose dated after the assessment date",
      "definition" : "The administration date is after the assessment date, so the administration has not happened. A planned dose belongs in an ImmunizationRecommendation."
    },
    {
      "code" : "duplicate-same-day",
      "display" : "Two doses covering one antigen on one day",
      "definition" : "Two administered doses covering the same antigen carry the same date. Matched on the antigen, not the product, so it catches a combination given alongside a component — Pediarix and Pentacel are different CVX codes that both carry diphtheria, tetanus, pertussis and polio. Both doses are still evaluated on their own merits; the engine cannot tell a record entered twice from a second injection."
    }
  ]
}

```
