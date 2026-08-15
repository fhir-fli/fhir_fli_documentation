# Treatment level required (value set) - Bumblebee — a clinical record for emergency medical teams v0.1.0

## ValueSet: Treatment level required 

 **References** 

* [Treatment level required](StructureDefinition-treatment-level.md)

### Logical Definition (CLD)

 

### Expansion

-------

 [Description of the above table(s)](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#terminology). 



## Resource Content

```json
{
  "resourceType" : "ValueSet",
  "id" : "treatment-level-vs",
  "url" : "http://fhir-fli.dev/bumblebee/ValueSet/treatment-level-vs",
  "version" : "0.1.0",
  "name" : "TreatmentLevelVS",
  "title" : "Treatment level required",
  "status" : "draft",
  "date" : "2026-08-14T17:06:47-04:00",
  "publisher" : "fhir-fli",
  "compose" : {
    "include" : [{
      "system" : "http://fhir-fli.dev/bumblebee/CodeSystem/treatment-level-cs"
    }]
  }
}

```
