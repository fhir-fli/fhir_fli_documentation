# Accompanying person - Bumblebee — a clinical record for emergency medical teams v0.1.0

## Resource Profile: Accompanying person 

 
A parent, guardian or caregiver with the patient. Required because a child must not be separated from their parent or agreed caretaker, and because an unaccompanied minor is then a query — a child with no accompanying person — rather than a flag somebody has to remember to set. 

**Usages:**

* This Profile is not used by any profiles in this Specification

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/fhir.fhir-fli.bumblebee|current/StructureDefinition/StructureDefinition-bumblebee-related-person.json)

### Formal Views of Profile Content

 [Description Differentials, Snapshots, and other representations](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](../StructureDefinition-bumblebee-related-person.csv), [Excel](../StructureDefinition-bumblebee-related-person.xlsx), [Schematron](../StructureDefinition-bumblebee-related-person.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "bumblebee-related-person",
  "url" : "http://fhir-fli.dev/bumblebee/StructureDefinition/bumblebee-related-person",
  "version" : "0.1.0",
  "name" : "BumblebeeRelatedPerson",
  "title" : "Accompanying person",
  "status" : "draft",
  "date" : "2026-08-14T17:06:47-04:00",
  "publisher" : "fhir-fli",
  "description" : "A parent, guardian or caregiver with the patient. Required because a child must not be separated from their parent or agreed caretaker, and because an unaccompanied minor is then a query — a child with no accompanying person — rather than a flag somebody has to remember to set.",
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
  },
  {
    "identity" : "v2",
    "uri" : "http://hl7.org/v2",
    "name" : "HL7 v2 Mapping"
  }],
  "kind" : "resource",
  "abstract" : false,
  "type" : "RelatedPerson",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/RelatedPerson",
  "derivation" : "constraint",
  "differential" : {
    "element" : [{
      "id" : "RelatedPerson",
      "path" : "RelatedPerson"
    },
    {
      "id" : "RelatedPerson.patient",
      "path" : "RelatedPerson.patient",
      "mustSupport" : true
    },
    {
      "id" : "RelatedPerson.relationship",
      "path" : "RelatedPerson.relationship",
      "mustSupport" : true
    }]
  }
}

```
