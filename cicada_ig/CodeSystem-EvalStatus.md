# Cicada Evaluation Status - The Cicada Vaccine Forecasting Engine and Guide v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Cicada Evaluation Status**

## CodeSystem: Cicada Evaluation Status 

| | |
| :--- | :--- |
| *Official URL*:http://fhirfli.dev/fhir/ig/cicada/CodeSystem/EvalStatus | *Version*:0.1.0 |
| Draft as of 2026-09-02 | *Computable Name*:EvalStatusCS |

 
Extension codes for dose evaluation status beyond the HL7 THO immunization-evaluation-dose-status CodeSystem. Only codes not covered by the standard are defined here. 

 This Code system is referenced in the content logical definition of the following value sets: 

* [EvalStatusVS](ValueSet-eval-status.md)



## Resource Content

```json
{
  "resourceType" : "CodeSystem",
  "id" : "EvalStatus",
  "url" : "http://fhirfli.dev/fhir/ig/cicada/CodeSystem/EvalStatus",
  "version" : "0.1.0",
  "name" : "EvalStatusCS",
  "title" : "Cicada Evaluation Status",
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
  "description" : "Extension codes for dose evaluation status beyond the HL7 THO immunization-evaluation-dose-status CodeSystem. Only codes not covered by the standard are defined here.",
  "content" : "complete",
  "count" : 1,
  "concept" : [
    {
      "code" : "extraneous",
      "display" : "Extraneous",
      "definition" : "The dose was administered after the series was already complete. Every administered dose must be reported, so extraneous doses are tracked but do not affect the forecast."
    }
  ]
}

```
