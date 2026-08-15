# Relation to the disaster (code system) - Bumblebee — a clinical record for emergency medical teams v0.1.0

## CodeSystem: Relation to the disaster (code system) 

This Code system is referenced in the definition of the following value sets:

* [Relation to the disaster](ValueSet-disaster-relation-vs.md)

-------

 [Description of the above table(s)](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#terminology). 



## Resource Content

```json
{
  "resourceType" : "CodeSystem",
  "id" : "disaster-relation-cs",
  "url" : "http://fhir-fli.dev/bumblebee/CodeSystem/disaster-relation-cs",
  "version" : "0.1.0",
  "name" : "DisasterRelationCS",
  "title" : "Relation to the disaster",
  "status" : "draft",
  "date" : "2026-08-14T17:06:47-04:00",
  "publisher" : "fhir-fli",
  "caseSensitive" : true,
  "content" : "complete",
  "count" : 4,
  "concept" : [{
    "code" : "directly",
    "display" : "Directly caused by the disaster",
    "definition" : "Injury caused by the earthquake, typhoon, tsunami, eruption; drowning; burn."
  },
  {
    "code" : "indirectly",
    "display" : "Indirectly caused",
    "definition" : "Illness or injury from the post-disaster environment, or a chronic condition that worsened because the disaster cut off access to care."
  },
  {
    "code" : "not-related",
    "display" : "Not caused by the disaster",
    "definition" : "A health problem the disaster did not cause and which is not urgent."
  },
  {
    "code" : "unknown",
    "display" : "Not known",
    "definition" : "Nobody has said. This is the default and it is allowed to stay."
  }]
}

```
