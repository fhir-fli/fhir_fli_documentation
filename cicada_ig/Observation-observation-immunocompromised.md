# Observation: patient immunocompromised - The Cicada Vaccine Forecasting Engine and Guide v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Observation: patient immunocompromised**

## Example Observation: Observation: patient immunocompromised

Profile: [Observation Profile for Immunization Decision Support](StructureDefinition-VaccineObservationFhir.md)

**status**: Final

**code**: Patient immunocompromised

**subject**: [MMR: Patient is a healthcare worker, born before 1957, has received one dose of the MMR vaccine. Female, DoB: 1955-08-12](Patient-2016-UC-0032.md)

**effective**: 2015-04-30



## Resource Content

```json
{
  "resourceType" : "Observation",
  "id" : "observation-immunocompromised",
  "meta" : {
    "profile" : ["http://fhirfli.dev/fhir/ig/cicada/StructureDefinition/VaccineObservationFhir"]
  },
  "status" : "final",
  "code" : {
    "coding" : [{
      "system" : "http://snomed.info/sct",
      "code" : "370388006",
      "display" : "Patient immunocompromised"
    }]
  },
  "subject" : {
    "reference" : "Patient/2016-UC-0032"
  },
  "effectiveDateTime" : "2015-04-30"
}

```
