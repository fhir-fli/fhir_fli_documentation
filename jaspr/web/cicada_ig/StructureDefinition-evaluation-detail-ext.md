# Evaluation Sub-step Detail - The Cicada Vaccine Forecasting Engine and Guide v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Evaluation Sub-step Detail**

## Extension: Evaluation Sub-step Detail 

| | |
| :--- | :--- |
| *Official URL*:http://fhirfli.dev/fhir/ig/cicada/StructureDefinition/evaluation-detail-ext | *Version*:0.1.0 |
| Draft as of 2026-09-02 | *Computable Name*:EvaluationDetail |

The CDSi Chapter 6 sub-step outcomes behind a dose's evaluation: which of age, interval, conflict and vaccine choice passed, and for those that failed, which rule failed. doseStatusReason carries ten ImmDS codes; the engine knows more than that.

**Context of Use**

**Usage info**

**Usages:**

* This Extension is not used by any profiles in this Implementation Guide

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/cicada.ig|current/StructureDefinition/evaluation-detail-ext)

### Formal Views of Extension Content

 [Description of Profiles, Differentials, Snapshots, and how the XML and JSON presentations work](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](StructureDefinition-evaluation-detail-ext.csv), [Excel](StructureDefinition-evaluation-detail-ext.xlsx), [Schematron](StructureDefinition-evaluation-detail-ext.sch) 

#### Constraints



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "evaluation-detail-ext",
  "url" : "http://fhirfli.dev/fhir/ig/cicada/StructureDefinition/evaluation-detail-ext",
  "version" : "0.1.0",
  "name" : "EvaluationDetail",
  "title" : "Evaluation Sub-step Detail",
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
  "description" : "The CDSi Chapter 6 sub-step outcomes behind a dose's evaluation: which of age, interval, conflict and vaccine choice passed, and for those that failed, which rule failed. doseStatusReason carries ten ImmDS codes; the engine knows more than that.",
  "fhirVersion" : "4.0.1",
  "mapping" : [
    {
      "identity" : "rim",
      "uri" : "http://hl7.org/v3",
      "name" : "RIM Mapping"
    }
  ],
  "kind" : "complex-type",
  "abstract" : false,
  "context" : [
    {
      "type" : "element",
      "expression" : "ImmunizationEvaluation"
    }
  ],
  "type" : "Extension",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/Extension",
  "derivation" : "constraint",
  "differential" : {
    "element" : [
      {
        "id" : "Extension",
        "path" : "Extension",
        "short" : "Evaluation Sub-step Detail",
        "definition" : "The CDSi Chapter 6 sub-step outcomes behind a dose's evaluation: which of age, interval, conflict and vaccine choice passed, and for those that failed, which rule failed. doseStatusReason carries ten ImmDS codes; the engine knows more than that."
      },
      {
        "id" : "Extension.extension:inadvertent",
        "path" : "Extension.extension",
        "sliceName" : "inadvertent",
        "min" : 0,
        "max" : "1"
      },
      {
        "id" : "Extension.extension:inadvertent.extension",
        "path" : "Extension.extension.extension",
        "max" : "0"
      },
      {
        "id" : "Extension.extension:inadvertent.url",
        "path" : "Extension.extension.url",
        "fixedUri" : "inadvertent"
      },
      {
        "id" : "Extension.extension:inadvertent.value[x]",
        "path" : "Extension.extension.value[x]",
        "type" : [
          {
            "code" : "boolean"
          }
        ]
      },
      {
        "id" : "Extension.extension:validAgeReason",
        "path" : "Extension.extension",
        "sliceName" : "validAgeReason",
        "min" : 0,
        "max" : "1"
      },
      {
        "id" : "Extension.extension:validAgeReason.extension",
        "path" : "Extension.extension.extension",
        "max" : "0"
      },
      {
        "id" : "Extension.extension:validAgeReason.url",
        "path" : "Extension.extension.url",
        "fixedUri" : "validAgeReason"
      },
      {
        "id" : "Extension.extension:validAgeReason.value[x]",
        "path" : "Extension.extension.value[x]",
        "type" : [
          {
            "code" : "string"
          }
        ]
      },
      {
        "id" : "Extension.extension:preferredInterval",
        "path" : "Extension.extension",
        "sliceName" : "preferredInterval",
        "min" : 0,
        "max" : "1"
      },
      {
        "id" : "Extension.extension:preferredInterval.extension",
        "path" : "Extension.extension.extension",
        "max" : "0"
      },
      {
        "id" : "Extension.extension:preferredInterval.url",
        "path" : "Extension.extension.url",
        "fixedUri" : "preferredInterval"
      },
      {
        "id" : "Extension.extension:preferredInterval.value[x]",
        "path" : "Extension.extension.value[x]",
        "type" : [
          {
            "code" : "boolean"
          }
        ]
      },
      {
        "id" : "Extension.extension:preferredIntervalReason",
        "path" : "Extension.extension",
        "sliceName" : "preferredIntervalReason",
        "min" : 0,
        "max" : "1"
      },
      {
        "id" : "Extension.extension:preferredIntervalReason.extension",
        "path" : "Extension.extension.extension",
        "max" : "0"
      },
      {
        "id" : "Extension.extension:preferredIntervalReason.url",
        "path" : "Extension.extension.url",
        "fixedUri" : "preferredIntervalReason"
      },
      {
        "id" : "Extension.extension:preferredIntervalReason.value[x]",
        "path" : "Extension.extension.value[x]",
        "type" : [
          {
            "code" : "string"
          }
        ]
      },
      {
        "id" : "Extension.extension:allowedInterval",
        "path" : "Extension.extension",
        "sliceName" : "allowedInterval",
        "min" : 0,
        "max" : "1"
      },
      {
        "id" : "Extension.extension:allowedInterval.extension",
        "path" : "Extension.extension.extension",
        "max" : "0"
      },
      {
        "id" : "Extension.extension:allowedInterval.url",
        "path" : "Extension.extension.url",
        "fixedUri" : "allowedInterval"
      },
      {
        "id" : "Extension.extension:allowedInterval.value[x]",
        "path" : "Extension.extension.value[x]",
        "type" : [
          {
            "code" : "boolean"
          }
        ]
      },
      {
        "id" : "Extension.extension:allowedIntervalReason",
        "path" : "Extension.extension",
        "sliceName" : "allowedIntervalReason",
        "min" : 0,
        "max" : "1"
      },
      {
        "id" : "Extension.extension:allowedIntervalReason.extension",
        "path" : "Extension.extension.extension",
        "max" : "0"
      },
      {
        "id" : "Extension.extension:allowedIntervalReason.url",
        "path" : "Extension.extension.url",
        "fixedUri" : "allowedIntervalReason"
      },
      {
        "id" : "Extension.extension:allowedIntervalReason.value[x]",
        "path" : "Extension.extension.value[x]",
        "type" : [
          {
            "code" : "string"
          }
        ]
      },
      {
        "id" : "Extension.extension:conflict",
        "path" : "Extension.extension",
        "sliceName" : "conflict",
        "min" : 0,
        "max" : "1"
      },
      {
        "id" : "Extension.extension:conflict.extension",
        "path" : "Extension.extension.extension",
        "max" : "0"
      },
      {
        "id" : "Extension.extension:conflict.url",
        "path" : "Extension.extension.url",
        "fixedUri" : "conflict"
      },
      {
        "id" : "Extension.extension:conflict.value[x]",
        "path" : "Extension.extension.value[x]",
        "type" : [
          {
            "code" : "boolean"
          }
        ]
      },
      {
        "id" : "Extension.extension:conflictReason",
        "path" : "Extension.extension",
        "sliceName" : "conflictReason",
        "min" : 0,
        "max" : "1"
      },
      {
        "id" : "Extension.extension:conflictReason.extension",
        "path" : "Extension.extension.extension",
        "max" : "0"
      },
      {
        "id" : "Extension.extension:conflictReason.url",
        "path" : "Extension.extension.url",
        "fixedUri" : "conflictReason"
      },
      {
        "id" : "Extension.extension:conflictReason.value[x]",
        "path" : "Extension.extension.value[x]",
        "type" : [
          {
            "code" : "string"
          }
        ]
      },
      {
        "id" : "Extension.extension:preferredVaccine",
        "path" : "Extension.extension",
        "sliceName" : "preferredVaccine",
        "min" : 0,
        "max" : "1"
      },
      {
        "id" : "Extension.extension:preferredVaccine.extension",
        "path" : "Extension.extension.extension",
        "max" : "0"
      },
      {
        "id" : "Extension.extension:preferredVaccine.url",
        "path" : "Extension.extension.url",
        "fixedUri" : "preferredVaccine"
      },
      {
        "id" : "Extension.extension:preferredVaccine.value[x]",
        "path" : "Extension.extension.value[x]",
        "type" : [
          {
            "code" : "boolean"
          }
        ]
      },
      {
        "id" : "Extension.extension:preferredVaccineReason",
        "path" : "Extension.extension",
        "sliceName" : "preferredVaccineReason",
        "min" : 0,
        "max" : "1"
      },
      {
        "id" : "Extension.extension:preferredVaccineReason.extension",
        "path" : "Extension.extension.extension",
        "max" : "0"
      },
      {
        "id" : "Extension.extension:preferredVaccineReason.url",
        "path" : "Extension.extension.url",
        "fixedUri" : "preferredVaccineReason"
      },
      {
        "id" : "Extension.extension:preferredVaccineReason.value[x]",
        "path" : "Extension.extension.value[x]",
        "type" : [
          {
            "code" : "string"
          }
        ]
      },
      {
        "id" : "Extension.extension:allowedVaccine",
        "path" : "Extension.extension",
        "sliceName" : "allowedVaccine",
        "min" : 0,
        "max" : "1"
      },
      {
        "id" : "Extension.extension:allowedVaccine.extension",
        "path" : "Extension.extension.extension",
        "max" : "0"
      },
      {
        "id" : "Extension.extension:allowedVaccine.url",
        "path" : "Extension.extension.url",
        "fixedUri" : "allowedVaccine"
      },
      {
        "id" : "Extension.extension:allowedVaccine.value[x]",
        "path" : "Extension.extension.value[x]",
        "type" : [
          {
            "code" : "boolean"
          }
        ]
      },
      {
        "id" : "Extension.extension:allowedVaccineReason",
        "path" : "Extension.extension",
        "sliceName" : "allowedVaccineReason",
        "min" : 0,
        "max" : "1"
      },
      {
        "id" : "Extension.extension:allowedVaccineReason.extension",
        "path" : "Extension.extension.extension",
        "max" : "0"
      },
      {
        "id" : "Extension.extension:allowedVaccineReason.url",
        "path" : "Extension.extension.url",
        "fixedUri" : "allowedVaccineReason"
      },
      {
        "id" : "Extension.extension:allowedVaccineReason.value[x]",
        "path" : "Extension.extension.value[x]",
        "type" : [
          {
            "code" : "string"
          }
        ]
      },
      {
        "id" : "Extension.url",
        "path" : "Extension.url",
        "fixedUri" : "http://fhirfli.dev/fhir/ig/cicada/StructureDefinition/evaluation-detail-ext"
      },
      {
        "id" : "Extension.value[x]",
        "path" : "Extension.value[x]",
        "max" : "0"
      }
    ]
  }
}

```
