# Treatment level required - Bumblebee — a clinical record for emergency medical teams v0.1.0

## Extension: Treatment level required 

Major, moderate or minor. Mostly a statement about where this patient can be looked after: major needs a Type 2 or 3 team with surgery and beds, minor is within what a Type 1 mobile team can do. It is the judgement that decides whether they stay or travel.

**Context of Use**

**Usage info**

**Usages:**

* Use this Extension: [Diagnosis made at this visit](StructureDefinition-bumblebee-diagnosis.md) and [Something done to the patient](StructureDefinition-bumblebee-procedure.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/fhir.fhir-fli.bumblebee|current/StructureDefinition/StructureDefinition-treatment-level.json)

### Formal Views of Extension Content

 [Description Differentials, Snapshots, and other representations](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](../StructureDefinition-treatment-level.csv), [Excel](../StructureDefinition-treatment-level.xlsx), [Schematron](../StructureDefinition-treatment-level.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "treatment-level",
  "url" : "http://fhir-fli.dev/bumblebee/StructureDefinition/treatment-level",
  "version" : "0.1.0",
  "name" : "TreatmentLevel",
  "title" : "Treatment level required",
  "status" : "draft",
  "date" : "2026-08-14T17:06:47-04:00",
  "publisher" : "fhir-fli",
  "description" : "Major, moderate or minor. Mostly a statement about where this patient can be looked after: major needs a Type 2 or 3 team with surgery and beds, minor is within what a Type 1 mobile team can do. It is the judgement that decides whether they stay or travel.",
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
  },
  {
    "type" : "element",
    "expression" : "Procedure"
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
      "fixedUri" : "http://fhir-fli.dev/bumblebee/StructureDefinition/treatment-level"
    },
    {
      "id" : "Extension.value[x]",
      "path" : "Extension.value[x]",
      "type" : [{
        "code" : "code"
      }],
      "binding" : {
        "strength" : "required",
        "valueSet" : "http://fhir-fli.dev/bumblebee/ValueSet/treatment-level-vs"
      }
    }]
  }
}

```
