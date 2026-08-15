# Exposure history - Bumblebee — a clinical record for emergency medical teams v0.1.0

## Extension: Exposure history 

Where the person is thought to have been exposed. Asked for by the surveillance standards for notifiable conditions, and by nothing else.

**Context of Use**

**Usage info**

**Usages:**

* Use this Extension: [Notifiable disease](StructureDefinition-bumblebee-notifiable-disease.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/fhir.fhir-fli.bumblebee|current/StructureDefinition/StructureDefinition-exposure-history.json)

### Formal Views of Extension Content

 [Description Differentials, Snapshots, and other representations](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](../StructureDefinition-exposure-history.csv), [Excel](../StructureDefinition-exposure-history.xlsx), [Schematron](../StructureDefinition-exposure-history.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "exposure-history",
  "url" : "http://fhir-fli.dev/bumblebee/StructureDefinition/exposure-history",
  "version" : "0.1.0",
  "name" : "ExposureHistory",
  "title" : "Exposure history",
  "status" : "draft",
  "date" : "2026-08-14T17:06:47-04:00",
  "publisher" : "fhir-fli",
  "description" : "Where the person is thought to have been exposed. Asked for by the surveillance standards for notifiable conditions, and by nothing else.",
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
      "fixedUri" : "http://fhir-fli.dev/bumblebee/StructureDefinition/exposure-history"
    },
    {
      "id" : "Extension.value[x]",
      "path" : "Extension.value[x]",
      "type" : [{
        "code" : "string"
      }]
    }]
  }
}

```
