# The copy the patient keeps - Bumblebee — a clinical record for emergency medical teams v0.1.0

## Resource Profile: The copy the patient keeps 

 
Every patient is offered a record of the treatment performed, and a referral for follow-up where needed. Shaped like an International Patient Summary because that standard exists for exactly this — a clinician who has never met this person, reading it cold. In a real deployment three quarters of patients leave with no follow-up arranged, which makes this the most-used artefact in the system. 

**Usages:**

* This Profile is not used by any profiles in this Specification

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/fhir.fhir-fli.bumblebee|current/StructureDefinition/StructureDefinition-bumblebee-patient-summary.json)

### Formal Views of Profile Content

 [Description Differentials, Snapshots, and other representations](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](../StructureDefinition-bumblebee-patient-summary.csv), [Excel](../StructureDefinition-bumblebee-patient-summary.xlsx), [Schematron](../StructureDefinition-bumblebee-patient-summary.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "bumblebee-patient-summary",
  "url" : "http://fhir-fli.dev/bumblebee/StructureDefinition/bumblebee-patient-summary",
  "version" : "0.1.0",
  "name" : "BumblebeePatientSummary",
  "title" : "The copy the patient keeps",
  "status" : "draft",
  "date" : "2026-08-14T17:06:47-04:00",
  "publisher" : "fhir-fli",
  "description" : "Every patient is offered a record of the treatment performed, and a referral for follow-up where needed. Shaped like an International Patient Summary because that standard exists for exactly this — a clinician who has never met this person, reading it cold. In a real deployment three quarters of patients leave with no follow-up arranged, which makes this the most-used artefact in the system.",
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
    "identity" : "cda",
    "uri" : "http://hl7.org/v3/cda",
    "name" : "CDA (R2)"
  },
  {
    "identity" : "fhirdocumentreference",
    "uri" : "http://hl7.org/fhir/documentreference",
    "name" : "FHIR DocumentReference"
  },
  {
    "identity" : "w5",
    "uri" : "http://hl7.org/fhir/fivews",
    "name" : "FiveWs Pattern Mapping"
  }],
  "kind" : "resource",
  "abstract" : false,
  "type" : "Composition",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/Composition",
  "derivation" : "constraint",
  "differential" : {
    "element" : [{
      "id" : "Composition",
      "path" : "Composition"
    },
    {
      "id" : "Composition.status",
      "path" : "Composition.status",
      "mustSupport" : true
    },
    {
      "id" : "Composition.subject",
      "path" : "Composition.subject",
      "min" : 1,
      "mustSupport" : true
    },
    {
      "id" : "Composition.section",
      "path" : "Composition.section",
      "mustSupport" : true
    }]
  }
}

```
