# Triage assessment - Bumblebee — a clinical record for emergency medical teams v0.1.0

## Resource Profile: Triage assessment 

 
One triage decision, at one moment, by one person. A patient waiting to be seen is re-assessed and gets another one of these; nothing is overwritten, because a clinician needs to see that this patient was green two hours ago and is red now. The Blue Book requires continued reassessment for Type 2 and 3 teams (5.1.1). The team brings its own triage system, so the value comes from deployment configuration and we ship no categories. 

**Usages:**

* This Profile is not used by any profiles in this Specification

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/fhir.fhir-fli.bumblebee|current/StructureDefinition/StructureDefinition-bumblebee-triage-assessment.json)

### Formal Views of Profile Content

 [Description Differentials, Snapshots, and other representations](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](../StructureDefinition-bumblebee-triage-assessment.csv), [Excel](../StructureDefinition-bumblebee-triage-assessment.xlsx), [Schematron](../StructureDefinition-bumblebee-triage-assessment.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "bumblebee-triage-assessment",
  "url" : "http://fhir-fli.dev/bumblebee/StructureDefinition/bumblebee-triage-assessment",
  "version" : "0.1.0",
  "name" : "BumblebeeTriageAssessment",
  "title" : "Triage assessment",
  "status" : "draft",
  "date" : "2026-08-14T17:06:47-04:00",
  "publisher" : "fhir-fli",
  "description" : "One triage decision, at one moment, by one person. A patient waiting to be seen is re-assessed and gets another one of these; nothing is overwritten, because a clinician needs to see that this patient was green two hours ago and is red now. The Blue Book requires continued reassessment for Type 2 and 3 teams (5.1.1). The team brings its own triage system, so the value comes from deployment configuration and we ship no categories.",
  "fhirVersion" : "4.0.1",
  "mapping" : [{
    "identity" : "workflow",
    "uri" : "http://hl7.org/fhir/workflow",
    "name" : "Workflow Pattern"
  },
  {
    "identity" : "sct-concept",
    "uri" : "http://snomed.info/conceptdomain",
    "name" : "SNOMED CT Concept Domain Binding"
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
    "identity" : "sct-attr",
    "uri" : "http://snomed.org/attributebinding",
    "name" : "SNOMED CT Attribute Binding"
  }],
  "kind" : "resource",
  "abstract" : false,
  "type" : "Observation",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/Observation",
  "derivation" : "constraint",
  "differential" : {
    "element" : [{
      "id" : "Observation",
      "path" : "Observation"
    },
    {
      "id" : "Observation.status",
      "path" : "Observation.status",
      "mustSupport" : true
    },
    {
      "id" : "Observation.category",
      "path" : "Observation.category",
      "min" : 1,
      "max" : "1",
      "mustSupport" : true
    },
    {
      "id" : "Observation.code",
      "path" : "Observation.code",
      "short" : "Deliberately the system-NEUTRAL LOINC code, not 75636-1 (Emergency Severity Index) or any other named scale, because each team brings its own system.",
      "patternCodeableConcept" : {
        "coding" : [{
          "system" : "http://loinc.org",
          "code" : "11283-9",
          "display" : "Acuity assessment [Function] at First encounter"
        }]
      }
    },
    {
      "id" : "Observation.subject",
      "path" : "Observation.subject",
      "min" : 1,
      "mustSupport" : true
    },
    {
      "id" : "Observation.encounter",
      "path" : "Observation.encounter",
      "min" : 1,
      "mustSupport" : true
    },
    {
      "id" : "Observation.effective[x]",
      "path" : "Observation.effective[x]",
      "slicing" : {
        "discriminator" : [{
          "type" : "type",
          "path" : "$this"
        }],
        "ordered" : false,
        "rules" : "open"
      },
      "min" : 1
    },
    {
      "id" : "Observation.effective[x]:effectiveDateTime",
      "path" : "Observation.effective[x]",
      "sliceName" : "effectiveDateTime",
      "short" : "When this assessment was made. Required — without it there is no trajectory, which is the point.",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "dateTime"
      }],
      "mustSupport" : true
    },
    {
      "id" : "Observation.performer",
      "path" : "Observation.performer",
      "short" : "Who decided. Required — a re-triage is a person's judgement and the record should say whose.",
      "min" : 1,
      "max" : "1",
      "mustSupport" : true
    },
    {
      "id" : "Observation.value[x]",
      "path" : "Observation.value[x]",
      "short" : "The category, from THIS deployment's configured triage system. We ship none.",
      "min" : 1,
      "type" : [{
        "code" : "CodeableConcept"
      }],
      "mustSupport" : true
    },
    {
      "id" : "Observation.value[x].coding",
      "path" : "Observation.value[x].coding",
      "min" : 1,
      "max" : "1",
      "mustSupport" : true
    },
    {
      "id" : "Observation.value[x].coding.system",
      "path" : "Observation.value[x].coding.system",
      "short" : "WHICH triage system. Required: '1' means nothing without it.",
      "min" : 1,
      "mustSupport" : true
    },
    {
      "id" : "Observation.value[x].coding.code",
      "path" : "Observation.value[x].coding.code",
      "min" : 1,
      "mustSupport" : true
    },
    {
      "id" : "Observation.value[x].coding.display",
      "path" : "Observation.value[x].coding.display",
      "short" : "REQUIRED, not optional. The label - 'Resuscitation', 'Immediate', 'Red'. A severity that is only a number cannot be read back safely: the same numeral runs in both directions across published documentation of the SAME scale. The label is what survives being moved, exported, or read by someone who was not there. Sort order comes from deployment config, never from this code.",
      "min" : 1,
      "mustSupport" : true
    },
    {
      "id" : "Observation.derivedFrom",
      "path" : "Observation.derivedFrom",
      "short" : "The vitals, arm circumference or screen this decision was based on, if any were recorded.",
      "mustSupport" : true
    }]
  }
}

```
