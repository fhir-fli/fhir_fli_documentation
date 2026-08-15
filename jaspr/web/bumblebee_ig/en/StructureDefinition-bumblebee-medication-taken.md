# Medicine they already take - Bumblebee — a clinical record for emergency medical teams v0.1.0

## Resource Profile: Medicine they already take 

 
What this patient was on before they met us, as far as anyone knows. Required to give two weeks of treatment continuity for a chronic condition (Blue Book 5.1.10), and required before giving anything that might interact. Often the patient is the only source and the bottle is gone — so 'they said a white tablet for blood pressure' is a legitimate entry and must be recordable. 

**Usages:**

* This Profile is not used by any profiles in this Specification

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/fhir.fhir-fli.bumblebee|current/StructureDefinition/StructureDefinition-bumblebee-medication-taken.json)

### Formal Views of Profile Content

 [Description Differentials, Snapshots, and other representations](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](../StructureDefinition-bumblebee-medication-taken.csv), [Excel](../StructureDefinition-bumblebee-medication-taken.xlsx), [Schematron](../StructureDefinition-bumblebee-medication-taken.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "bumblebee-medication-taken",
  "url" : "http://fhir-fli.dev/bumblebee/StructureDefinition/bumblebee-medication-taken",
  "version" : "0.1.0",
  "name" : "BumblebeeMedicationTaken",
  "title" : "Medicine they already take",
  "status" : "draft",
  "date" : "2026-08-14T17:06:47-04:00",
  "publisher" : "fhir-fli",
  "description" : "What this patient was on before they met us, as far as anyone knows. Required to give two weeks of treatment continuity for a chronic condition (Blue Book 5.1.10), and required before giving anything that might interact. Often the patient is the only source and the bottle is gone — so 'they said a white tablet for blood pressure' is a legitimate entry and must be recordable.",
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
  }],
  "kind" : "resource",
  "abstract" : false,
  "type" : "MedicationStatement",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/MedicationStatement",
  "derivation" : "constraint",
  "differential" : {
    "element" : [{
      "id" : "MedicationStatement",
      "path" : "MedicationStatement"
    },
    {
      "id" : "MedicationStatement.status",
      "path" : "MedicationStatement.status",
      "mustSupport" : true
    },
    {
      "id" : "MedicationStatement.medication[x]",
      "path" : "MedicationStatement.medication[x]",
      "short" : "Often text only. A displaced patient rarely has the box, and 'a white tablet for blood pressure' is worth more in the record than nothing.",
      "mustSupport" : true
    },
    {
      "id" : "MedicationStatement.subject",
      "path" : "MedicationStatement.subject",
      "mustSupport" : true
    },
    {
      "id" : "MedicationStatement.effective[x]",
      "path" : "MedicationStatement.effective[x]",
      "mustSupport" : true
    },
    {
      "id" : "MedicationStatement.informationSource",
      "path" : "MedicationStatement.informationSource",
      "short" : "Who said so — the patient, a relative, a label, another clinician. It changes how much weight to put on it.",
      "mustSupport" : true
    },
    {
      "id" : "MedicationStatement.note",
      "path" : "MedicationStatement.note",
      "mustSupport" : true
    },
    {
      "id" : "MedicationStatement.dosage",
      "path" : "MedicationStatement.dosage",
      "mustSupport" : true
    }]
  }
}

```
