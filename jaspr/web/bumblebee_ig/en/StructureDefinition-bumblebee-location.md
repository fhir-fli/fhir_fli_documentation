# Where the team is working - Bumblebee — a clinical record for emergency medical teams v0.1.0

## Resource Profile: Where the team is working 

 
The site. Carries the state, city and village hierarchy that FHIR has no element for, and a geographic position — in a disaster a team is often in a field with no address, and a place name alone will not bring anyone back to it. 

**Usages:**

* This Profile is not used by any profiles in this Specification

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/fhir.fhir-fli.bumblebee|current/StructureDefinition/StructureDefinition-bumblebee-location.json)

### Formal Views of Profile Content

 [Description Differentials, Snapshots, and other representations](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](../StructureDefinition-bumblebee-location.csv), [Excel](../StructureDefinition-bumblebee-location.xlsx), [Schematron](../StructureDefinition-bumblebee-location.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "bumblebee-location",
  "url" : "http://fhir-fli.dev/bumblebee/StructureDefinition/bumblebee-location",
  "version" : "0.1.0",
  "name" : "BumblebeeLocation",
  "title" : "Where the team is working",
  "status" : "draft",
  "date" : "2026-08-14T17:06:47-04:00",
  "publisher" : "fhir-fli",
  "description" : "The site. Carries the state, city and village hierarchy that FHIR has no element for, and a geographic position — in a disaster a team is often in a field with no address, and a place name alone will not bring anyone back to it.",
  "fhirVersion" : "4.0.1",
  "mapping" : [{
    "identity" : "rim",
    "uri" : "http://hl7.org/v3",
    "name" : "RIM Mapping"
  },
  {
    "identity" : "w5",
    "uri" : "http://hl7.org/fhir/fivews",
    "name" : "FiveWs Pattern Mapping"
  }],
  "kind" : "resource",
  "abstract" : false,
  "type" : "Location",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/Location",
  "derivation" : "constraint",
  "differential" : {
    "element" : [{
      "id" : "Location",
      "path" : "Location"
    },
    {
      "id" : "Location.extension",
      "path" : "Location.extension",
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
      "id" : "Location.extension:adminDivision",
      "path" : "Location.extension",
      "sliceName" : "adminDivision",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "Extension",
        "profile" : ["http://fhir-fli.dev/bumblebee/StructureDefinition/admin-division"]
      }],
      "mustSupport" : true
    },
    {
      "id" : "Location.name",
      "path" : "Location.name",
      "mustSupport" : true
    },
    {
      "id" : "Location.position",
      "path" : "Location.position",
      "mustSupport" : true
    }]
  }
}

```
