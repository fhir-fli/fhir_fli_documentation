# Doses Remaining - The Cicada Vaccine Forecasting Engine and Guide v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Doses Remaining**

## Extension: Doses Remaining 

| | |
| :--- | :--- |
| *Official URL*:http://fhirfli.dev/fhir/ig/cicada/StructureDefinition/doses-remaining-ext | *Version*:0.1.0 |
| Draft as of 2026-09-02 | *Computable Name*:DosesRemaining |

How many doses remain in the series after the one being forecast, or 'Recurring' where the series ends in a recurring dose. seriesDoses and doseNumber allow a reader to subtract, but no arithmetic says the series never ends.

**Context of Use**

**Usage info**

**Usages:**

* This Extension is not used by any profiles in this Implementation Guide

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/cicada.ig|current/StructureDefinition/doses-remaining-ext)

### Formal Views of Extension Content

 [Description of Profiles, Differentials, Snapshots, and how the XML and JSON presentations work](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](StructureDefinition-doses-remaining-ext.csv), [Excel](StructureDefinition-doses-remaining-ext.xlsx), [Schematron](StructureDefinition-doses-remaining-ext.sch) 

#### Constraints



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "doses-remaining-ext",
  "url" : "http://fhirfli.dev/fhir/ig/cicada/StructureDefinition/doses-remaining-ext",
  "version" : "0.1.0",
  "name" : "DosesRemaining",
  "title" : "Doses Remaining",
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
  "description" : "How many doses remain in the series after the one being forecast, or 'Recurring' where the series ends in a recurring dose. seriesDoses and doseNumber allow a reader to subtract, but no arithmetic says the series never ends.",
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
        "short" : "Doses Remaining",
        "definition" : "How many doses remain in the series after the one being forecast, or 'Recurring' where the series ends in a recurring dose. seriesDoses and doseNumber allow a reader to subtract, but no arithmetic says the series never ends."
      },
      {
        "id" : "Extension.extension",
        "path" : "Extension.extension",
        "max" : "0"
      },
      {
        "id" : "Extension.url",
        "path" : "Extension.url",
        "fixedUri" : "http://fhirfli.dev/fhir/ig/cicada/StructureDefinition/doses-remaining-ext"
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
