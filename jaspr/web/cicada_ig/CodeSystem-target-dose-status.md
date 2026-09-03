# Target Dose Status Code System - The Cicada Vaccine Forecasting Engine and Guide v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Target Dose Status Code System**

## CodeSystem: Target Dose Status Code System 

| | |
| :--- | :--- |
| *Official URL*:http://fhirfli.dev/fhir/ig/cicada/CodeSystem/target-dose-status | *Version*:0.1.0 |
| Draft as of 2026-09-02 | *Computable Name*:TargetDoseStatusCS |

 
CDSi Table 3-2. The status of the target dose an administered dose was evaluated against. R4 ImmunizationEvaluation carries only doseNumber, derived from this, so a skipped target dose and a satisfied one are otherwise indistinguishable. 

 This Code system is referenced in the content logical definition of the following value sets: 

* [TargetDoseStatusVS](ValueSet-target-dose-status-vs.md)



## Resource Content

```json
{
  "resourceType" : "CodeSystem",
  "id" : "target-dose-status",
  "url" : "http://fhirfli.dev/fhir/ig/cicada/CodeSystem/target-dose-status",
  "version" : "0.1.0",
  "name" : "TargetDoseStatusCS",
  "title" : "Target Dose Status Code System",
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
  "description" : "CDSi Table 3-2. The status of the target dose an administered dose was evaluated against. R4 ImmunizationEvaluation carries only doseNumber, derived from this, so a skipped target dose and a satisfied one are otherwise indistinguishable.",
  "caseSensitive" : true,
  "content" : "complete",
  "count" : 3,
  "concept" : [
    {
      "code" : "satisfied",
      "display" : "Satisfied",
      "definition" : "The target dose was satisfied by a vaccine dose administered."
    },
    {
      "code" : "not-satisfied",
      "display" : "Not Satisfied",
      "definition" : "The target dose was not satisfied."
    },
    {
      "code" : "skipped",
      "display" : "Skipped",
      "definition" : "The target dose was skipped, per a conditional skip in the series."
    }
  ]
}

```
