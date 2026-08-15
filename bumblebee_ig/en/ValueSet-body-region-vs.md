# Body region - Bumblebee — a clinical record for emergency medical teams v0.1.0

## ValueSet: Body region 

 
Every code, at every level. A clinician picks the one they can be sure of. 

 **References** 

* [Finding, marked on a body diagram](StructureDefinition-bumblebee-body-site-finding.md)
* [Diagnosis made at this visit](StructureDefinition-bumblebee-diagnosis.md)

### Logical Definition (CLD)

 

### Expansion

-------

 [Description of the above table(s)](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#terminology). 



## Resource Content

```json
{
  "resourceType" : "ValueSet",
  "id" : "body-region-vs",
  "url" : "http://fhir-fli.dev/bumblebee/ValueSet/body-region-vs",
  "version" : "0.1.0",
  "name" : "BodyRegionVS",
  "title" : "Body region",
  "status" : "draft",
  "date" : "2026-08-14T17:06:47-04:00",
  "publisher" : "fhir-fli",
  "description" : "Every code, at every level. A clinician picks the one they can be sure of.",
  "compose" : {
    "include" : [{
      "system" : "http://fhir-fli.dev/bumblebee/CodeSystem/body-region-cs"
    }]
  }
}

```
