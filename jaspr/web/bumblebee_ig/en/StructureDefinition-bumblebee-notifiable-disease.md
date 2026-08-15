# Notifiable disease - Bumblebee — a clinical record for emergency medical teams v0.1.0

## Resource Profile: Notifiable disease 

 
A condition under outbreak surveillance. Needs more than an ordinary diagnosis because the alerting rules depend on it: one suspected case of cholera or measles is an alert, one confirmed case is an outbreak. Without the classification those rules cannot be written, and the failure would be an alert that never fires. 

**Usages:**

* This Profile is not used by any profiles in this Specification

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/fhir.fhir-fli.bumblebee|current/StructureDefinition/StructureDefinition-bumblebee-notifiable-disease.json)

### Formal Views of Profile Content

 [Description Differentials, Snapshots, and other representations](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](../StructureDefinition-bumblebee-notifiable-disease.csv), [Excel](../StructureDefinition-bumblebee-notifiable-disease.xlsx), [Schematron](../StructureDefinition-bumblebee-notifiable-disease.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "bumblebee-notifiable-disease",
  "url" : "http://fhir-fli.dev/bumblebee/StructureDefinition/bumblebee-notifiable-disease",
  "version" : "0.1.0",
  "name" : "BumblebeeNotifiableDisease",
  "title" : "Notifiable disease",
  "status" : "draft",
  "date" : "2026-08-14T17:06:47-04:00",
  "publisher" : "fhir-fli",
  "description" : "A condition under outbreak surveillance. Needs more than an ordinary diagnosis because the alerting rules depend on it: one suspected case of cholera or measles is an alert, one confirmed case is an outbreak. Without the classification those rules cannot be written, and the failure would be an alert that never fires.",
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
  "type" : "Condition",
  "baseDefinition" : "http://fhir-fli.dev/bumblebee/StructureDefinition/bumblebee-diagnosis",
  "derivation" : "constraint",
  "differential" : {
    "element" : [{
      "id" : "Condition",
      "path" : "Condition"
    },
    {
      "id" : "Condition.extension:exposure",
      "path" : "Condition.extension",
      "sliceName" : "exposure",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "Extension",
        "profile" : ["http://fhir-fli.dev/bumblebee/StructureDefinition/exposure-history"]
      }],
      "mustSupport" : true
    },
    {
      "id" : "Condition.verificationStatus",
      "path" : "Condition.verificationStatus",
      "short" : "Suspected, probable or confirmed",
      "definition" : "Constrained to three of FHIR's six values. unconfirmed means suspected — meets the clinical case definition. provisional means probable — the definition plus supporting evidence, or a link to a confirmed case. confirmed means laboratory confirmed.",
      "min" : 1,
      "mustSupport" : true,
      "binding" : {
        "strength" : "required",
        "valueSet" : "http://fhir-fli.dev/bumblebee/ValueSet/notifiable-verification-vs"
      }
    },
    {
      "id" : "Condition.onset[x]",
      "path" : "Condition.onset[x]",
      "min" : 1
    },
    {
      "id" : "Condition.onset[x]:onsetDateTime",
      "path" : "Condition.onset[x]",
      "sliceName" : "onsetDateTime",
      "short" : "Required here. Outbreak detection is about when illness began, not when someone reached us.",
      "min" : 1,
      "type" : [{
        "code" : "dateTime"
      }]
    }]
  }
}

```
