# 2016-UC-0032-dose1 - The Cicada Vaccine Forecasting Engine and Guide v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **2016-UC-0032-dose1**

## Immunization: 2016-UC-0032-dose1

Profile: [Dose of a Vaccine](StructureDefinition-vax-dose.md)

**status**: Completed

**vaccineCode**: MMR

**patient**: [MMR: Patient is a healthcare worker, born before 1957, has received one dose of the MMR vaccine. Female, DoB: 1955-08-12](Patient-2016-UC-0032.md)

**occurrence**: 2015-04-30



## Resource Content

```json
{
  "resourceType" : "Immunization",
  "id" : "2016-UC-0032-dose1",
  "meta" : {
    "profile" : ["http://fhirfli.dev/fhir/ig/cicada/StructureDefinition/vax-dose"]
  },
  "status" : "completed",
  "vaccineCode" : {
    "coding" : [{
      "system" : "http://hl7.org/fhir/sid/cvx",
      "code" : "03",
      "display" : "MMR"
    },
    {
      "system" : "http://hl7.org/fhir/sid/mvx",
      "code" : "MSD",
      "display" : "Merck and Co., Inc."
    }]
  },
  "patient" : {
    "reference" : "Patient/2016-UC-0032",
    "type" : "Patient"
  },
  "occurrenceDateTime" : "2015-04-30"
}

```
