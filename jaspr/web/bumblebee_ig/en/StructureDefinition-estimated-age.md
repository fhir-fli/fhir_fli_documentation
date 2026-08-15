# Estimated age - Bumblebee — a clinical record for emergency medical teams v0.1.0

## Extension: Estimated age 

Age when date of birth is unknown, which in a disaster is common. FHIR has birthDate and nothing else, but age is what decides the dose, whether a child is screened for malnutrition, and how a presentation is read — and an estimate is often all anyone has.

**Context of Use**

**Usage info**

**Usages:**

* Use this Extension: [Patient](StructureDefinition-bumblebee-patient.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/fhir.fhir-fli.bumblebee|current/StructureDefinition/StructureDefinition-estimated-age.json)

### Formal Views of Extension Content

 [Description Differentials, Snapshots, and other representations](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](../StructureDefinition-estimated-age.csv), [Excel](../StructureDefinition-estimated-age.xlsx), [Schematron](../StructureDefinition-estimated-age.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "estimated-age",
  "url" : "http://fhir-fli.dev/bumblebee/StructureDefinition/estimated-age",
  "version" : "0.1.0",
  "name" : "EstimatedAge",
  "title" : "Estimated age",
  "status" : "draft",
  "date" : "2026-08-14T17:06:47-04:00",
  "publisher" : "fhir-fli",
  "description" : "Age when date of birth is unknown, which in a disaster is common. FHIR has birthDate and nothing else, but age is what decides the dose, whether a child is screened for malnutrition, and how a presentation is read — and an estimate is often all anyone has.",
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
    "expression" : "Patient"
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
      "fixedUri" : "http://fhir-fli.dev/bumblebee/StructureDefinition/estimated-age"
    },
    {
      "id" : "Extension.value[x]",
      "path" : "Extension.value[x]",
      "type" : [{
        "code" : "Age"
      }]
    }]
  }
}

```
