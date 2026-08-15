# Anticipated date of departure - Bumblebee — a clinical record for emergency medical teams v0.1.0

## Extension: Anticipated date of departure 

When the team expects to leave. Checked during field visits, and the handover to local health authorities must be coordinated at least seven days before shutdown.

**Context of Use**

**Usage info**

**Usages:**

* Use this Extension: [The team](StructureDefinition-bumblebee-organization.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/fhir.fhir-fli.bumblebee|current/StructureDefinition/StructureDefinition-departure-date.json)

### Formal Views of Extension Content

 [Description Differentials, Snapshots, and other representations](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](../StructureDefinition-departure-date.csv), [Excel](../StructureDefinition-departure-date.xlsx), [Schematron](../StructureDefinition-departure-date.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "departure-date",
  "url" : "http://fhir-fli.dev/bumblebee/StructureDefinition/departure-date",
  "version" : "0.1.0",
  "name" : "DepartureDate",
  "title" : "Anticipated date of departure",
  "status" : "draft",
  "date" : "2026-08-14T17:06:47-04:00",
  "publisher" : "fhir-fli",
  "description" : "When the team expects to leave. Checked during field visits, and the handover to local health authorities must be coordinated at least seven days before shutdown.",
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
    "expression" : "Organization"
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
      "fixedUri" : "http://fhir-fli.dev/bumblebee/StructureDefinition/departure-date"
    },
    {
      "id" : "Extension.value[x]",
      "path" : "Extension.value[x]",
      "type" : [{
        "code" : "date"
      }]
    }]
  }
}

```
