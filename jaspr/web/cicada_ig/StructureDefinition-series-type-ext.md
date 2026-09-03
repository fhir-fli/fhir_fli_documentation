# Series Type - The Cicada Vaccine Forecasting Engine and Guide v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Series Type**

## Extension: Series Type 

| | |
| :--- | :--- |
| *Official URL*:http://fhirfli.dev/fhir/ig/cicada/StructureDefinition/series-type-ext | *Version*:0.1.0 |
| Draft as of 2026-09-02 | *Computable Name*:SeriesType |

Whether this recommendation came from the standard series group or a risk series group. Present so a client receiving two recommendations for one vaccine group can tell which pathway each describes.

**Context of Use**

**Usage info**

**Usages:**

* Use this Extension: [Cicada Immunization Recommendation](StructureDefinition-cicada-immunization-recommendation.md)
* Examples for this Extension: [ImmunizationRecommendation/cicada-forecast-example](ImmunizationRecommendation-cicada-forecast-example.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/cicada.ig|current/StructureDefinition/series-type-ext)

### Formal Views of Extension Content

 [Description of Profiles, Differentials, Snapshots, and how the XML and JSON presentations work](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](StructureDefinition-series-type-ext.csv), [Excel](StructureDefinition-series-type-ext.xlsx), [Schematron](StructureDefinition-series-type-ext.sch) 

#### Terminology Bindings

#### Constraints



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "series-type-ext",
  "url" : "http://fhirfli.dev/fhir/ig/cicada/StructureDefinition/series-type-ext",
  "version" : "0.1.0",
  "name" : "SeriesType",
  "title" : "Series Type",
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
  "description" : "Whether this recommendation came from the standard series group or a risk series group. Present so a client receiving two recommendations for one vaccine group can tell which pathway each describes.",
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
        "short" : "Series Type",
        "definition" : "Whether this recommendation came from the standard series group or a risk series group. Present so a client receiving two recommendations for one vaccine group can tell which pathway each describes."
      },
      {
        "id" : "Extension.extension",
        "path" : "Extension.extension",
        "max" : "0"
      },
      {
        "id" : "Extension.url",
        "path" : "Extension.url",
        "fixedUri" : "http://fhirfli.dev/fhir/ig/cicada/StructureDefinition/series-type-ext"
      },
      {
        "id" : "Extension.value[x]",
        "path" : "Extension.value[x]",
        "type" : [
          {
            "code" : "CodeableConcept"
          }
        ],
        "binding" : {
          "strength" : "required",
          "valueSet" : "http://fhirfli.dev/fhir/ig/cicada/ValueSet/series-type-vs"
        }
      }
    ]
  }
}

```
