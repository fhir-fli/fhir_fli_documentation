# Medication: Hep B, adult - The Cicada Vaccine Forecasting Engine and Guide v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Medication: Hep B, adult**

## Example Medication: Medication: Hep B, adult

Profile: [Vaccine](StructureDefinition-Vaccine.md)

**Begin Age**: 20 years (Details: UCUM codea = 'a')

**Vaccine Type**: Hep B, adult

**identifier**: `http://fhirfli.dev/fhir/ig/cicada/identifier/trade-name`/Engerix-B

**code**: Hep B, adult



## Resource Content

```json
{
  "resourceType" : "Medication",
  "id" : "vaccine-hepb-adult",
  "meta" : {
    "profile" : ["http://fhirfli.dev/fhir/ig/cicada/StructureDefinition/Vaccine"]
  },
  "extension" : [{
    "url" : "http://fhirfli.dev/fhir/ig/cicada/StructureDefinition/begin-age",
    "valueAge" : {
      "value" : 20,
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
        "code" : "43",
        "display" : "Hep B, adult"
      }]
    }
  }],
  "identifier" : [{
    "system" : "http://fhirfli.dev/fhir/ig/cicada/identifier/trade-name",
    "value" : "Engerix-B"
  }],
  "code" : {
    "coding" : [{
      "system" : "http://hl7.org/fhir/sid/cvx",
      "code" : "43",
      "display" : "Hep B, adult"
    }]
  }
}

```
