# Series Type Code System - The Cicada Vaccine Forecasting Engine and Guide v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Series Type Code System**

## CodeSystem: Series Type Code System 

| | |
| :--- | :--- |
| *Official URL*:http://fhirfli.dev/fhir/ig/cicada/CodeSystem/series-type | *Version*:0.1.0 |
| Draft as of 2026-09-02 | *Computable Name*:SeriesTypeCS |

 
CDSi series type: whether a patient series is the routine schedule, one indicated by a risk condition, or evaluation-only. Mirrors the seriesType attribute of the CDSi antigen supporting data. 

 This Code system is referenced in the content logical definition of the following value sets: 

* [SeriesTypeVS](ValueSet-series-type-vs.md)



## Resource Content

```json
{
  "resourceType" : "CodeSystem",
  "id" : "series-type",
  "url" : "http://fhirfli.dev/fhir/ig/cicada/CodeSystem/series-type",
  "version" : "0.1.0",
  "name" : "SeriesTypeCS",
  "title" : "Series Type Code System",
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
  "description" : "CDSi series type: whether a patient series is the routine schedule, one indicated by a risk condition, or evaluation-only. Mirrors the seriesType attribute of the CDSi antigen supporting data.",
  "caseSensitive" : true,
  "content" : "complete",
  "count" : 3,
  "concept" : [
    {
      "code" : "standard",
      "display" : "Standard",
      "definition" : "The routine, age-based series."
    },
    {
      "code" : "risk",
      "display" : "Risk",
      "definition" : "A series indicated by a patient risk condition, such as travel, occupation, pregnancy, or a chronic medical condition."
    },
    {
      "code" : "evaluation-only",
      "display" : "Evaluation Only",
      "definition" : "A series used only to evaluate administered doses; it never produces a forecast."
    }
  ]
}

```
