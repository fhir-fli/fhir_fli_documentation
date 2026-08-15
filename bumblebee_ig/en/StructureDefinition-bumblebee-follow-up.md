# Come back — when, and for what - Bumblebee — a clinical record for emergency medical teams v0.1.0

## Resource Profile: Come back — when, and for what 

 
A planned return to us: a date, and the reason to come on it. Separate from a referral because nothing is handed over — the patient stays ours and no handover has to be closed. Most patients leave with nothing arranged at all, so a follow-up that was arranged is a fact worth being able to find, and it is the thing a return visit is matched against. 

**Usages:**

* This Profile is not used by any profiles in this Specification

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/fhir.fhir-fli.bumblebee|current/StructureDefinition/StructureDefinition-bumblebee-follow-up.json)

### Formal Views of Profile Content

 [Description Differentials, Snapshots, and other representations](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](../StructureDefinition-bumblebee-follow-up.csv), [Excel](../StructureDefinition-bumblebee-follow-up.xlsx), [Schematron](../StructureDefinition-bumblebee-follow-up.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "bumblebee-follow-up",
  "url" : "http://fhir-fli.dev/bumblebee/StructureDefinition/bumblebee-follow-up",
  "version" : "0.1.0",
  "name" : "BumblebeeFollowUp",
  "title" : "Come back — when, and for what",
  "status" : "draft",
  "date" : "2026-08-14T17:06:47-04:00",
  "publisher" : "fhir-fli",
  "description" : "A planned return to us: a date, and the reason to come on it. Separate from a referral because nothing is handed over — the patient stays ours and no handover has to be closed. Most patients leave with nothing arranged at all, so a follow-up that was arranged is a fact worth being able to find, and it is the thing a return visit is matched against.",
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
    "identity" : "quick",
    "uri" : "http://siframework.org/cqf",
    "name" : "Quality Improvement and Clinical Knowledge (QUICK)"
  }],
  "kind" : "resource",
  "abstract" : false,
  "type" : "ServiceRequest",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/ServiceRequest",
  "derivation" : "constraint",
  "differential" : {
    "element" : [{
      "id" : "ServiceRequest",
      "path" : "ServiceRequest"
    },
    {
      "id" : "ServiceRequest.status",
      "path" : "ServiceRequest.status",
      "mustSupport" : true
    },
    {
      "id" : "ServiceRequest.intent",
      "path" : "ServiceRequest.intent",
      "short" : "plan, not order. Nobody else is being asked to do anything.",
      "patternCode" : "plan"
    },
    {
      "id" : "ServiceRequest.subject",
      "path" : "ServiceRequest.subject",
      "mustSupport" : true
    },
    {
      "id" : "ServiceRequest.encounter",
      "path" : "ServiceRequest.encounter",
      "short" : "The visit it was arranged at.",
      "mustSupport" : true
    },
    {
      "id" : "ServiceRequest.occurrence[x]",
      "path" : "ServiceRequest.occurrence[x]",
      "short" : "When to come back — a date, or a period if the advice was 'in three to five days'. The interval is chosen from the problem, not from a default.",
      "mustSupport" : true
    },
    {
      "id" : "ServiceRequest.performer",
      "path" : "ServiceRequest.performer",
      "short" : "Us, ordinarily. A named person only if it has to be that person.",
      "mustSupport" : true
    },
    {
      "id" : "ServiceRequest.reasonCode",
      "path" : "ServiceRequest.reasonCode",
      "short" : "What to come back for — a dressing, a wound check, response to an antibiotic, the next vaccination. Without it a return visit starts from nothing.",
      "mustSupport" : true
    },
    {
      "id" : "ServiceRequest.note",
      "path" : "ServiceRequest.note",
      "mustSupport" : true
    }]
  }
}

```
