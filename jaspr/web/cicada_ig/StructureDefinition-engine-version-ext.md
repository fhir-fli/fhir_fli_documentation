# Engine and Supporting Data Version - The Cicada Vaccine Forecasting Engine and Guide v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Engine and Supporting Data Version**

## Extension: Engine and Supporting Data Version 

| | |
| :--- | :--- |
| *Official URL*:http://fhirfli.dev/fhir/ig/cicada/StructureDefinition/engine-version-ext | *Version*:0.1.0 |
| Draft as of 2026-09-02 | *Computable Name*:EngineVersion |

The engine build and the CDSi supporting-data release that produced this resource. A forecast is a function of both, so a stored response naming neither cannot be traced to what produced it. Parameters is not a DomainResource and carries no extension, so the stamp sits on each evaluation and on each recommendation.

**Context of Use**

**Usage info**

**Usages:**

* This Extension is not used by any profiles in this Implementation Guide

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/cicada.ig|current/StructureDefinition/engine-version-ext)

### Formal Views of Extension Content

 [Description of Profiles, Differentials, Snapshots, and how the XML and JSON presentations work](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](StructureDefinition-engine-version-ext.csv), [Excel](StructureDefinition-engine-version-ext.xlsx), [Schematron](StructureDefinition-engine-version-ext.sch) 

#### Constraints



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "engine-version-ext",
  "url" : "http://fhirfli.dev/fhir/ig/cicada/StructureDefinition/engine-version-ext",
  "version" : "0.1.0",
  "name" : "EngineVersion",
  "title" : "Engine and Supporting Data Version",
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
  "description" : "The engine build and the CDSi supporting-data release that produced this resource. A forecast is a function of both, so a stored response naming neither cannot be traced to what produced it. Parameters is not a DomainResource and carries no extension, so the stamp sits on each evaluation and on each recommendation.",
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
      "expression" : "ImmunizationEvaluation"
    },
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
        "short" : "Engine and Supporting Data Version",
        "definition" : "The engine build and the CDSi supporting-data release that produced this resource. A forecast is a function of both, so a stored response naming neither cannot be traced to what produced it. Parameters is not a DomainResource and carries no extension, so the stamp sits on each evaluation and on each recommendation."
      },
      {
        "id" : "Extension.extension",
        "path" : "Extension.extension",
        "min" : 2
      },
      {
        "id" : "Extension.extension:engine",
        "path" : "Extension.extension",
        "sliceName" : "engine",
        "short" : "Engine name and version, e.g. cicada/0.0.1",
        "min" : 1,
        "max" : "1"
      },
      {
        "id" : "Extension.extension:engine.extension",
        "path" : "Extension.extension.extension",
        "max" : "0"
      },
      {
        "id" : "Extension.extension:engine.url",
        "path" : "Extension.extension.url",
        "fixedUri" : "engine"
      },
      {
        "id" : "Extension.extension:engine.value[x]",
        "path" : "Extension.extension.value[x]",
        "type" : [
          {
            "code" : "string"
          }
        ]
      },
      {
        "id" : "Extension.extension:supportingData",
        "path" : "Extension.extension",
        "sliceName" : "supportingData",
        "short" : "CDSi supporting-data release, e.g. CDSi 4.65-508",
        "min" : 1,
        "max" : "1"
      },
      {
        "id" : "Extension.extension:supportingData.extension",
        "path" : "Extension.extension.extension",
        "max" : "0"
      },
      {
        "id" : "Extension.extension:supportingData.url",
        "path" : "Extension.extension.url",
        "fixedUri" : "supportingData"
      },
      {
        "id" : "Extension.extension:supportingData.value[x]",
        "path" : "Extension.extension.value[x]",
        "type" : [
          {
            "code" : "string"
          }
        ]
      },
      {
        "id" : "Extension.url",
        "path" : "Extension.url",
        "fixedUri" : "http://fhirfli.dev/fhir/ig/cicada/StructureDefinition/engine-version-ext"
      },
      {
        "id" : "Extension.value[x]",
        "path" : "Extension.value[x]",
        "max" : "0"
      }
    ]
  }
}

```
