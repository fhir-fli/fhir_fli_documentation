# Complication - Bumblebee — a clinical record for emergency medical teams v0.1.0

## Resource Profile: Complication 

 
Something that went wrong. The standards name possible complications in the one sentence that defines what a record must contain, and require a register of perioperative complications specifically. The clinical problem itself is recorded as a diagnosis; this points at it and marks it as an adverse event. 

**Usages:**

* This Profile is not used by any profiles in this Specification

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/fhir.fhir-fli.bumblebee|current/StructureDefinition/StructureDefinition-bumblebee-complication.json)

### Formal Views of Profile Content

 [Description Differentials, Snapshots, and other representations](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](../StructureDefinition-bumblebee-complication.csv), [Excel](../StructureDefinition-bumblebee-complication.xlsx), [Schematron](../StructureDefinition-bumblebee-complication.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "bumblebee-complication",
  "url" : "http://fhir-fli.dev/bumblebee/StructureDefinition/bumblebee-complication",
  "version" : "0.1.0",
  "name" : "BumblebeeComplication",
  "title" : "Complication",
  "status" : "draft",
  "date" : "2026-08-14T17:06:47-04:00",
  "publisher" : "fhir-fli",
  "description" : "Something that went wrong. The standards name possible complications in the one sentence that defines what a record must contain, and require a register of perioperative complications specifically. The clinical problem itself is recorded as a diagnosis; this points at it and marks it as an adverse event.",
  "fhirVersion" : "4.0.1",
  "mapping" : [{
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
  "type" : "AdverseEvent",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/AdverseEvent",
  "derivation" : "constraint",
  "differential" : {
    "element" : [{
      "id" : "AdverseEvent",
      "path" : "AdverseEvent"
    },
    {
      "id" : "AdverseEvent.event",
      "path" : "AdverseEvent.event",
      "min" : 1,
      "mustSupport" : true
    },
    {
      "id" : "AdverseEvent.subject",
      "path" : "AdverseEvent.subject",
      "mustSupport" : true
    },
    {
      "id" : "AdverseEvent.suspectEntity",
      "path" : "AdverseEvent.suspectEntity",
      "short" : "The procedure or medication involved",
      "mustSupport" : true
    }]
  }
}

```
