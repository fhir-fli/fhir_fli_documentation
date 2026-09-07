# Vaccine Recommendation Category - The Cicada Vaccine Forecasting Engine and Guide v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Vaccine Recommendation Category**

## Extension: Vaccine Recommendation Category 

| | |
| :--- | :--- |
| *Official URL*:http://fhirfli.dev/fhir/ig/cicada/StructureDefinition/vaccine-recommendation-category-ext | *Version*:0.1.0 |
| Draft as of 2026-09-07 | *Computable Name*:VaccineRecommendationCategory |

CDC's vaccine recommendation category for one Best Patient Series in this forecast: Routine, High-Risk, or SCDM (shared clinical decision making), determined per CDC's Vaccine Recommendation Category Determination (CDSi supporting data 4.65) once the forecast is known, for a series whose status is Not Complete. Carries the series name, the category, and CDC's material for it. One extension per contributing series that has a category.

**Context of Use**

**Usage info**

**Usages:**

* Examples for this Extension: [ImmunizationRecommendation/cicada-forecast-example](ImmunizationRecommendation-cicada-forecast-example.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/cicada.ig|current/StructureDefinition/StructureDefinition-vaccine-recommendation-category-ext.json)

### Formal Views of Extension Content

 [Description of Profiles, Differentials, Snapshots, and how the XML and JSON presentations work](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](StructureDefinition-vaccine-recommendation-category-ext.csv), [Excel](StructureDefinition-vaccine-recommendation-category-ext.xlsx), [Schematron](StructureDefinition-vaccine-recommendation-category-ext.sch) 

#### Terminology Bindings

#### Constraints



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "vaccine-recommendation-category-ext",
  "url" : "http://fhirfli.dev/fhir/ig/cicada/StructureDefinition/vaccine-recommendation-category-ext",
  "version" : "0.1.0",
  "name" : "VaccineRecommendationCategory",
  "title" : "Vaccine Recommendation Category",
  "status" : "draft",
  "date" : "2026-09-07T18:40:23-04:00",
  "publisher" : "FHIR-FLI",
  "contact" : [{
    "name" : "FHIR-FLI",
    "telecom" : [{
      "system" : "url",
      "value" : "http://fhirfli.dev"
    }]
  }],
  "description" : "CDC's vaccine recommendation category for one Best Patient Series in this forecast: Routine, High-Risk, or SCDM (shared clinical decision making), determined per CDC's Vaccine Recommendation Category Determination (CDSi supporting data 4.65) once the forecast is known, for a series whose status is Not Complete. Carries the series name, the category, and CDC's material for it. One extension per contributing series that has a category.",
  "fhirVersion" : "4.0.1",
  "mapping" : [{
    "identity" : "rim",
    "uri" : "http://hl7.org/v3",
    "name" : "RIM Mapping"
  }],
  "kind" : "complex-type",
  "abstract" : false,
  "context" : [{
    "type" : "element",
    "expression" : "ImmunizationRecommendation.recommendation"
  }],
  "type" : "Extension",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/Extension",
  "derivation" : "constraint",
  "differential" : {
    "element" : [{
      "id" : "Extension",
      "path" : "Extension",
      "short" : "Vaccine Recommendation Category",
      "definition" : "CDC's vaccine recommendation category for one Best Patient Series in this forecast: Routine, High-Risk, or SCDM (shared clinical decision making), determined per CDC's Vaccine Recommendation Category Determination (CDSi supporting data 4.65) once the forecast is known, for a series whose status is Not Complete. Carries the series name, the category, and CDC's material for it. One extension per contributing series that has a category."
    },
    {
      "id" : "Extension.extension",
      "path" : "Extension.extension",
      "min" : 2
    },
    {
      "id" : "Extension.extension:series",
      "path" : "Extension.extension",
      "sliceName" : "series",
      "short" : "The Best Patient Series the category is for",
      "min" : 1,
      "max" : "1"
    },
    {
      "id" : "Extension.extension:series.extension",
      "path" : "Extension.extension.extension",
      "max" : "0"
    },
    {
      "id" : "Extension.extension:series.url",
      "path" : "Extension.extension.url",
      "fixedUri" : "series"
    },
    {
      "id" : "Extension.extension:series.value[x]",
      "path" : "Extension.extension.value[x]",
      "type" : [{
        "code" : "string"
      }]
    },
    {
      "id" : "Extension.extension:category",
      "path" : "Extension.extension",
      "sliceName" : "category",
      "short" : "Routine, High-Risk, or SCDM",
      "min" : 1,
      "max" : "1"
    },
    {
      "id" : "Extension.extension:category.extension",
      "path" : "Extension.extension.extension",
      "max" : "0"
    },
    {
      "id" : "Extension.extension:category.url",
      "path" : "Extension.extension.url",
      "fixedUri" : "category"
    },
    {
      "id" : "Extension.extension:category.value[x]",
      "path" : "Extension.extension.value[x]",
      "type" : [{
        "code" : "CodeableConcept"
      }],
      "binding" : {
        "strength" : "required",
        "valueSet" : "http://fhirfli.dev/fhir/ig/cicada/ValueSet/vaccine-recommendation-category-vs"
      }
    },
    {
      "id" : "Extension.extension:material",
      "path" : "Extension.extension",
      "sliceName" : "material",
      "short" : "CDC's additional material for this recommendation",
      "min" : 0,
      "max" : "*"
    },
    {
      "id" : "Extension.extension:material.extension",
      "path" : "Extension.extension.extension",
      "max" : "0"
    },
    {
      "id" : "Extension.extension:material.url",
      "path" : "Extension.extension.url",
      "fixedUri" : "material"
    },
    {
      "id" : "Extension.extension:material.value[x]",
      "path" : "Extension.extension.value[x]",
      "type" : [{
        "code" : "url"
      }]
    },
    {
      "id" : "Extension.url",
      "path" : "Extension.url",
      "fixedUri" : "http://fhirfli.dev/fhir/ig/cicada/StructureDefinition/vaccine-recommendation-category-ext"
    },
    {
      "id" : "Extension.value[x]",
      "path" : "Extension.value[x]",
      "max" : "0"
    }]
  }
}

```
