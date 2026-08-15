# The team - Bumblebee — a clinical record for emergency medical teams v0.1.0

## Resource Profile: The team 

 
The emergency medical team itself, and its type — Type 1 mobile or fixed, Type 2 with surgery and beds, Type 3 with intensive care. Type decides what the team can treat and therefore what it must refer. 

**Usages:**

* Refer to this Profile: [Visit](StructureDefinition-bumblebee-encounter.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/fhir.fhir-fli.bumblebee|current/StructureDefinition/StructureDefinition-bumblebee-organization.json)

### Formal Views of Profile Content

 [Description Differentials, Snapshots, and other representations](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](../StructureDefinition-bumblebee-organization.csv), [Excel](../StructureDefinition-bumblebee-organization.xlsx), [Schematron](../StructureDefinition-bumblebee-organization.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "bumblebee-organization",
  "url" : "http://fhir-fli.dev/bumblebee/StructureDefinition/bumblebee-organization",
  "version" : "0.1.0",
  "name" : "BumblebeeOrganization",
  "title" : "The team",
  "status" : "draft",
  "date" : "2026-08-14T17:06:47-04:00",
  "publisher" : "fhir-fli",
  "description" : "The emergency medical team itself, and its type — Type 1 mobile or fixed, Type 2 with surgery and beds, Type 3 with intensive care. Type decides what the team can treat and therefore what it must refer.",
  "fhirVersion" : "4.0.1",
  "mapping" : [{
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
    "identity" : "servd",
    "uri" : "http://www.omg.org/spec/ServD/1.0/",
    "name" : "ServD"
  },
  {
    "identity" : "w5",
    "uri" : "http://hl7.org/fhir/fivews",
    "name" : "FiveWs Pattern Mapping"
  }],
  "kind" : "resource",
  "abstract" : false,
  "type" : "Organization",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/Organization",
  "derivation" : "constraint",
  "differential" : {
    "element" : [{
      "id" : "Organization",
      "path" : "Organization"
    },
    {
      "id" : "Organization.extension",
      "path" : "Organization.extension",
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
      "id" : "Organization.extension:departureDate",
      "path" : "Organization.extension",
      "sliceName" : "departureDate",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "Extension",
        "profile" : ["http://fhir-fli.dev/bumblebee/StructureDefinition/departure-date"]
      }],
      "mustSupport" : true
    },
    {
      "id" : "Organization.type",
      "path" : "Organization.type",
      "mustSupport" : true
    },
    {
      "id" : "Organization.name",
      "path" : "Organization.name",
      "min" : 1,
      "mustSupport" : true
    },
    {
      "id" : "Organization.telecom",
      "path" : "Organization.telecom",
      "short" : "How to reach the team - the official contact for the organisation, not a person's number",
      "mustSupport" : true
    },
    {
      "id" : "Organization.address",
      "path" : "Organization.address",
      "short" : "Where the team is based. Distinct from BumblebeeLocation, which is the site being worked.",
      "mustSupport" : true
    }]
  }
}

```
