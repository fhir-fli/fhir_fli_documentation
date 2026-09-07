# Procedure: haemopoietic stem cell transplant - The Cicada Vaccine Forecasting Engine and Guide v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Procedure: haemopoietic stem cell transplant**

## Example Procedure: Procedure: haemopoietic stem cell transplant

Profile: [Immunization Procedures Profile](StructureDefinition-ProcedureProfile.md)

**status**: Completed

**code**: Hemopoietic stem cell transplant

**subject**: [MMR: Patient is a healthcare worker, born before 1957, has received one dose of the MMR vaccine. Female, DoB: 1955-08-12](Patient-2016-UC-0032.md)

**performed**: 2014-11-02



## Resource Content

```json
{
  "resourceType" : "Procedure",
  "id" : "procedure-stem-cell-transplant",
  "meta" : {
    "profile" : ["http://fhirfli.dev/fhir/ig/cicada/StructureDefinition/ProcedureProfile"]
  },
  "status" : "completed",
  "code" : {
    "coding" : [{
      "system" : "http://snomed.info/sct",
      "code" : "234336002"
    }]
  },
  "subject" : {
    "reference" : "Patient/2016-UC-0032"
  },
  "performedDateTime" : "2014-11-02"
}

```
