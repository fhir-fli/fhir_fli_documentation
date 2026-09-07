# Medication: DTaP - The Cicada Vaccine Forecasting Engine and Guide v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Medication: DTaP**

## Example Medication: Medication: DTaP

Profile: [Vaccine](StructureDefinition-Vaccine.md)

**Begin Age**: 6 weeks (Details: UCUM codewk = 'wk')

**End Age**: 7 years (Details: UCUM codea = 'a')

**Vaccine Type**: DTaP

**identifier**: `http://fhirfli.dev/fhir/ig/cicada/identifier/trade-name`/Infanrix

**code**: DTaP



## Resource Content

```json
{
  "resourceType" : "Medication",
  "id" : "vaccine-dtap",
  "meta" : {
    "profile" : ["http://fhirfli.dev/fhir/ig/cicada/StructureDefinition/Vaccine"]
  },
  "extension" : [{
    "url" : "http://fhirfli.dev/fhir/ig/cicada/StructureDefinition/begin-age",
    "valueAge" : {
      "value" : 6,
      "unit" : "weeks",
      "system" : "http://unitsofmeasure.org",
      "code" : "wk"
    }
  },
  {
    "url" : "http://fhirfli.dev/fhir/ig/cicada/StructureDefinition/end-age",
    "valueAge" : {
      "value" : 7,
      "unit" : "years",
      "system" : "http://unitsofmeasure.org",
      "code" : "a"
    }
  },
  {
    "url" : "http://fhirfli.dev/fhir/ig/cicada/StructureDefinition/vaccine-type",
    "valueCodeableConcept" : {
      "coding" : [{
        "system" : "http://hl7.org/fhir/sid/cvx",
        "code" : "20",
        "display" : "DTaP"
      }]
    }
  }],
  "identifier" : [{
    "system" : "http://fhirfli.dev/fhir/ig/cicada/identifier/trade-name",
    "value" : "Infanrix"
  }],
  "code" : {
    "coding" : [{
      "system" : "http://hl7.org/fhir/sid/cvx",
      "code" : "20",
      "display" : "DTaP"
    }]
  }
}

```
