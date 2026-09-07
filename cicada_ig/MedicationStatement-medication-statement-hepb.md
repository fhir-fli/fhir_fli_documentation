# MedicationStatement: a vaccine recorded as a medication - The Cicada Vaccine Forecasting Engine and Guide v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **MedicationStatement: a vaccine recorded as a medication**

## Example MedicationStatement: MedicationStatement: a vaccine recorded as a medication

Profile: [Medication Statement Profile with Vaccine Codes](StructureDefinition-MedicationStatementProfile.md)

**status**: Completed

**medication**: Hep B, adolescent or pediatric

**subject**: [MMR: Patient is a healthcare worker, born before 1957, has received one dose of the MMR vaccine. Female, DoB: 1955-08-12](Patient-2016-UC-0032.md)

**effective**: 1998-03-10



## Resource Content

```json
{
  "resourceType" : "MedicationStatement",
  "id" : "medication-statement-hepb",
  "meta" : {
    "profile" : ["http://fhirfli.dev/fhir/ig/cicada/StructureDefinition/MedicationStatementProfile"]
  },
  "status" : "completed",
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
  "effectiveDateTime" : "1998-03-10"
}

```
