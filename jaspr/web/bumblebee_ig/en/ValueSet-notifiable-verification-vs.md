# Suspected, probable, confirmed - Bumblebee — a clinical record for emergency medical teams v0.1.0

## ValueSet: Suspected, probable, confirmed 

 
Three of FHIR's six verification statuses, matching the surveillance vocabulary. 

 **References** 

* [Notifiable disease](StructureDefinition-bumblebee-notifiable-disease.md)

### Logical Definition (CLD)

 

### Expansion

-------

 [Description of the above table(s)](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#terminology). 



## Resource Content

```json
{
  "resourceType" : "ValueSet",
  "id" : "notifiable-verification-vs",
  "url" : "http://fhir-fli.dev/bumblebee/ValueSet/notifiable-verification-vs",
  "version" : "0.1.0",
  "name" : "NotifiableVerificationVS",
  "title" : "Suspected, probable, confirmed",
  "status" : "draft",
  "date" : "2026-08-14T17:06:47-04:00",
  "publisher" : "fhir-fli",
  "description" : "Three of FHIR's six verification statuses, matching the surveillance vocabulary.",
  "compose" : {
    "include" : [{
      "system" : "http://terminology.hl7.org/CodeSystem/condition-ver-status",
      "concept" : [{
        "code" : "unconfirmed",
        "display" : "Suspected"
      },
      {
        "code" : "provisional",
        "display" : "Probable"
      },
      {
        "code" : "confirmed",
        "display" : "Confirmed"
      }]
    }]
  }
}

```
