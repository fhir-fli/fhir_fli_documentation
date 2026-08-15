# What we told them to watch for - Bumblebee — a clinical record for emergency medical teams v0.1.0

## Resource Profile: What we told them to watch for 

 
The signs that mean come back immediately, and the record that somebody was actually told them. Chosen for this patient's problem rather than read off a general list. For most patients nothing else is arranged, which makes this the only safety net they leave with. 

**Usages:**

* This Profile is not used by any profiles in this Specification

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/fhir.fhir-fli.bumblebee|current/StructureDefinition/StructureDefinition-bumblebee-return-advice.json)

### Formal Views of Profile Content

 [Description Differentials, Snapshots, and other representations](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](../StructureDefinition-bumblebee-return-advice.csv), [Excel](../StructureDefinition-bumblebee-return-advice.xlsx), [Schematron](../StructureDefinition-bumblebee-return-advice.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "bumblebee-return-advice",
  "url" : "http://fhir-fli.dev/bumblebee/StructureDefinition/bumblebee-return-advice",
  "version" : "0.1.0",
  "name" : "BumblebeeReturnAdvice",
  "title" : "What we told them to watch for",
  "status" : "draft",
  "date" : "2026-08-14T17:06:47-04:00",
  "publisher" : "fhir-fli",
  "description" : "The signs that mean come back immediately, and the record that somebody was actually told them. Chosen for this patient's problem rather than read off a general list. For most patients nothing else is arranged, which makes this the only safety net they leave with.",
  "fhirVersion" : "4.0.1",
  "mapping" : [{
    "identity" : "workflow",
    "uri" : "http://hl7.org/fhir/workflow",
    "name" : "Workflow Pattern"
  },
  {
    "identity" : "w5",
    "uri" : "http://hl7.org/fhir/fivews",
    "name" : "FiveWs Pattern Mapping"
  },
  {
    "identity" : "rim",
    "uri" : "http://hl7.org/v3",
    "name" : "RIM Mapping"
  }],
  "kind" : "resource",
  "abstract" : false,
  "type" : "Communication",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/Communication",
  "derivation" : "constraint",
  "differential" : {
    "element" : [{
      "id" : "Communication",
      "path" : "Communication"
    },
    {
      "id" : "Communication.status",
      "path" : "Communication.status",
      "mustSupport" : true
    },
    {
      "id" : "Communication.medium",
      "path" : "Communication.medium",
      "short" : "Spoken, spoken through an interpreter, or handed over written down. Advice given in a language the person does not read is not advice.",
      "mustSupport" : true
    },
    {
      "id" : "Communication.subject",
      "path" : "Communication.subject",
      "min" : 1,
      "mustSupport" : true
    },
    {
      "id" : "Communication.encounter",
      "path" : "Communication.encounter",
      "mustSupport" : true
    },
    {
      "id" : "Communication.sent",
      "path" : "Communication.sent",
      "short" : "When they were told.",
      "mustSupport" : true
    },
    {
      "id" : "Communication.recipient",
      "path" : "Communication.recipient",
      "short" : "Who was told. Often a RelatedPerson rather than the patient — the person who has to act on it is the one holding the child.",
      "mustSupport" : true
    },
    {
      "id" : "Communication.sender",
      "path" : "Communication.sender",
      "mustSupport" : true
    },
    {
      "id" : "Communication.payload",
      "path" : "Communication.payload",
      "short" : "The signs themselves. Same words that go onto the paper they carry.",
      "mustSupport" : true
    },
    {
      "id" : "Communication.note",
      "path" : "Communication.note",
      "mustSupport" : true
    }]
  }
}

```
