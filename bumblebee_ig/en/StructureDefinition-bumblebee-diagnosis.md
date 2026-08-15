# Diagnosis made at this visit - Bumblebee — a clinical record for emergency medical teams v0.1.0

## Resource Profile: Diagnosis made at this visit 

 
What was wrong with the patient today. Kept apart from a problem they already had, because they are different clinical facts: the standing list is what this person lives with, today's diagnosis is what we are treating. Merge them and you lose the history a returning patient depends on. 

**Usages:**

* Derived from this Profile: [Notifiable disease](StructureDefinition-bumblebee-notifiable-disease.md)
* Refer to this Profile: [Visit](StructureDefinition-bumblebee-encounter.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/fhir.fhir-fli.bumblebee|current/StructureDefinition/StructureDefinition-bumblebee-diagnosis.json)

### Formal Views of Profile Content

 [Description Differentials, Snapshots, and other representations](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](../StructureDefinition-bumblebee-diagnosis.csv), [Excel](../StructureDefinition-bumblebee-diagnosis.xlsx), [Schematron](../StructureDefinition-bumblebee-diagnosis.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "bumblebee-diagnosis",
  "url" : "http://fhir-fli.dev/bumblebee/StructureDefinition/bumblebee-diagnosis",
  "version" : "0.1.0",
  "name" : "BumblebeeDiagnosis",
  "title" : "Diagnosis made at this visit",
  "status" : "draft",
  "date" : "2026-08-14T17:06:47-04:00",
  "publisher" : "fhir-fli",
  "description" : "What was wrong with the patient today. Kept apart from a problem they already had, because they are different clinical facts: the standing list is what this person lives with, today's diagnosis is what we are treating. Merge them and you lose the history a returning patient depends on.",
  "fhirVersion" : "4.0.1",
  "mapping" : [{
    "identity" : "workflow",
    "uri" : "http://hl7.org/fhir/workflow",
    "name" : "Workflow Pattern"
  },
  {
    "identity" : "sct-concept",
    "uri" : "http://snomed.info/conceptdomain",
    "name" : "SNOMED CT Concept Domain Binding"
  },
  {
    "identity" : "v2",
    "uri" : "http://hl7.org/v2",
    "name" : "HL7 v2 Mapping"
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
    "identity" : "sct-attr",
    "uri" : "http://snomed.org/attributebinding",
    "name" : "SNOMED CT Attribute Binding"
  }],
  "kind" : "resource",
  "abstract" : false,
  "type" : "Condition",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/Condition",
  "derivation" : "constraint",
  "differential" : {
    "element" : [{
      "id" : "Condition",
      "path" : "Condition"
    },
    {
      "id" : "Condition.extension",
      "path" : "Condition.extension",
      "slicing" : {
        "discriminator" : [{
          "type" : "value",
          "path" : "url"
        }],
        "ordered" : false,
        "rules" : "open"
      }
    },
    {
      "id" : "Condition.extension:disasterRelation",
      "path" : "Condition.extension",
      "sliceName" : "disasterRelation",
      "short" : "Was this caused by the disaster? Defaults to not known.",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "Extension",
        "profile" : ["http://fhir-fli.dev/bumblebee/StructureDefinition/disaster-relation"]
      }],
      "mustSupport" : true
    },
    {
      "id" : "Condition.extension:treatmentLevel",
      "path" : "Condition.extension",
      "sliceName" : "treatmentLevel",
      "short" : "Major, moderate or minor. Also says which type of team can handle it.",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "Extension",
        "profile" : ["http://fhir-fli.dev/bumblebee/StructureDefinition/treatment-level"]
      }],
      "mustSupport" : true
    },
    {
      "id" : "Condition.category",
      "path" : "Condition.category",
      "min" : 1,
      "patternCodeableConcept" : {
        "coding" : [{
          "system" : "http://terminology.hl7.org/CodeSystem/condition-category",
          "code" : "encounter-diagnosis"
        }]
      },
      "mustSupport" : true
    },
    {
      "id" : "Condition.code",
      "path" : "Condition.code",
      "short" : "What was wrong. TEXT ALONE IS VALID AND EXPECTED - a coded diagnosis is a bonus, never a gate. Most patients in a real deployment do not have one.",
      "min" : 1,
      "mustSupport" : true
    },
    {
      "id" : "Condition.code.coding",
      "path" : "Condition.code.coding",
      "short" : "If a code was chosen. DECISIONS.md Decision 20 says which system; Coding.userSelected marks which one the clinician actually picked.",
      "mustSupport" : true
    },
    {
      "id" : "Condition.code.text",
      "path" : "Condition.code.text",
      "mustSupport" : true
    },
    {
      "id" : "Condition.bodySite",
      "path" : "Condition.bodySite",
      "short" : "Where. Marked on a body diagram rather than typed.",
      "definition" : "Record a site on any injury, however small, if it helps whoever sees this patient next. A laceration is easier to find again when the record says which forearm.",
      "mustSupport" : true,
      "binding" : {
        "strength" : "extensible",
        "valueSet" : "http://fhir-fli.dev/bumblebee/ValueSet/body-region-vs"
      }
    },
    {
      "id" : "Condition.subject",
      "path" : "Condition.subject",
      "mustSupport" : true
    },
    {
      "id" : "Condition.encounter",
      "path" : "Condition.encounter",
      "min" : 1,
      "mustSupport" : true
    },
    {
      "id" : "Condition.onset[x]",
      "path" : "Condition.onset[x]",
      "slicing" : {
        "discriminator" : [{
          "type" : "type",
          "path" : "$this"
        }],
        "ordered" : false,
        "rules" : "open"
      }
    },
    {
      "id" : "Condition.onset[x]:onsetDateTime",
      "path" : "Condition.onset[x]",
      "sliceName" : "onsetDateTime",
      "short" : "When it started, which is not the same as when we saw them",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "dateTime"
      }],
      "mustSupport" : true
    }]
  }
}

```
