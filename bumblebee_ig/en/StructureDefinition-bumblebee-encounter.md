# Visit - Bumblebee — a clinical record for emergency medical teams v0.1.0

## Resource Profile: Visit 

 
One contact between a patient and the team, from walking up to walking away. Someone seen twice in a day has two of these: the second visit is its own clinical event, with its own triage, its own findings and its own reason for being there. 

**Usages:**

* This Profile is not used by any profiles in this Specification

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/fhir.fhir-fli.bumblebee|current/StructureDefinition/StructureDefinition-bumblebee-encounter.json)

### Formal Views of Profile Content

 [Description Differentials, Snapshots, and other representations](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](../StructureDefinition-bumblebee-encounter.csv), [Excel](../StructureDefinition-bumblebee-encounter.xlsx), [Schematron](../StructureDefinition-bumblebee-encounter.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "bumblebee-encounter",
  "url" : "http://fhir-fli.dev/bumblebee/StructureDefinition/bumblebee-encounter",
  "version" : "0.1.0",
  "name" : "BumblebeeEncounter",
  "title" : "Visit",
  "status" : "draft",
  "date" : "2026-08-14T17:06:47-04:00",
  "publisher" : "fhir-fli",
  "description" : "One contact between a patient and the team, from walking up to walking away. Someone seen twice in a day has two of these: the second visit is its own clinical event, with its own triage, its own findings and its own reason for being there.",
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
  "type" : "Encounter",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/Encounter",
  "derivation" : "constraint",
  "differential" : {
    "element" : [{
      "id" : "Encounter",
      "path" : "Encounter"
    },
    {
      "id" : "Encounter.extension",
      "path" : "Encounter.extension",
      "slicing" : {
        "discriminator" : [{
          "type" : "value",
          "path" : "url"
        }],
        "ordered" : false,
        "rules" : "open"
      },
      "min" : 1
    },
    {
      "id" : "Encounter.extension:deployment",
      "path" : "Encounter.extension",
      "sliceName" : "deployment",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "Extension",
        "profile" : ["http://fhir-fli.dev/bumblebee/StructureDefinition/deployment-tag"]
      }],
      "mustSupport" : true
    },
    {
      "id" : "Encounter.extension:massCasualty",
      "path" : "Encounter.extension",
      "sliceName" : "massCasualty",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "Extension",
        "profile" : ["http://fhir-fli.dev/bumblebee/StructureDefinition/mass-casualty-mode"]
      }]
    },
    {
      "id" : "Encounter.status",
      "path" : "Encounter.status",
      "mustSupport" : true
    },
    {
      "id" : "Encounter.class",
      "path" : "Encounter.class",
      "mustSupport" : true
    },
    {
      "id" : "Encounter.subject",
      "path" : "Encounter.subject",
      "min" : 1,
      "mustSupport" : true
    },
    {
      "id" : "Encounter.participant",
      "path" : "Encounter.participant",
      "mustSupport" : true
    },
    {
      "id" : "Encounter.period",
      "path" : "Encounter.period",
      "min" : 1,
      "mustSupport" : true
    },
    {
      "id" : "Encounter.period.start",
      "path" : "Encounter.period.start",
      "short" : "Arrival. Distinguishes dead-on-arrival from death in the facility.",
      "min" : 1,
      "mustSupport" : true
    },
    {
      "id" : "Encounter.reasonCode",
      "path" : "Encounter.reasonCode",
      "short" : "Chief complaint - why they came, in their words or coded. Captured at triage: it is one of the nine columns in MIMIC-IV-ED's triage table across 425,087 real assessments.",
      "mustSupport" : true
    },
    {
      "id" : "Encounter.reasonReference",
      "path" : "Encounter.reasonReference",
      "short" : "What they are here ABOUT, when it is something already in the record. Empty on a first visit; never required, never filled in for them.",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["http://fhir-fli.dev/bumblebee/StructureDefinition/bumblebee-diagnosis",
        "http://fhir-fli.dev/bumblebee/StructureDefinition/bumblebee-problem",
        "http://hl7.org/fhir/StructureDefinition/Observation"]
      }],
      "mustSupport" : true
    },
    {
      "id" : "Encounter.hospitalization.dischargeDisposition",
      "path" : "Encounter.hospitalization.dischargeDisposition",
      "short" : "How the visit ended. Admission counts inpatient stays only — a patient held for observation and sent home is not an admission.",
      "mustSupport" : true
    },
    {
      "id" : "Encounter.serviceProvider",
      "path" : "Encounter.serviceProvider",
      "short" : "Which team saw this patient. Reaches their contact details through the Organization, so whoever reads this record later can find whoever wrote it.",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["http://fhir-fli.dev/bumblebee/StructureDefinition/bumblebee-organization"]
      }],
      "mustSupport" : true
    }]
  }
}

```
