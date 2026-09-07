# Vaccine Recommendation Category - The Cicada Vaccine Forecasting Engine and Guide v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Vaccine Recommendation Category**

## CodeSystem: Vaccine Recommendation Category 

| | |
| :--- | :--- |
| *Official URL*:http://fhirfli.dev/fhir/ig/cicada/CodeSystem/vaccine-recommendation-category | *Version*:0.1.0 |
| Draft as of 2026-09-07 | *Computable Name*:VaccineRecommendationCategoryCS |

 
The three categories of CDC's Vaccine Recommendation Category Determination (CDSi supporting data 4.65): the type of recommendation a Best Patient Series carries for a patient who is recommended further doses. Displays are CDC's own words. 

 This Code system is referenced in the content logical definition of the following value sets: 

* [Vaccine Recommendation Category Value Set](ValueSet-vaccine-recommendation-category-vs.md)



## Resource Content

```json
{
  "resourceType" : "CodeSystem",
  "id" : "vaccine-recommendation-category",
  "url" : "http://fhirfli.dev/fhir/ig/cicada/CodeSystem/vaccine-recommendation-category",
  "version" : "0.1.0",
  "name" : "VaccineRecommendationCategoryCS",
  "title" : "Vaccine Recommendation Category",
  "status" : "draft",
  "date" : "2026-09-07T18:40:23-04:00",
  "publisher" : "FHIR-FLI",
  "contact" : [{
    "name" : "FHIR-FLI",
    "telecom" : [{
      "system" : "url",
      "value" : "http://fhirfli.dev"
    }]
  }],
  "description" : "The three categories of CDC's Vaccine Recommendation Category Determination (CDSi supporting data 4.65): the type of recommendation a Best Patient Series carries for a patient who is recommended further doses. Displays are CDC's own words.",
  "caseSensitive" : true,
  "content" : "complete",
  "count" : 3,
  "concept" : [{
    "code" : "routine",
    "display" : "Routine",
    "definition" : "An age-based recommendation for the general population."
  },
  {
    "code" : "high-risk",
    "display" : "High-Risk",
    "definition" : "A recommendation because of a risk factor the patient has (a risk-based series, or an included indication)."
  },
  {
    "code" : "scdm",
    "display" : "SCDM",
    "definition" : "Shared clinical decision making: the recommendation depends on a discussion between the patient and the clinician."
  }]
}

```
