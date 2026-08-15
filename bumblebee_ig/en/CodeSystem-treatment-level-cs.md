# Treatment level required (code system) - Bumblebee — a clinical record for emergency medical teams v0.1.0

## CodeSystem: Treatment level required (code system) 

This Code system is referenced in the definition of the following value sets:

* [Treatment level required](ValueSet-treatment-level-vs.md)

-------

 [Description of the above table(s)](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#terminology). 



## Resource Content

```json
{
  "resourceType" : "CodeSystem",
  "id" : "treatment-level-cs",
  "url" : "http://fhir-fli.dev/bumblebee/CodeSystem/treatment-level-cs",
  "version" : "0.1.0",
  "name" : "TreatmentLevelCS",
  "title" : "Treatment level required",
  "status" : "draft",
  "date" : "2026-08-14T17:06:47-04:00",
  "publisher" : "fhir-fli",
  "caseSensitive" : true,
  "content" : "complete",
  "count" : 3,
  "concept" : [{
    "code" : "major",
    "display" : "Major",
    "definition" : "Needs general anaesthesia and/or hospitalisation. Requires a Type 2 or Type 3 team."
  },
  {
    "code" : "moderate",
    "display" : "Moderate",
    "definition" : "Treatable in the emergency room as an outpatient, but needs conscious sedation or a regional block."
  },
  {
    "code" : "minor",
    "display" : "Minor",
    "definition" : "First aid and light dressing, no anaesthesia. Within Type 1 mobile capability."
  }]
}

```
