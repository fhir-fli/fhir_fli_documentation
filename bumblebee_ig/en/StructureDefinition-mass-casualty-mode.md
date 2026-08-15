# Mass casualty mode - Bumblebee — a clinical record for emergency medical teams v0.1.0

## Extension: Mass casualty mode 

Whether this visit was triaged under mass-casualty rules rather than ordinary ones.

**Context of Use**

**Usage info**

**Usages:**

* Use this Extension: [Visit](StructureDefinition-bumblebee-encounter.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/fhir.fhir-fli.bumblebee|current/StructureDefinition/StructureDefinition-mass-casualty-mode.json)

### Formal Views of Extension Content

 [Description Differentials, Snapshots, and other representations](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](../StructureDefinition-mass-casualty-mode.csv), [Excel](../StructureDefinition-mass-casualty-mode.xlsx), [Schematron](../StructureDefinition-mass-casualty-mode.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "mass-casualty-mode",
  "url" : "http://fhir-fli.dev/bumblebee/StructureDefinition/mass-casualty-mode",
  "version" : "0.1.0",
  "name" : "MassCasualtyMode",
  "title" : "Mass casualty mode",
  "status" : "draft",
  "date" : "2026-08-14T17:06:47-04:00",
  "publisher" : "fhir-fli",
  "description" : "Whether this visit was triaged under mass-casualty rules rather than ordinary ones.",
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
    "expression" : "Encounter"
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
      "fixedUri" : "http://fhir-fli.dev/bumblebee/StructureDefinition/mass-casualty-mode"
    },
    {
      "id" : "Extension.value[x]",
      "path" : "Extension.value[x]",
      "type" : [{
        "code" : "boolean"
      }]
    }]
  }
}

```
