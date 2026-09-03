# Antigen Needing a Dose - The Cicada Vaccine Forecasting Engine and Guide v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Antigen Needing a Dose**

## Extension: Antigen Needing a Dose 

| | |
| :--- | :--- |
| *Official URL*:http://fhirfli.dev/fhir/ig/cicada/StructureDefinition/antigen-needing-dose-ext | *Version*:0.1.0 |
| Draft as of 2026-09-02 | *Computable Name*:AntigenNeedingDose |

An antigen within this vaccine group that needs the forecast dose. A multi-antigen group forecasts as one recommendation, so without this a caller cannot tell whether all of MMR is due or only the measles component. Repeats, one per antigen.

**Context of Use**

**Usage info**

**Usages:**

* This Extension is not used by any profiles in this Implementation Guide

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/cicada.ig|current/StructureDefinition/antigen-needing-dose-ext)

### Formal Views of Extension Content

 [Description of Profiles, Differentials, Snapshots, and how the XML and JSON presentations work](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](StructureDefinition-antigen-needing-dose-ext.csv), [Excel](StructureDefinition-antigen-needing-dose-ext.xlsx), [Schematron](StructureDefinition-antigen-needing-dose-ext.sch) 

#### Constraints



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "antigen-needing-dose-ext",
  "url" : "http://fhirfli.dev/fhir/ig/cicada/StructureDefinition/antigen-needing-dose-ext",
  "version" : "0.1.0",
  "name" : "AntigenNeedingDose",
  "title" : "Antigen Needing a Dose",
  "status" : "draft",
  "date" : "2026-09-02T22:18:14-04:00",
  "publisher" : "FHIR-FLI",
  "contact" : [
    {
      "name" : "FHIR-FLI",
      "telecom" : [
        {
          "system" : "url",
          "value" : "http://fhirfli.dev"
        }
      ]
    }
  ],
  "description" : "An antigen within this vaccine group that needs the forecast dose. A multi-antigen group forecasts as one recommendation, so without this a caller cannot tell whether all of MMR is due or only the measles component. Repeats, one per antigen.",
  "fhirVersion" : "4.0.1",
  "mapping" : [
    {
      "identity" : "rim",
      "uri" : "http://hl7.org/v3",
      "name" : "RIM Mapping"
    }
  ],
  "kind" : "complex-type",
  "abstract" : false,
  "context" : [
    {
      "type" : "element",
      "expression" : "ImmunizationRecommendation.recommendation"
    }
  ],
  "type" : "Extension",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/Extension",
  "derivation" : "constraint",
  "differential" : {
    "element" : [
      {
        "id" : "Extension",
        "path" : "Extension",
        "short" : "Antigen Needing a Dose",
        "definition" : "An antigen within this vaccine group that needs the forecast dose. A multi-antigen group forecasts as one recommendation, so without this a caller cannot tell whether all of MMR is due or only the measles component. Repeats, one per antigen."
      },
      {
        "id" : "Extension.extension",
        "path" : "Extension.extension",
        "max" : "0"
      },
      {
        "id" : "Extension.url",
        "path" : "Extension.url",
        "fixedUri" : "http://fhirfli.dev/fhir/ig/cicada/StructureDefinition/antigen-needing-dose-ext"
      },
      {
        "id" : "Extension.value[x]",
        "path" : "Extension.value[x]",
        "type" : [
          {
            "code" : "string"
          }
        ]
      }
    ]
  }
}

```
