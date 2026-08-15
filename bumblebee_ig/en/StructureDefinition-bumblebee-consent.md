# Permission for one specific thing - Bumblebee — a clinical record for emergency medical teams v0.1.0

## Resource Profile: Permission for one specific thing 

 
Recorded per act, never once per patient. Treating someone and writing it down does not rest on their permission — they are told, and can object. But permission is required separately for sharing or referring, for recording sexual violence, for a procedure or anaesthetic, for transfer, and for a photograph. Someone agreeing to be treated has not thereby agreed to have their assault recorded. 

**Usages:**

* This Profile is not used by any profiles in this Specification

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/fhir.fhir-fli.bumblebee|current/StructureDefinition/StructureDefinition-bumblebee-consent.json)

### Formal Views of Profile Content

 [Description Differentials, Snapshots, and other representations](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](../StructureDefinition-bumblebee-consent.csv), [Excel](../StructureDefinition-bumblebee-consent.xlsx), [Schematron](../StructureDefinition-bumblebee-consent.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "bumblebee-consent",
  "url" : "http://fhir-fli.dev/bumblebee/StructureDefinition/bumblebee-consent",
  "version" : "0.1.0",
  "name" : "BumblebeeConsent",
  "title" : "Permission for one specific thing",
  "status" : "draft",
  "date" : "2026-08-14T17:06:47-04:00",
  "publisher" : "fhir-fli",
  "description" : "Recorded per act, never once per patient. Treating someone and writing it down does not rest on their permission — they are told, and can object. But permission is required separately for sharing or referring, for recording sexual violence, for a procedure or anaesthetic, for transfer, and for a photograph. Someone agreeing to be treated has not thereby agreed to have their assault recorded.",
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
  }],
  "kind" : "resource",
  "abstract" : false,
  "type" : "Consent",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/Consent",
  "derivation" : "constraint",
  "differential" : {
    "element" : [{
      "id" : "Consent",
      "path" : "Consent"
    },
    {
      "id" : "Consent.status",
      "path" : "Consent.status",
      "mustSupport" : true
    },
    {
      "id" : "Consent.scope",
      "path" : "Consent.scope",
      "mustSupport" : true
    },
    {
      "id" : "Consent.category",
      "path" : "Consent.category",
      "short" : "Which act this covers",
      "mustSupport" : true
    },
    {
      "id" : "Consent.patient",
      "path" : "Consent.patient",
      "min" : 1,
      "mustSupport" : true
    }]
  }
}

```
