# Relation to the disaster (value set) - Bumblebee — a clinical record for emergency medical teams v0.1.0

## ValueSet: Relation to the disaster 

 **References** 

* [Relation to the disaster](StructureDefinition-disaster-relation.md)

### Logical Definition (CLD)

 

### Expansion

-------

 [Description of the above table(s)](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#terminology). 



## Resource Content

```json
{
  "resourceType" : "ValueSet",
  "id" : "disaster-relation-vs",
  "url" : "http://fhir-fli.dev/bumblebee/ValueSet/disaster-relation-vs",
  "version" : "0.1.0",
  "name" : "DisasterRelationVS",
  "title" : "Relation to the disaster",
  "status" : "draft",
  "date" : "2026-08-14T17:06:47-04:00",
  "publisher" : "fhir-fli",
  "compose" : {
    "include" : [{
      "system" : "http://fhir-fli.dev/bumblebee/CodeSystem/disaster-relation-cs"
    }]
  }
}

```
