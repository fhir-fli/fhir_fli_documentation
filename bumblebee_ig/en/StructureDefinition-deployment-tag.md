# Deployment - Bumblebee — a clinical record for emergency medical teams v0.1.0

## Extension: Deployment 

Which deployment produced this record. Makes purging one deployment a single verifiable operation.

**Context of Use**

**Usage info**

**Usages:**

* Use this Extension: [Visit](StructureDefinition-bumblebee-encounter.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/fhir.fhir-fli.bumblebee|current/StructureDefinition/StructureDefinition-deployment-tag.json)

### Formal Views of Extension Content

 [Description Differentials, Snapshots, and other representations](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](../StructureDefinition-deployment-tag.csv), [Excel](../StructureDefinition-deployment-tag.xlsx), [Schematron](../StructureDefinition-deployment-tag.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "deployment-tag",
  "url" : "http://fhir-fli.dev/bumblebee/StructureDefinition/deployment-tag",
  "version" : "0.1.0",
  "name" : "DeploymentTag",
  "title" : "Deployment",
  "status" : "draft",
  "date" : "2026-08-14T17:06:47-04:00",
  "publisher" : "fhir-fli",
  "description" : "Which deployment produced this record. Makes purging one deployment a single verifiable operation.",
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
    "expression" : "Resource"
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
      "fixedUri" : "http://fhir-fli.dev/bumblebee/StructureDefinition/deployment-tag"
    },
    {
      "id" : "Extension.value[x]",
      "path" : "Extension.value[x]",
      "type" : [{
        "code" : "Identifier"
      }]
    }]
  }
}

```
