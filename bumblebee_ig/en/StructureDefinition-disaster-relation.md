# Relation to the disaster - Bumblebee — a clinical record for emergency medical teams v0.1.0

## Extension: Relation to the disaster 

Whether this problem was caused by the disaster. Nothing about the patient's care changes with the answer — it is an obligation the team owes upward, never a clinical question, and it is never asked during a consultation. Defaults to unknown, and unknown is a complete answer. On the Condition rather than the visit, because cause is true of a problem: one visit can hold a crush injury and long-standing diabetes.

**Context of Use**

**Usage info**

**Usages:**

* Use this Extension: [Diagnosis made at this visit](StructureDefinition-bumblebee-diagnosis.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/fhir.fhir-fli.bumblebee|current/StructureDefinition/StructureDefinition-disaster-relation.json)

### Formal Views of Extension Content

 [Description Differentials, Snapshots, and other representations](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](../StructureDefinition-disaster-relation.csv), [Excel](../StructureDefinition-disaster-relation.xlsx), [Schematron](../StructureDefinition-disaster-relation.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "disaster-relation",
  "url" : "http://fhir-fli.dev/bumblebee/StructureDefinition/disaster-relation",
  "version" : "0.1.0",
  "name" : "DisasterRelation",
  "title" : "Relation to the disaster",
  "status" : "draft",
  "date" : "2026-08-14T17:06:47-04:00",
  "publisher" : "fhir-fli",
  "description" : "Whether this problem was caused by the disaster. Nothing about the patient's care changes with the answer — it is an obligation the team owes upward, never a clinical question, and it is never asked during a consultation. Defaults to unknown, and unknown is a complete answer. On the Condition rather than the visit, because cause is true of a problem: one visit can hold a crush injury and long-standing diabetes.",
  "fhirVersion" : "4.0.1",
  "mapping" : [{
    "identity" : "rim",
    "uri" : "http://hl7.org/v3",
    "name" : "RIM Mapping"
  }],
  "kind" : "complex-type",
  "abstract" : false,
  "context" : [{
    "type" : "element",
    "expression" : "Condition"
  }],
  "type" : "Extension",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/Extension",
  "derivation" : "constraint",
  "differential" : {
    "element" : [{
      "id" : "Extension.extension",
      "path" : "Extension.extension",
      "max" : "0"
    },
    {
      "id" : "Extension.url",
      "path" : "Extension.url",
      "fixedUri" : "http://fhir-fli.dev/bumblebee/StructureDefinition/disaster-relation"
    },
    {
      "id" : "Extension.value[x]",
      "path" : "Extension.value[x]",
      "type" : [{
        "code" : "code"
      }],
      "binding" : {
        "strength" : "required",
        "valueSet" : "http://fhir-fli.dev/bumblebee/ValueSet/disaster-relation-vs"
      }
    }]
  }
}

```
