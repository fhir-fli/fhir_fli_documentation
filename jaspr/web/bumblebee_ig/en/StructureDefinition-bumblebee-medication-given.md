# Medicine given - Bumblebee — a clinical record for emergency medical teams v0.1.0

## Resource Profile: Medicine given 

 
A drug that actually went into this patient, at a time, by someone. Not a prescription — in a field clinic the person who decides and the person who hands over the tablets are usually the same person in the same tent, and what a later clinician needs to know is what the patient actually received. Answers 'what have we already given them?' at three in the morning, which a note in prose cannot. 

**Usages:**

* This Profile is not used by any profiles in this Specification

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/fhir.fhir-fli.bumblebee|current/StructureDefinition/StructureDefinition-bumblebee-medication-given.json)

### Formal Views of Profile Content

 [Description Differentials, Snapshots, and other representations](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](../StructureDefinition-bumblebee-medication-given.csv), [Excel](../StructureDefinition-bumblebee-medication-given.xlsx), [Schematron](../StructureDefinition-bumblebee-medication-given.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "bumblebee-medication-given",
  "url" : "http://fhir-fli.dev/bumblebee/StructureDefinition/bumblebee-medication-given",
  "version" : "0.1.0",
  "name" : "BumblebeeMedicationGiven",
  "title" : "Medicine given",
  "status" : "draft",
  "date" : "2026-08-14T17:06:47-04:00",
  "publisher" : "fhir-fli",
  "description" : "A drug that actually went into this patient, at a time, by someone. Not a prescription — in a field clinic the person who decides and the person who hands over the tablets are usually the same person in the same tent, and what a later clinician needs to know is what the patient actually received. Answers 'what have we already given them?' at three in the morning, which a note in prose cannot.",
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
    "identity" : "v2",
    "uri" : "http://hl7.org/v2",
    "name" : "HL7 v2 Mapping"
  },
  {
    "identity" : "w3c.prov",
    "uri" : "http://www.w3.org/ns/prov",
    "name" : "W3C PROV"
  }],
  "kind" : "resource",
  "abstract" : false,
  "type" : "MedicationAdministration",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/MedicationAdministration",
  "derivation" : "constraint",
  "differential" : {
    "element" : [{
      "id" : "MedicationAdministration",
      "path" : "MedicationAdministration"
    },
    {
      "id" : "MedicationAdministration.status",
      "path" : "MedicationAdministration.status",
      "mustSupport" : true
    },
    {
      "id" : "MedicationAdministration.medication[x]",
      "path" : "MedicationAdministration.medication[x]",
      "short" : "What. A CodeableConcept from the deployment's own formulary — the team cannot give what it did not bring, so the list is bounded before deployment (ARCHITECTURE.md §6). Free text stays possible for anything given from outside the kit.",
      "mustSupport" : true
    },
    {
      "id" : "MedicationAdministration.subject",
      "path" : "MedicationAdministration.subject",
      "mustSupport" : true
    },
    {
      "id" : "MedicationAdministration.context",
      "path" : "MedicationAdministration.context",
      "short" : "The visit. Required — an unattached administration cannot be put in order against the rest of the visit.",
      "min" : 1,
      "mustSupport" : true
    },
    {
      "id" : "MedicationAdministration.effective[x]",
      "path" : "MedicationAdministration.effective[x]",
      "short" : "When. Required — 'what has this patient already had, and when' is the question this profile exists to answer.",
      "mustSupport" : true
    },
    {
      "id" : "MedicationAdministration.performer",
      "path" : "MedicationAdministration.performer",
      "short" : "Who gave it.",
      "mustSupport" : true
    },
    {
      "id" : "MedicationAdministration.reasonReference",
      "path" : "MedicationAdministration.reasonReference",
      "short" : "The problem it was given for, if it is worth saying.",
      "mustSupport" : true
    },
    {
      "id" : "MedicationAdministration.note",
      "path" : "MedicationAdministration.note",
      "mustSupport" : true
    },
    {
      "id" : "MedicationAdministration.dosage",
      "path" : "MedicationAdministration.dosage",
      "mustSupport" : true
    },
    {
      "id" : "MedicationAdministration.dosage.route",
      "path" : "MedicationAdministration.dosage.route",
      "mustSupport" : true
    },
    {
      "id" : "MedicationAdministration.dosage.dose",
      "path" : "MedicationAdministration.dosage.dose",
      "mustSupport" : true
    }]
  }
}

```
