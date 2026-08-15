# Medicine they took away - Bumblebee — a clinical record for emergency medical teams v0.1.0

## Resource Profile: Medicine they took away 

 
What was counted out and handed over at the end of the visit — the drug, how much of it, and when they were given it. Distinct from what was given in the tent: this is a supply the patient administers themselves, somewhere else, for days. A later clinician asks how much they were given and whether it has run out, and neither question can be answered from an administration record. 

**Usages:**

* This Profile is not used by any profiles in this Specification

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/fhir.fhir-fli.bumblebee|current/StructureDefinition/StructureDefinition-bumblebee-medication-take-home.json)

### Formal Views of Profile Content

 [Description Differentials, Snapshots, and other representations](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](../StructureDefinition-bumblebee-medication-take-home.csv), [Excel](../StructureDefinition-bumblebee-medication-take-home.xlsx), [Schematron](../StructureDefinition-bumblebee-medication-take-home.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "bumblebee-medication-take-home",
  "url" : "http://fhir-fli.dev/bumblebee/StructureDefinition/bumblebee-medication-take-home",
  "version" : "0.1.0",
  "name" : "BumblebeeMedicationTakeHome",
  "title" : "Medicine they took away",
  "status" : "draft",
  "date" : "2026-08-14T17:06:47-04:00",
  "publisher" : "fhir-fli",
  "description" : "What was counted out and handed over at the end of the visit — the drug, how much of it, and when they were given it. Distinct from what was given in the tent: this is a supply the patient administers themselves, somewhere else, for days. A later clinician asks how much they were given and whether it has run out, and neither question can be answered from an administration record.",
  "fhirVersion" : "4.0.1",
  "mapping" : [{
    "identity" : "workflow",
    "uri" : "http://hl7.org/fhir/workflow",
    "name" : "Workflow Pattern"
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
    "identity" : "rx-dispense-rmim",
    "uri" : "http://www.hl7.org/v3/PORX_RM020070UV",
    "name" : "V3 Pharmacy Dispense RMIM"
  },
  {
    "identity" : "v2",
    "uri" : "http://hl7.org/v2",
    "name" : "HL7 v2 Mapping"
  }],
  "kind" : "resource",
  "abstract" : false,
  "type" : "MedicationDispense",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/MedicationDispense",
  "derivation" : "constraint",
  "differential" : {
    "element" : [{
      "id" : "MedicationDispense",
      "path" : "MedicationDispense"
    },
    {
      "id" : "MedicationDispense.status",
      "path" : "MedicationDispense.status",
      "mustSupport" : true
    },
    {
      "id" : "MedicationDispense.medication[x]",
      "path" : "MedicationDispense.medication[x]",
      "short" : "From the deployment's own formulary — the team cannot hand over what it did not bring. Free text stays possible.",
      "mustSupport" : true
    },
    {
      "id" : "MedicationDispense.subject",
      "path" : "MedicationDispense.subject",
      "min" : 1,
      "mustSupport" : true
    },
    {
      "id" : "MedicationDispense.context",
      "path" : "MedicationDispense.context",
      "short" : "The visit it was handed over at.",
      "mustSupport" : true
    },
    {
      "id" : "MedicationDispense.performer",
      "path" : "MedicationDispense.performer",
      "mustSupport" : true
    },
    {
      "id" : "MedicationDispense.quantity",
      "path" : "MedicationDispense.quantity",
      "short" : "How much went in the bag. Not the dose — the amount handed over.",
      "mustSupport" : true
    },
    {
      "id" : "MedicationDispense.daysSupply",
      "path" : "MedicationDispense.daysSupply",
      "short" : "How long it lasts. This is the field the two-week continuity obligation for chronic conditions is measured in (Blue Book 5.1.10), and it is what tells a clinician three weeks later whether the patient ran out or stopped.",
      "mustSupport" : true
    },
    {
      "id" : "MedicationDispense.whenHandedOver",
      "path" : "MedicationDispense.whenHandedOver",
      "short" : "When they got it. With daysSupply this gives the date it runs out, which is the date the patient needs to be somewhere.",
      "mustSupport" : true
    },
    {
      "id" : "MedicationDispense.note",
      "path" : "MedicationDispense.note",
      "mustSupport" : true
    },
    {
      "id" : "MedicationDispense.dosageInstruction",
      "path" : "MedicationDispense.dosageInstruction",
      "short" : "How to take it. Goes onto the paper the patient carries as well as into the record.",
      "mustSupport" : true
    }]
  }
}

```
