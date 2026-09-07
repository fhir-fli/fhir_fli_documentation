# Vaccination Patient - The Cicada Vaccine Forecasting Engine and Guide v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Vaccination Patient**

## Resource Profile: Vaccination Patient 

| | |
| :--- | :--- |
| *Official URL*:http://fhirfli.dev/fhir/ig/cicada/StructureDefinition/vax-patient | *Version*:0.1.0 |
| Draft as of 2026-09-07 | *Computable Name*:VaxPatient |

 
A profile that extends the base FHIR Patient resource to include detailed vaccination-related information. 

**Usages:**

* Examples for this Profile: [Patient/2016-UC-0032](Patient-2016-UC-0032.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/cicada.ig|current/StructureDefinition/StructureDefinition-vax-patient.json)

### Formal Views of Profile Content

 [Description of Profiles, Differentials, Snapshots and how the different presentations work](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](StructureDefinition-vax-patient.csv), [Excel](StructureDefinition-vax-patient.xlsx), [Schematron](StructureDefinition-vax-patient.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "vax-patient",
  "url" : "http://fhirfli.dev/fhir/ig/cicada/StructureDefinition/vax-patient",
  "version" : "0.1.0",
  "name" : "VaxPatient",
  "title" : "Vaccination Patient",
  "status" : "draft",
  "date" : "2026-09-07T19:51:55-04:00",
  "publisher" : "FHIR-FLI",
  "contact" : [{
    "name" : "FHIR-FLI",
    "telecom" : [{
      "system" : "url",
      "value" : "http://fhirfli.dev"
    }]
  }],
  "description" : "A profile that extends the base FHIR Patient resource to include detailed vaccination-related information.",
  "fhirVersion" : "4.0.1",
  "mapping" : [{
    "identity" : "rim",
    "uri" : "http://hl7.org/v3",
    "name" : "RIM Mapping"
  },
  {
    "identity" : "cda",
    "uri" : "http://hl7.org/v3/cda",
    "name" : "CDA (R2)"
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
  },
  {
    "identity" : "loinc",
    "uri" : "http://loinc.org",
    "name" : "LOINC code for the element"
  }],
  "kind" : "resource",
  "abstract" : false,
  "type" : "Patient",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/Patient",
  "derivation" : "constraint",
  "differential" : {
    "element" : [{
      "id" : "Patient",
      "path" : "Patient"
    },
    {
      "id" : "Patient.birthDate",
      "path" : "Patient.birthDate",
      "min" : 1
    }]
  }
}

```
