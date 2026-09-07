# MedicationRequest: a vaccine ordered as a medication - The Cicada Vaccine Forecasting Engine and Guide v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **MedicationRequest: a vaccine ordered as a medication**

## Example MedicationRequest: MedicationRequest: a vaccine ordered as a medication

Profile: [Medication Request Profile with Vaccine Codes](StructureDefinition-MedicationRequestProfile.md)

**status**: Completed

**intent**: Order

**medication**: Hep B, adolescent or pediatric

**subject**: [MMR: Patient is a healthcare worker, born before 1957, has received one dose of the MMR vaccine. Female, DoB: 1955-08-12](Patient-2016-UC-0032.md)

**authoredOn**: 1998-03-10



## Resource Content

```json
{
  "resourceType" : "MedicationRequest",
  "id" : "medication-request-hepb",
  "meta" : {
    "profile" : ["http://fhirfli.dev/fhir/ig/cicada/StructureDefinition/MedicationRequestProfile"]
  },
  "status" : "completed",
  "intent" : "order",
  "medicationCodeableConcept" : {
    "coding" : [{
      "system" : "http://hl7.org/fhir/sid/cvx",
      "code" : "08",
      "display" : "Hep B, adolescent or pediatric"
    }]
  },
  "subject" : {
    "reference" : "Patient/2016-UC-0032"
  },
  "authoredOn" : "1998-03-10"
}

```
