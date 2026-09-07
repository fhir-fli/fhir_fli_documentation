# 2016-UC-0032-1 - The Cicada Vaccine Forecasting Engine and Guide v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **2016-UC-0032-1**

## ImmunizationEvaluation: 2016-UC-0032-1

Profile: [ImmDS Immunization Evaluation](http://hl7.org/fhir/us/immds/STU1/StructureDefinition-immds-immunizationevaluation.html)

> **Engine and Supporting Data Version**
* engine: cicada/0.0.1
* supportingData: CDSi 4.65-508

**Target Dose Status**: Satisfied

> **Evaluation Sub-step Detail**
* validAgeReason: Age: Grace Period
* preferredInterval: true
* conflict: false
* preferredVaccine: true

**status**: Completed

**patient**: [MMR: Patient is a healthcare worker, born before 1957, has received one dose of the MMR vaccine. Female, DoB: 1955-08-12](Patient-2016-UC-0032.md)

**date**: 2015-04-30 00:00:00-0400

**targetDisease**: Mumps

**immunizationEvent**: [Immunization: status = completed; vaccineCode = MMR; occurrence[x] = 2015-04-30](Immunization-2016-UC-0032-dose1.md)

**doseStatus**: Valid

**series**: Mumps 2-dose series

**doseNumber**: 1

**seriesDoses**: 2



## Resource Content

```json
{
  "resourceType" : "ImmunizationEvaluation",
  "id" : "2016-UC-0032-1",
  "meta" : {
    "profile" : ["http://hl7.org/fhir/us/immds/StructureDefinition/immds-immunizationevaluation"]
  },
  "extension" : [{
    "extension" : [{
      "url" : "engine",
      "valueString" : "cicada/0.0.1"
    },
    {
      "url" : "supportingData",
      "valueString" : "CDSi 4.65-508"
    }],
    "url" : "http://fhirfli.dev/fhir/ig/cicada/StructureDefinition/engine-version-ext"
  },
  {
    "url" : "http://fhirfli.dev/fhir/ig/cicada/StructureDefinition/target-dose-status-ext",
    "valueCodeableConcept" : {
      "coding" : [{
        "system" : "http://fhirfli.dev/fhir/ig/cicada/CodeSystem/target-dose-status",
        "code" : "satisfied",
        "display" : "Satisfied"
      }]
    }
  },
  {
    "extension" : [{
      "url" : "validAgeReason",
      "valueString" : "Age: Grace Period"
    },
    {
      "url" : "preferredInterval",
      "valueBoolean" : true
    },
    {
      "url" : "conflict",
      "valueBoolean" : false
    },
    {
      "url" : "preferredVaccine",
      "valueBoolean" : true
    }],
    "url" : "http://fhirfli.dev/fhir/ig/cicada/StructureDefinition/evaluation-detail-ext"
  }],
  "status" : "completed",
  "patient" : {
    "reference" : "Patient/2016-UC-0032"
  },
  "date" : "2015-04-30T00:00:00.000-04:00",
  "targetDisease" : {
    "coding" : [{
      "system" : "http://snomed.info/sct",
      "code" : "36989005",
      "display" : "Mumps"
    }],
    "text" : "Mumps"
  },
  "immunizationEvent" : {
    "reference" : "Immunization/2016-UC-0032-dose1"
  },
  "doseStatus" : {
    "coding" : [{
      "system" : "http://terminology.hl7.org/CodeSystem/immunization-evaluation-dose-status",
      "code" : "valid",
      "display" : "Valid"
    }]
  },
  "series" : "Mumps 2-dose series",
  "doseNumberPositiveInt" : 1,
  "seriesDosesPositiveInt" : 2
}

```
