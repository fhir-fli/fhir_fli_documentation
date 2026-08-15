# This patient is getting worse - Bumblebee — a clinical record for emergency medical teams v0.1.0

## Resource Profile: This patient is getting worse 

 
Set by a clinician, not computed. The standards require a mechanism to promptly detect deteriorating patients; recording that judgement is in scope, predicting it is not. 

**Usages:**

* This Profile is not used by any profiles in this Specification

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/fhir.fhir-fli.bumblebee|current/StructureDefinition/StructureDefinition-bumblebee-deterioration-flag.json)

### Formal Views of Profile Content

 [Description Differentials, Snapshots, and other representations](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](../StructureDefinition-bumblebee-deterioration-flag.csv), [Excel](../StructureDefinition-bumblebee-deterioration-flag.xlsx), [Schematron](../StructureDefinition-bumblebee-deterioration-flag.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "bumblebee-deterioration-flag",
  "url" : "http://fhir-fli.dev/bumblebee/StructureDefinition/bumblebee-deterioration-flag",
  "version" : "0.1.0",
  "name" : "BumblebeeDeteriorationFlag",
  "title" : "This patient is getting worse",
  "status" : "draft",
  "date" : "2026-08-14T17:06:47-04:00",
  "publisher" : "fhir-fli",
  "description" : "Set by a clinician, not computed. The standards require a mechanism to promptly detect deteriorating patients; recording that judgement is in scope, predicting it is not.",
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
  "type" : "Flag",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/Flag",
  "derivation" : "constraint",
  "differential" : {
    "element" : [{
      "id" : "Flag",
      "path" : "Flag"
    },
    {
      "id" : "Flag.status",
      "path" : "Flag.status",
      "mustSupport" : true
    },
    {
      "id" : "Flag.code",
      "path" : "Flag.code",
      "mustSupport" : true
    },
    {
      "id" : "Flag.subject",
      "path" : "Flag.subject",
      "mustSupport" : true
    }]
  }
}

```
