# Vaccine given - Bumblebee — a clinical record for emergency medical teams v0.1.0

## Resource Profile: Vaccine given 

 
A vaccine this patient received from us, or one they tell us they have had. Records what was given rather than a schedule we manage — running routine immunisation programmes is not an emergency medical team's job, but tetanus cover after a wound, post-exposure prophylaxis and outbreak response all are, and checking vaccination status is a named part of discharging a child. 

**Usages:**

* This Profile is not used by any profiles in this Specification

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/fhir.fhir-fli.bumblebee|current/StructureDefinition/StructureDefinition-bumblebee-immunization.json)

### Formal Views of Profile Content

 [Description Differentials, Snapshots, and other representations](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](../StructureDefinition-bumblebee-immunization.csv), [Excel](../StructureDefinition-bumblebee-immunization.xlsx), [Schematron](../StructureDefinition-bumblebee-immunization.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "bumblebee-immunization",
  "url" : "http://fhir-fli.dev/bumblebee/StructureDefinition/bumblebee-immunization",
  "version" : "0.1.0",
  "name" : "BumblebeeImmunization",
  "title" : "Vaccine given",
  "status" : "draft",
  "date" : "2026-08-14T17:06:47-04:00",
  "publisher" : "fhir-fli",
  "description" : "A vaccine this patient received from us, or one they tell us they have had. Records what was given rather than a schedule we manage — running routine immunisation programmes is not an emergency medical team's job, but tetanus cover after a wound, post-exposure prophylaxis and outbreak response all are, and checking vaccination status is a named part of discharging a child.",
  "fhirVersion" : "4.0.1",
  "mapping" : [{
    "identity" : "workflow",
    "uri" : "http://hl7.org/fhir/workflow",
    "name" : "Workflow Pattern"
  },
  {
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
    "identity" : "w5",
    "uri" : "http://hl7.org/fhir/fivews",
    "name" : "FiveWs Pattern Mapping"
  },
  {
    "identity" : "cda",
    "uri" : "http://hl7.org/v3/cda",
    "name" : "CDA (R2)"
  }],
  "kind" : "resource",
  "abstract" : false,
  "type" : "Immunization",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/Immunization",
  "derivation" : "constraint",
  "differential" : {
    "element" : [{
      "id" : "Immunization",
      "path" : "Immunization"
    },
    {
      "id" : "Immunization.status",
      "path" : "Immunization.status",
      "mustSupport" : true
    },
    {
      "id" : "Immunization.vaccineCode",
      "path" : "Immunization.vaccineCode",
      "mustSupport" : true
    },
    {
      "id" : "Immunization.patient",
      "path" : "Immunization.patient",
      "mustSupport" : true
    },
    {
      "id" : "Immunization.encounter",
      "path" : "Immunization.encounter",
      "mustSupport" : true
    },
    {
      "id" : "Immunization.occurrence[x]",
      "path" : "Immunization.occurrence[x]",
      "short" : "When. A date the patient remembers is worth recording even when it is only a year.",
      "mustSupport" : true
    },
    {
      "id" : "Immunization.primarySource",
      "path" : "Immunization.primarySource",
      "short" : "False when the patient or a card told us rather than us giving it. Changes how much weight to put on it, and it is the ordinary case here.",
      "mustSupport" : true
    },
    {
      "id" : "Immunization.lotNumber",
      "path" : "Immunization.lotNumber",
      "mustSupport" : true
    },
    {
      "id" : "Immunization.note",
      "path" : "Immunization.note",
      "mustSupport" : true
    }]
  }
}

```
