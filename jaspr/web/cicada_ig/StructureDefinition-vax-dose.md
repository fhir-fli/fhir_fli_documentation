# Dose of a Vaccine - The Cicada Vaccine Forecasting Engine and Guide v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Dose of a Vaccine**

## Resource Profile: Dose of a Vaccine 

| | |
| :--- | :--- |
| *Official URL*:http://fhirfli.dev/fhir/ig/cicada/StructureDefinition/vax-dose | *Version*:0.1.0 |
| Draft as of 2026-09-07 | *Computable Name*:VaxDose |

 
An administered dose as the engine reads it: the vaccine as CVX, the date, the patient, and optionally the dose volume, the manufacturer and a subpotency reason. The engine's evaluation of the dose is returned on ImmunizationEvaluation (target-dose-status-ext, evaluation-detail-ext), not written back onto the Immunization; until 2026-09-07 this profile declared thirteen evaluation extensions nothing ever emitted. 

**Usages:**

* Examples for this Profile: [Immunization/2016-UC-0032-dose1](Immunization-2016-UC-0032-dose1.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/cicada.ig|current/StructureDefinition/StructureDefinition-vax-dose.json)

### Formal Views of Profile Content

 [Description of Profiles, Differentials, Snapshots and how the different presentations work](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](StructureDefinition-vax-dose.csv), [Excel](StructureDefinition-vax-dose.xlsx), [Schematron](StructureDefinition-vax-dose.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "vax-dose",
  "url" : "http://fhirfli.dev/fhir/ig/cicada/StructureDefinition/vax-dose",
  "version" : "0.1.0",
  "name" : "VaxDose",
  "title" : "Dose of a Vaccine",
  "status" : "draft",
  "date" : "2026-09-07T19:51:55-04:00",
  "publisher" : "FHIR-FLI",
  "contact" : [{
    "name" : "FHIR-FLI",
    "telecom" : [{
      "system" : "url",
      "value" : "http://fhirfli.dev"
    }]
  }],
  "description" : "An administered dose as the engine reads it: the vaccine as CVX, the date, the patient, and optionally the dose volume, the manufacturer and a subpotency reason. The engine's evaluation of the dose is returned on ImmunizationEvaluation (target-dose-status-ext, evaluation-detail-ext), not written back onto the Immunization; until 2026-09-07 this profile declared thirteen evaluation extensions nothing ever emitted.",
  "fhirVersion" : "4.0.1",
  "mapping" : [{
    "identity" : "workflow",
    "uri" : "http://hl7.org/fhir/workflow",
    "name" : "Workflow Pattern"
  },
  {
    "identity" : "v2",
    "uri" : "http://hl7.org/v2",
    "name" : "HL7 v2 Mapping"
  },
  {
    "identity" : "rim",
    "uri" : "http://hl7.org/v3",
    "name" : "RIM Mapping"
  },
  {
    "identity" : "w5",
    "uri" : "http://hl7.org/fhir/fivews",
    "name" : "FiveWs Pattern Mapping"
  },
  {
    "identity" : "cda",
    "uri" : "http://hl7.org/v3/cda",
    "name" : "CDA (R2)"
  }],
  "kind" : "resource",
  "abstract" : false,
  "type" : "Immunization",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/Immunization",
  "derivation" : "constraint",
  "differential" : {
    "element" : [{
      "id" : "Immunization",
      "path" : "Immunization"
    },
    {
      "id" : "Immunization.statusReason",
      "path" : "Immunization.statusReason",
      "binding" : {
        "strength" : "extensible",
        "valueSet" : "http://fhirfli.dev/fhir/ig/cicada/ValueSet/eval-reason"
      }
    },
    {
      "id" : "Immunization.vaccineCode",
      "path" : "Immunization.vaccineCode",
      "binding" : {
        "strength" : "required",
        "valueSet" : "http://fhirfli.dev/fhir/ig/cicada/ValueSet/VaccineCodesCvxMvx"
      }
    },
    {
      "id" : "Immunization.occurrence[x]",
      "path" : "Immunization.occurrence[x]",
      "slicing" : {
        "discriminator" : [{
          "type" : "type",
          "path" : "$this"
        }],
        "ordered" : false,
        "rules" : "open"
      }
    },
    {
      "id" : "Immunization.occurrence[x]:occurrenceDateTime",
      "path" : "Immunization.occurrence[x]",
      "sliceName" : "occurrenceDateTime",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "dateTime"
      }]
    },
    {
      "id" : "Immunization.subpotentReason",
      "path" : "Immunization.subpotentReason",
      "binding" : {
        "strength" : "required",
        "valueSet" : "http://hl7.org/fhir/ValueSet/immunization-subpotent-reason"
      }
    }]
  }
}

```
