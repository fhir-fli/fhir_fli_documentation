# Vaccine - The Cicada Vaccine Forecasting Engine and Guide v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Vaccine**

## Resource Profile: Vaccine 

| | |
| :--- | :--- |
| *Official URL*:http://fhirfli.dev/fhir/ig/cicada/StructureDefinition/Vaccine | *Version*:0.1.0 |
| Draft as of 2026-09-07 | *Computable Name*:Vaccine |

 
A vaccine product as CDC's supporting data describes one: the CVX, the trade name, the ages between which it is a preferable vaccine, and its type. Note that beginAge and endAge are FHIR Age values, which must be positive (age-1), so CDC's "0 days" cannot be carried; a begin age of 0 days is expressed by omitting beginAge. 

**Usages:**

* Examples for this Profile: [Medication/vaccine-hepb-adult](Medication-vaccine-hepb-adult.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/cicada.ig|current/StructureDefinition/StructureDefinition-Vaccine.json)

### Formal Views of Profile Content

 [Description of Profiles, Differentials, Snapshots and how the different presentations work](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](StructureDefinition-Vaccine.csv), [Excel](StructureDefinition-Vaccine.xlsx), [Schematron](StructureDefinition-Vaccine.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "Vaccine",
  "url" : "http://fhirfli.dev/fhir/ig/cicada/StructureDefinition/Vaccine",
  "version" : "0.1.0",
  "name" : "Vaccine",
  "title" : "Vaccine",
  "status" : "draft",
  "date" : "2026-09-07T19:28:06-04:00",
  "publisher" : "FHIR-FLI",
  "contact" : [{
    "name" : "FHIR-FLI",
    "telecom" : [{
      "system" : "url",
      "value" : "http://fhirfli.dev"
    }]
  }],
  "description" : "A vaccine product as CDC's supporting data describes one: the CVX, the trade name, the ages between which it is a preferable vaccine, and its type. Note that beginAge and endAge are FHIR Age values, which must be positive (age-1), so CDC's \"0 days\" cannot be carried; a begin age of 0 days is expressed by omitting beginAge.",
  "fhirVersion" : "4.0.1",
  "mapping" : [{
    "identity" : "script10.6",
    "uri" : "http://ncpdp.org/SCRIPT10_6",
    "name" : "Mapping to NCPDP SCRIPT 10.6"
  },
  {
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
  "type" : "Medication",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/Medication",
  "derivation" : "constraint",
  "differential" : {
    "element" : [{
      "id" : "Medication",
      "path" : "Medication"
    },
    {
      "id" : "Medication.extension",
      "path" : "Medication.extension",
      "slicing" : {
        "discriminator" : [{
          "type" : "value",
          "path" : "url"
        }],
        "ordered" : false,
        "rules" : "open"
      }
    },
    {
      "id" : "Medication.extension:beginAge",
      "path" : "Medication.extension",
      "sliceName" : "beginAge",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "Extension",
        "profile" : ["http://fhirfli.dev/fhir/ig/cicada/StructureDefinition/begin-age"]
      }]
    },
    {
      "id" : "Medication.extension:endAge",
      "path" : "Medication.extension",
      "sliceName" : "endAge",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "Extension",
        "profile" : ["http://fhirfli.dev/fhir/ig/cicada/StructureDefinition/end-age"]
      }]
    },
    {
      "id" : "Medication.extension:vaccineType",
      "path" : "Medication.extension",
      "sliceName" : "vaccineType",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "Extension",
        "profile" : ["http://fhirfli.dev/fhir/ig/cicada/StructureDefinition/vaccine-type"]
      }]
    },
    {
      "id" : "Medication.identifier",
      "path" : "Medication.identifier",
      "slicing" : {
        "discriminator" : [{
          "type" : "value",
          "path" : "system"
        }],
        "rules" : "open"
      }
    },
    {
      "id" : "Medication.identifier:tradeName",
      "path" : "Medication.identifier",
      "sliceName" : "tradeName",
      "short" : "The vaccine's trade name",
      "min" : 0,
      "max" : "1"
    },
    {
      "id" : "Medication.identifier:tradeName.system",
      "path" : "Medication.identifier.system",
      "min" : 1,
      "patternUri" : "http://fhirfli.dev/fhir/ig/cicada/identifier/trade-name"
    }]
  }
}

```
