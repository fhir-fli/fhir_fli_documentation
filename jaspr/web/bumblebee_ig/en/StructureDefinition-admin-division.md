# Administrative division - Bumblebee — a clinical record for emergency medical teams v0.1.0

## Extension: Administrative division 

State, city and village. FHIR's Location has no element for an administrative hierarchy, and in a displacement setting the village is often the only part anyone can name.

**Context of Use**

**Usage info**

**Usages:**

* Use this Extension: [Where the team is working](StructureDefinition-bumblebee-location.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/fhir.fhir-fli.bumblebee|current/StructureDefinition/StructureDefinition-admin-division.json)

### Formal Views of Extension Content

 [Description Differentials, Snapshots, and other representations](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](../StructureDefinition-admin-division.csv), [Excel](../StructureDefinition-admin-division.xlsx), [Schematron](../StructureDefinition-admin-division.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "admin-division",
  "url" : "http://fhir-fli.dev/bumblebee/StructureDefinition/admin-division",
  "version" : "0.1.0",
  "name" : "AdminDivision",
  "title" : "Administrative division",
  "status" : "draft",
  "date" : "2026-08-14T17:06:47-04:00",
  "publisher" : "fhir-fli",
  "description" : "State, city and village. FHIR's Location has no element for an administrative hierarchy, and in a displacement setting the village is often the only part anyone can name.",
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
    "expression" : "Location"
  }],
  "type" : "Extension",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/Extension",
  "derivation" : "constraint",
  "differential" : {
    "element" : [{
      "id" : "Extension",
      "path" : "Extension"
    },
    {
      "id" : "Extension.extension:state",
      "path" : "Extension.extension",
      "sliceName" : "state",
      "min" : 0,
      "max" : "1"
    },
    {
      "id" : "Extension.extension:state.extension",
      "path" : "Extension.extension.extension",
      "max" : "0"
    },
    {
      "id" : "Extension.extension:state.url",
      "path" : "Extension.extension.url",
      "fixedUri" : "state"
    },
    {
      "id" : "Extension.extension:state.value[x]",
      "path" : "Extension.extension.value[x]",
      "type" : [{
        "code" : "string"
      }]
    },
    {
      "id" : "Extension.extension:city",
      "path" : "Extension.extension",
      "sliceName" : "city",
      "min" : 0,
      "max" : "1"
    },
    {
      "id" : "Extension.extension:city.extension",
      "path" : "Extension.extension.extension",
      "max" : "0"
    },
    {
      "id" : "Extension.extension:city.url",
      "path" : "Extension.extension.url",
      "fixedUri" : "city"
    },
    {
      "id" : "Extension.extension:city.value[x]",
      "path" : "Extension.extension.value[x]",
      "type" : [{
        "code" : "string"
      }]
    },
    {
      "id" : "Extension.extension:village",
      "path" : "Extension.extension",
      "sliceName" : "village",
      "min" : 0,
      "max" : "1"
    },
    {
      "id" : "Extension.extension:village.extension",
      "path" : "Extension.extension.extension",
      "max" : "0"
    },
    {
      "id" : "Extension.extension:village.url",
      "path" : "Extension.extension.url",
      "fixedUri" : "village"
    },
    {
      "id" : "Extension.extension:village.value[x]",
      "path" : "Extension.extension.value[x]",
      "type" : [{
        "code" : "string"
      }]
    },
    {
      "id" : "Extension.url",
      "path" : "Extension.url",
      "fixedUri" : "http://fhir-fli.dev/bumblebee/StructureDefinition/admin-division"
    },
    {
      "id" : "Extension.value[x]",
      "path" : "Extension.value[x]",
      "max" : "0"
    }]
  }
}

```
