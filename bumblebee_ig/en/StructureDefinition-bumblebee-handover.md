# Handover — who has the patient now - Bumblebee — a clinical record for emergency medical teams v0.1.0

## Resource Profile: Handover — who has the patient now 

 
Tracks who is responsible while a referral is in progress. The standards are explicit that responsibility remains with the transferring staff until handover is carried out with the receiving facility, so a referred patient stays on our queue until this reaches completed. 

**Usages:**

* This Profile is not used by any profiles in this Specification

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/fhir.fhir-fli.bumblebee|current/StructureDefinition/StructureDefinition-bumblebee-handover.json)

### Formal Views of Profile Content

 [Description Differentials, Snapshots, and other representations](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](../StructureDefinition-bumblebee-handover.csv), [Excel](../StructureDefinition-bumblebee-handover.xlsx), [Schematron](../StructureDefinition-bumblebee-handover.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "bumblebee-handover",
  "url" : "http://fhir-fli.dev/bumblebee/StructureDefinition/bumblebee-handover",
  "version" : "0.1.0",
  "name" : "BumblebeeHandover",
  "title" : "Handover — who has the patient now",
  "status" : "draft",
  "date" : "2026-08-14T17:06:47-04:00",
  "publisher" : "fhir-fli",
  "description" : "Tracks who is responsible while a referral is in progress. The standards are explicit that responsibility remains with the transferring staff until handover is carried out with the receiving facility, so a referred patient stays on our queue until this reaches completed.",
  "fhirVersion" : "4.0.1",
  "mapping" : [{
    "identity" : "workflow",
    "uri" : "http://hl7.org/fhir/workflow",
    "name" : "Workflow Pattern"
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
    "identity" : "v2",
    "uri" : "http://hl7.org/v2",
    "name" : "HL7 v2 Mapping"
  }],
  "kind" : "resource",
  "abstract" : false,
  "type" : "Task",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/Task",
  "derivation" : "constraint",
  "differential" : {
    "element" : [{
      "id" : "Task",
      "path" : "Task"
    },
    {
      "id" : "Task.status",
      "path" : "Task.status",
      "short" : "requested, accepted, in-progress, completed. Responsibility moves only at completed.",
      "mustSupport" : true
    },
    {
      "id" : "Task.focus",
      "path" : "Task.focus",
      "min" : 1,
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["http://fhir-fli.dev/bumblebee/StructureDefinition/bumblebee-referral"]
      }],
      "mustSupport" : true
    },
    {
      "id" : "Task.for",
      "path" : "Task.for",
      "min" : 1,
      "mustSupport" : true
    },
    {
      "id" : "Task.owner",
      "path" : "Task.owner",
      "short" : "Who is receiving",
      "mustSupport" : true
    }]
  }
}

```
