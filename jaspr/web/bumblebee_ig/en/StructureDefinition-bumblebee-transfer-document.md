# What travels with the patient - Bumblebee — a clinical record for emergency medical teams v0.1.0

## Resource Profile: What travels with the patient 

 
The standards specify the content: the patient's clinical condition, current treatment, the intention to transfer, and the mode and timeline of transfer. Written consent is required before transfer, and pain must be managed before transport. 

**Usages:**

* This Profile is not used by any profiles in this Specification

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/fhir.fhir-fli.bumblebee|current/StructureDefinition/StructureDefinition-bumblebee-transfer-document.json)

### Formal Views of Profile Content

 [Description Differentials, Snapshots, and other representations](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](../StructureDefinition-bumblebee-transfer-document.csv), [Excel](../StructureDefinition-bumblebee-transfer-document.xlsx), [Schematron](../StructureDefinition-bumblebee-transfer-document.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "bumblebee-transfer-document",
  "url" : "http://fhir-fli.dev/bumblebee/StructureDefinition/bumblebee-transfer-document",
  "version" : "0.1.0",
  "name" : "BumblebeeTransferDocument",
  "title" : "What travels with the patient",
  "status" : "draft",
  "date" : "2026-08-14T17:06:47-04:00",
  "publisher" : "fhir-fli",
  "description" : "The standards specify the content: the patient's clinical condition, current treatment, the intention to transfer, and the mode and timeline of transfer. Written consent is required before transfer, and pain must be managed before transport.",
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
    "identity" : "cda",
    "uri" : "http://hl7.org/v3/cda",
    "name" : "CDA (R2)"
  },
  {
    "identity" : "fhirdocumentreference",
    "uri" : "http://hl7.org/fhir/documentreference",
    "name" : "FHIR DocumentReference"
  },
  {
    "identity" : "w5",
    "uri" : "http://hl7.org/fhir/fivews",
    "name" : "FiveWs Pattern Mapping"
  }],
  "kind" : "resource",
  "abstract" : false,
  "type" : "Composition",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/Composition",
  "derivation" : "constraint",
  "differential" : {
    "element" : [{
      "id" : "Composition",
      "path" : "Composition"
    },
    {
      "id" : "Composition.status",
      "path" : "Composition.status",
      "mustSupport" : true
    },
    {
      "id" : "Composition.subject",
      "path" : "Composition.subject",
      "min" : 1,
      "mustSupport" : true
    },
    {
      "id" : "Composition.section",
      "path" : "Composition.section",
      "short" : "Condition · current treatment · intention to transfer · mode and timeline",
      "mustSupport" : true
    }]
  }
}

```
