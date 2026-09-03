# Cicada Immunization Recommendation - The Cicada Vaccine Forecasting Engine and Guide v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Cicada Immunization Recommendation**

## Resource Profile: Cicada Immunization Recommendation 

| | |
| :--- | :--- |
| *Official URL*:http://fhirfli.dev/fhir/ig/cicada/StructureDefinition/cicada-immunization-recommendation | *Version*:0.1.0 |
| Draft as of 2026-09-02 | *Computable Name*:CicadaImmunizationRecommendation |

 
The forecast cicada returns. Constrains ImmunizationRecommendation to say which series group each recommendation belongs to, so that more than one recommendation for a single vaccine group can be told apart. 

**Usages:**

* Examples for this Profile: [ImmunizationRecommendation/cicada-forecast-example](ImmunizationRecommendation-cicada-forecast-example.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/cicada.ig|current/StructureDefinition/cicada-immunization-recommendation)

### Formal Views of Profile Content

 [Description of Profiles, Differentials, Snapshots and how the different presentations work](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](StructureDefinition-cicada-immunization-recommendation.csv), [Excel](StructureDefinition-cicada-immunization-recommendation.xlsx), [Schematron](StructureDefinition-cicada-immunization-recommendation.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "cicada-immunization-recommendation",
  "url" : "http://fhirfli.dev/fhir/ig/cicada/StructureDefinition/cicada-immunization-recommendation",
  "version" : "0.1.0",
  "name" : "CicadaImmunizationRecommendation",
  "title" : "Cicada Immunization Recommendation",
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
  "description" : "The forecast cicada returns. Constrains ImmunizationRecommendation to say which series group each recommendation belongs to, so that more than one recommendation for a single vaccine group can be told apart.",
  "fhirVersion" : "4.0.1",
  "mapping" : [
    {
      "identity" : "workflow",
      "uri" : "http://hl7.org/fhir/workflow",
      "name" : "Workflow Pattern"
    },
    {
      "identity" : "v2",
      "uri" : "http://hl7.org/v2",
      "name" : "HL7 v2 Mapping"
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
    }
  ],
  "kind" : "resource",
  "abstract" : false,
  "type" : "ImmunizationRecommendation",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/ImmunizationRecommendation",
  "derivation" : "constraint",
  "differential" : {
    "element" : [
      {
        "id" : "ImmunizationRecommendation",
        "path" : "ImmunizationRecommendation"
      },
      {
        "id" : "ImmunizationRecommendation.recommendation.extension",
        "path" : "ImmunizationRecommendation.recommendation.extension",
        "slicing" : {
          "discriminator" : [
            {
              "type" : "value",
              "path" : "url"
            }
          ],
          "ordered" : false,
          "rules" : "open"
        }
      },
      {
        "id" : "ImmunizationRecommendation.recommendation.extension:seriesType",
        "path" : "ImmunizationRecommendation.recommendation.extension",
        "sliceName" : "seriesType",
        "min" : 0,
        "max" : "1",
        "type" : [
          {
            "code" : "Extension",
            "profile" : [
              "http://fhirfli.dev/fhir/ig/cicada/StructureDefinition/series-type-ext"
            ]
          }
        ],
        "mustSupport" : true
      },
      {
        "id" : "ImmunizationRecommendation.recommendation.targetDisease",
        "path" : "ImmunizationRecommendation.recommendation.targetDisease",
        "mustSupport" : true
      },
      {
        "id" : "ImmunizationRecommendation.recommendation.forecastStatus",
        "path" : "ImmunizationRecommendation.recommendation.forecastStatus",
        "binding" : {
          "strength" : "extensible",
          "valueSet" : "http://fhirfli.dev/fhir/ig/cicada/ValueSet/forecast-status"
        }
      },
      {
        "id" : "ImmunizationRecommendation.recommendation.series",
        "path" : "ImmunizationRecommendation.recommendation.series",
        "mustSupport" : true
      },
      {
        "id" : "ImmunizationRecommendation.recommendation.supportingPatientInformation",
        "path" : "ImmunizationRecommendation.recommendation.supportingPatientInformation",
        "mustSupport" : true
      }
    ]
  }
}

```
