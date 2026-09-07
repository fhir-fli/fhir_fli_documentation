# Cicada IG Home - The Cicada Vaccine Forecasting Engine and Guide v0.1.0

* [**Table of Contents**](toc.md)
* **Cicada IG Home**

## Cicada IG Home

| | |
| :--- | :--- |
| *Official URL*:http://fhirfli.dev/fhir/ig/cicada/ImplementationGuide/cicada.ig | *Version*:0.1.0 |
| Draft as of 2026-09-07 | *Computable Name*:CicadaIG |

# Cicada IG

## 100% Credit goes to the CDC and their Clinical Decision Support for Immunization (CDSi)

All I've done is take all of their hard work, guidance and expertise and make it computable (well, perhaps it's already computable, I made a computer actually do it).

The CDSi Logic Specification can be found on the [CDC CDSi page](https://www.cdc.gov/iis/cdsi/). The current supporting data version implemented is **4.61-508**.

First, a warning: This is not completely FHIR compliant. As part of this was to help myself get more familiar with [FHIR Shorthand (commonly known as FSH)](https://build.fhir.org/ig/HL7/fhir-shorthand/), there are some "Resources" I've defined (e.g. [Antigen Supporting Data](StructureDefinition-AntigenSupportingData.md) and [Schedule Supporting Data](StructureDefinition-ScheduleSupportingData.md)), that are certainly NOT FHIR. However, they are an accurate representation (at least in JSON) for the data used in the CDC's "CLINICAL DECISION SUPPORT FOR IMMUNIZATION (CDSI): LOGIC SPECIFICATION FOR ACIP RECOMMENDATIONS".

### Preparation

* Technical background on the code generator and build pipeline for anyone interested in working on this themselves.

### Immunization Decision Support Forecast Working Group

* Because I can never find it
* Official HL7 working group

### Logical Specification Concepts

* There are a number of concepts that are involved in the evaluation and prediction of immunizations. Some of these terms make logical sense, but others do not. Here's a description of some of them. Again, this was all taken from the [Clinical Decision Support for Immunization (CDSi)](https://www.cdc.gov/iis/cdsi/).

### Processing Model

* Brief overview of the analysis and forecasting process prior to a detailed discussion.

### Evaluate Vaccine Dose Administered

* Summarizes the steps to evaluate every vaccine within every series to which it applies.

### Forecast Dates and Reasons

* Made it through the evaluation process. Next up, creating the forecast.

### Select Patient Series

* After evaluating and forecasting, we need to pick the best series for each antigen. This covers pre-filtering, prioritization, scoring, and final selection. 

### Dependencies and terminology

 




*There are no Global profiles defined*

* Parameter: system-version
  * Value: SNOMED CT[US]

This is an R4 IG. None of the features it uses are changed in R4B, so it can be used as is with R4B systems. Packages for both [R4 (cicada.ig.r4)](package.r4.tgz) and [R4B (cicada.ig.r4b)](package.r4b.tgz) are available.

### Intellectual property

This publication includes IP covered under the following statements.

* Current Procedural Terminology (CPT) is copyright 2020 American Medical Association. All rights reserved

* [CPT](http://tx.fhir.org/r4/ValueSet/x-cpt2023): [ImmunizationProceduresCpt](ValueSet-immunization-procedures-cpt.md)


* This material contains content from [LOINC](http://loinc.org). LOINC is copyright © 1995-2020, Regenstrief Institute, Inc. and the Logical Observation Identifiers Names and Codes (LOINC) Committee and is available at no cost under the [license](http://loinc.org/license). LOINC® is a registered United States trademark of Regenstrief Institute, Inc.

* [LOINC](http://tx.fhir.org/r4/ValueSet/x-loinc2.82): [CicadaImmunizationRecommendation](StructureDefinition-cicada-immunization-recommendation.md), [ForecastStatusVS](ValueSet-forecast-status.md), [ImmunizationRecommendation/cicada-forecast-example](ImmunizationRecommendation-cicada-forecast-example.md) and [VaccineLabEvidenceOfImmunityLoinc](ValueSet-vaccine-lab-evidence-of-immunity-loinc.md)


* This material contains content that is copyright of SNOMED International. Implementers of these specifications must have the appropriate SNOMED CT Affiliate license - for more information contact [https://www.snomed.org/get-snomed](https://www.snomed.org/get-snomed) or [info@snomed.org](mailto:info@snomed.org).

* [SNOMED Clinical Terms&reg; (SNOMED CT&reg;)](http://hl7.org/fhir/R4/codesystem-snomedct.html): [AllergyIntolerance/allergy-vaccine-reaction](AllergyIntolerance-allergy-vaccine-reaction.md), [Condition/2016-UC-0032-055](Condition-2016-UC-0032-055.md)... Show 13 more, [ImmunizationEvaluation/2016-UC-0032-1](ImmunizationEvaluation-2016-UC-0032-1.md), [ImmunizationEvaluation/2016-UC-0032-2](ImmunizationEvaluation-2016-UC-0032-2.md), [ImmunizationEvaluation/2016-UC-0032-3](ImmunizationEvaluation-2016-UC-0032-3.md), [ImmunizationProceduresSnomed](ValueSet-procedures.md), [ImmunizationRecommendation/cicada-forecast-example](ImmunizationRecommendation-cicada-forecast-example.md), [Observation/observation-immunocompromised](Observation-observation-immunocompromised.md), [Procedure/procedure-stem-cell-transplant](Procedure-procedure-stem-cell-transplant.md), [ProcedureProfile](StructureDefinition-ProcedureProfile.md), [ReactionProfile](StructureDefinition-ReactionProfile.md), [VaccineConditionCodesSnomed](ValueSet-vaccine-condition-codes-snomed.md), [VaccineConditionFhir](StructureDefinition-VaccineConditionFhir.md), [VaccineMedicationCodesSnomed](ValueSet-vaccine-medication-codes-snomed.md) and [VaccineObservationFhir](StructureDefinition-VaccineObservationFhir.md)


* This material derives from the HL7 Terminology (THO). THO is copyright ©1989+ Health Level Seven International and is made available under the CC0 designation. For more licensing information see: [https://terminology.hl7.org/license.html](https://terminology.hl7.org/license.html)

* [AllergyIntolerance Clinical Status Codes](http://terminology.hl7.org/7.3.0/CodeSystem-allergyintolerance-clinical.html): [AllergyIntolerance/allergy-vaccine-reaction](AllergyIntolerance-allergy-vaccine-reaction.md)
* [Condition Clinical Status Codes](http://terminology.hl7.org/7.3.0/CodeSystem-condition-clinical.html): [Condition/2016-UC-0032-055](Condition-2016-UC-0032-055.md)
* [Immunization Evaluation Dose Status codes](http://terminology.hl7.org/7.3.0/CodeSystem-immunization-evaluation-dose-status.html): [EvalStatusVS](ValueSet-eval-status.md), [ImmunizationEvaluation/2016-UC-0032-1](ImmunizationEvaluation-2016-UC-0032-1.md), [ImmunizationEvaluation/2016-UC-0032-2](ImmunizationEvaluation-2016-UC-0032-2.md) and [ImmunizationEvaluation/2016-UC-0032-3](ImmunizationEvaluation-2016-UC-0032-3.md)
* [Immunization Recommendation Status Codes](http://terminology.hl7.org/7.3.0/CodeSystem-immunization-recommendation-status.html): [CicadaImmunizationRecommendation](StructureDefinition-cicada-immunization-recommendation.md), [ForecastStatusVS](ValueSet-forecast-status.md) and [ImmunizationRecommendation/cicada-forecast-example](ImmunizationRecommendation-cicada-forecast-example.md)
* [Immunization Subpotent Reason](http://terminology.hl7.org/7.3.0/CodeSystem-immunization-subpotent-reason.html): [VaxDose](StructureDefinition-vax-dose.md)




## Resource Content

```json
{
  "resourceType" : "ImplementationGuide",
  "id" : "cicada.ig",
  "url" : "http://fhirfli.dev/fhir/ig/cicada/ImplementationGuide/cicada.ig",
  "version" : "0.1.0",
  "name" : "CicadaIG",
  "title" : "The Cicada Vaccine Forecasting Engine and Guide",
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
  "description" : "Example Implementation Guide for using the CDC's Clinical Decision Support for Immunization",
  "packageId" : "cicada.ig",
  "license" : "CC0-1.0",
  "fhirVersion" : ["4.0.1"],
  "dependsOn" : [{
    "id" : "hl7tx",
    "extension" : [{
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/implementationguide-dependency-comment",
      "valueMarkdown" : "Automatically added as a dependency - all IGs depend on HL7 Terminology"
    }],
    "uri" : "http://terminology.hl7.org/ImplementationGuide/hl7.terminology",
    "packageId" : "hl7.terminology.r4",
    "version" : "7.3.0"
  },
  {
    "id" : "hl7ext",
    "extension" : [{
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/implementationguide-dependency-comment",
      "valueMarkdown" : "Automatically added as a dependency - all IGs depend on the HL7 Extension Pack"
    }],
    "uri" : "http://hl7.org/fhir/extensions/ImplementationGuide/hl7.fhir.uv.extensions",
    "packageId" : "hl7.fhir.uv.extensions.r4",
    "version" : "5.3.0"
  },
  {
    "id" : "hl7_fhir_us_immds",
    "uri" : "http://hl7.org/fhir/us/immds/ImplementationGuide/hl7.fhir.us.immds",
    "packageId" : "hl7.fhir.us.immds",
    "version" : "1.0.0"
  }],
  "definition" : {
    "extension" : [{
      "extension" : [{
        "url" : "code",
        "valueString" : "copyrightyear"
      },
      {
        "url" : "value",
        "valueString" : "2024+"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "releaselabel"
      },
      {
        "url" : "value",
        "valueString" : "ci-build"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "special-url"
      },
      {
        "url" : "value",
        "valueString" : "http://hl7.org/fhir/sid/icd-10-cm"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "path-suppressed-warnings"
      },
      {
        "url" : "value",
        "valueString" : "input/ignoreWarnings.txt"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "path-expansion-params"
      },
      {
        "url" : "value",
        "valueString" : "../../input/resources/Parameters-manifest.json"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "autoload-resources"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "path-liquid"
      },
      {
        "url" : "value",
        "valueString" : "template/liquid"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "path-liquid"
      },
      {
        "url" : "value",
        "valueString" : "input/liquid"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "path-qa"
      },
      {
        "url" : "value",
        "valueString" : "temp/qa"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "path-temp"
      },
      {
        "url" : "value",
        "valueString" : "temp/pages"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "path-output"
      },
      {
        "url" : "value",
        "valueString" : "output"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "path-history"
      },
      {
        "url" : "value",
        "valueString" : "http://fhirfli.dev/fhir/ig/cicada/history.html"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "template-html"
      },
      {
        "url" : "value",
        "valueString" : "template-page.html"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "template-md"
      },
      {
        "url" : "value",
        "valueString" : "template-page-md.html"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "apply-contact"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "apply-context"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "apply-copyright"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "apply-jurisdiction"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "apply-license"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "apply-publisher"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "apply-version"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "apply-wg"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "active-tables"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "fmm-definition"
      },
      {
        "url" : "value",
        "valueString" : "http://hl7.org/fhir/versions.html#maturity"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "propagate-status"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "excludelogbinaryformat"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "tabbed-snapshots"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/expansion-parameters",
      "valueReference" : {
        "reference" : "Parameters/expansion-parameters"
      }
    },
    {
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-internal-dependency",
      "valueCode" : "hl7.fhir.uv.tools.r4#1.1.2"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "copyrightyear"
      },
      {
        "url" : "value",
        "valueString" : "2024+"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "releaselabel"
      },
      {
        "url" : "value",
        "valueString" : "ci-build"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "special-url"
      },
      {
        "url" : "value",
        "valueString" : "http://hl7.org/fhir/sid/icd-10-cm"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "path-suppressed-warnings"
      },
      {
        "url" : "value",
        "valueString" : "input/ignoreWarnings.txt"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "path-expansion-params"
      },
      {
        "url" : "value",
        "valueString" : "../../input/resources/Parameters-manifest.json"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "autoload-resources"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "path-liquid"
      },
      {
        "url" : "value",
        "valueString" : "template/liquid"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "path-liquid"
      },
      {
        "url" : "value",
        "valueString" : "input/liquid"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "path-qa"
      },
      {
        "url" : "value",
        "valueString" : "temp/qa"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "path-temp"
      },
      {
        "url" : "value",
        "valueString" : "temp/pages"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "path-output"
      },
      {
        "url" : "value",
        "valueString" : "output"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "path-history"
      },
      {
        "url" : "value",
        "valueString" : "http://fhirfli.dev/fhir/ig/cicada/history.html"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "template-html"
      },
      {
        "url" : "value",
        "valueString" : "template-page.html"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "template-md"
      },
      {
        "url" : "value",
        "valueString" : "template-page-md.html"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "apply-contact"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "apply-context"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "apply-copyright"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "apply-jurisdiction"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "apply-license"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "apply-publisher"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "apply-version"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "apply-wg"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "active-tables"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "fmm-definition"
      },
      {
        "url" : "value",
        "valueString" : "http://hl7.org/fhir/versions.html#maturity"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "propagate-status"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "excludelogbinaryformat"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "tabbed-snapshots"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    }],
    "resource" : [{
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "Patient"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "Patient-2016-UC-0032.html"
      }],
      "reference" : {
        "reference" : "Patient/2016-UC-0032"
      },
      "name" : "2016-UC-0032",
      "description" : "The patient of CDC CDSi condition test case 2016-UC-0032, the case the forecast example is computed from.",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "Condition"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "Condition-2016-UC-0032-055.html"
      }],
      "reference" : {
        "reference" : "Condition/2016-UC-0032-055"
      },
      "name" : "2016-UC-0032-055",
      "description" : "The one condition in case 2016-UC-0032, CDSi observation 055 Health care personnel, as the engine reads it (VaccineConditionFhir).",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "ImmunizationEvaluation"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "ImmunizationEvaluation-2016-UC-0032-1.html"
      }],
      "reference" : {
        "reference" : "ImmunizationEvaluation/2016-UC-0032-1"
      },
      "name" : "2016-UC-0032-1",
      "description" : "The engine's evaluation of the case's MMR dose against measles, with the target-dose status and the sub-step detail extensions.",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "ImmunizationEvaluation"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "ImmunizationEvaluation-2016-UC-0032-2.html"
      }],
      "reference" : {
        "reference" : "ImmunizationEvaluation/2016-UC-0032-2"
      },
      "name" : "2016-UC-0032-2",
      "description" : "The engine's evaluation of the case's MMR dose against mumps.",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "ImmunizationEvaluation"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "ImmunizationEvaluation-2016-UC-0032-3.html"
      }],
      "reference" : {
        "reference" : "ImmunizationEvaluation/2016-UC-0032-3"
      },
      "name" : "2016-UC-0032-3",
      "description" : "The engine's evaluation of the case's MMR dose against rubella.",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "Immunization"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "Immunization-2016-UC-0032-dose1.html"
      }],
      "reference" : {
        "reference" : "Immunization/2016-UC-0032-dose1"
      },
      "name" : "2016-UC-0032-dose1",
      "description" : "The one dose in case 2016-UC-0032, an MMR, as the engine reads it (vax-dose).",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "StructureDefinition:resource"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "StructureDefinition-ReactionProfile.html"
      }],
      "reference" : {
        "reference" : "StructureDefinition/ReactionProfile"
      },
      "name" : "Allergy Intolerance Profile for Immunization Decision Support",
      "description" : "Profile for allergy intolerances relevant to immunization. The code (allergen/substance) may use SNOMED CT or ICD-10-CM. Reaction substances may use CVX, MVX, SNOMED CT, or RxNorm.",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "AllergyIntolerance"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "AllergyIntolerance-allergy-vaccine-reaction.html"
      }],
      "reference" : {
        "reference" : "AllergyIntolerance/allergy-vaccine-reaction"
      },
      "name" : "AllergyIntolerance: adverse reaction to a vaccine",
      "description" : "An allergy record the engine reads as a contraindication candidate: SNOMED 293104008, Vaccines adverse reaction, the root of the vaccine reaction concepts in the condition value set, with the substance as the CVX of the vaccine reacted to.",
      "exampleCanonical" : "http://fhirfli.dev/fhir/ig/cicada/StructureDefinition/ReactionProfile"
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "StructureDefinition:extension"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "StructureDefinition-antigen-needing-dose-ext.html"
      }],
      "reference" : {
        "reference" : "StructureDefinition/antigen-needing-dose-ext"
      },
      "name" : "Antigen Needing a Dose",
      "description" : "An antigen within this vaccine group that needs the forecast dose. A multi-antigen group forecasts as one recommendation, so without this a caller cannot tell whether all of MMR is due or only the measles component. Repeats, one per antigen.",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "StructureDefinition:logical"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "StructureDefinition-AntigenSupportingData.html"
      }],
      "reference" : {
        "reference" : "StructureDefinition/AntigenSupportingData"
      },
      "name" : "Antigen Supporting Data",
      "description" : "A resource to store supporting data for antigens including target disease, vaccine groups, immunity criteria, contraindications, and vaccination series.",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "StructureDefinition:extension"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "StructureDefinition-begin-age.html"
      }],
      "reference" : {
        "reference" : "StructureDefinition/begin-age"
      },
      "name" : "Begin Age",
      "description" : "The age at which the vaccine becomes applicable.",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "CodeSystem"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "CodeSystem-cdsi-observation-codes.html"
      }],
      "reference" : {
        "reference" : "CodeSystem/cdsi-observation-codes"
      },
      "name" : "CDSI Observation Codes",
      "description" : "Observations and Conditions that are important to indications or contraindications in vaccine forecasting",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "ValueSet"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "ValueSet-cdsi-observation-codes-vs.html"
      }],
      "reference" : {
        "reference" : "ValueSet/cdsi-observation-codes-vs"
      },
      "name" : "CDSI Observation Codes Value Set",
      "description" : "Every CDSi observation code, as published in the supporting data.",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "CodeSystem"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "CodeSystem-data-integrity.html"
      }],
      "reference" : {
        "reference" : "CodeSystem/data-integrity"
      },
      "name" : "Cicada Data Integrity Code System",
      "description" : "Records that cannot describe an administration. CDSi evaluates a vaccine dose administered and defines the assessment date as the current date, so these doses are excluded from evaluation and forecasting and reported in an OperationOutcome. They are statements about the data, never about the patient's immunity, which is why they are not evaluation statuses.",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "ValueSet"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "ValueSet-data-integrity-vs.html"
      }],
      "reference" : {
        "reference" : "ValueSet/data-integrity-vs"
      },
      "name" : "Cicada Data Integrity Value Set",
      "description" : "Reasons a dose was reported rather than evaluated.",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "CodeSystem"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "CodeSystem-EvalStatus.html"
      }],
      "reference" : {
        "reference" : "CodeSystem/EvalStatus"
      },
      "name" : "Cicada Evaluation Status",
      "description" : "Extension codes for dose evaluation status beyond the HL7 THO immunization-evaluation-dose-status CodeSystem. Only codes not covered by the standard are defined here.",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "CodeSystem"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "CodeSystem-forecast-reason.html"
      }],
      "reference" : {
        "reference" : "CodeSystem/forecast-reason"
      },
      "name" : "Cicada Forecast Reason Code System",
      "description" : "Why the engine forecast what it did. The ImmDS ForecastReason code system covers four of these; the rest have no ImmDS concept, and the ImmDS binding on ImmunizationRecommendation.recommendation.forecastReason is example strength, so they travel as a second coding rather than being dropped.",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "ValueSet"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "ValueSet-forecast-reason-vs.html"
      }],
      "reference" : {
        "reference" : "ValueSet/forecast-reason-vs"
      },
      "name" : "Cicada Forecast Reason Value Set",
      "description" : "Forecast reasons the engine can report.",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "StructureDefinition:resource"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "StructureDefinition-cicada-immunization-recommendation.html"
      }],
      "reference" : {
        "reference" : "StructureDefinition/cicada-immunization-recommendation"
      },
      "name" : "Cicada Immunization Recommendation",
      "description" : "The forecast cicada returns. Constrains ImmunizationRecommendation to say which series group each recommendation belongs to, so that more than one recommendation for a single vaccine group can be told apart.",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "ImmunizationRecommendation"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "ImmunizationRecommendation-cicada-forecast-example.html"
      }],
      "reference" : {
        "reference" : "ImmunizationRecommendation/cicada-forecast-example"
      },
      "name" : "cicada-forecast-example",
      "description" : "The engine's forecast for 2016-UC-0032, all 17 recommendations, regenerated from the engine by cicada/tool/write_ig_example.dart.",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "StructureDefinition:resource"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "StructureDefinition-VaccineConditionFhir.html"
      }],
      "reference" : {
        "reference" : "StructureDefinition/VaccineConditionFhir"
      },
      "name" : "Condition Profile with Vaccine Condition Codes",
      "description" : "Profile for conditions where the code must be from the Vaccine Condition Codes value set. Accepts SNOMED CT and ICD-10-CM coded conditions.",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "StructureDefinition:extension"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "StructureDefinition-series-detail-ext.html"
      }],
      "reference" : {
        "reference" : "StructureDefinition/series-detail-ext"
      },
      "name" : "Contributing Series Detail",
      "description" : "One contributing series: its own status, its own four dates, and the component dates that produced them. A vaccine group forecast reports the aggregate over several series, so without this a group covered by more than one reports a single answer for all of them, and a due date arrives with no way to see whether age or interval produced it. Repeats, one per series.",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "StructureDefinition:resource"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "StructureDefinition-vax-dose.html"
      }],
      "reference" : {
        "reference" : "StructureDefinition/vax-dose"
      },
      "name" : "Dose of a Vaccine",
      "description" : "An administered dose as the engine reads it: the vaccine as CVX, the date, the patient, and optionally the dose volume, the manufacturer and a subpotency reason. The engine's evaluation of the dose is returned on ImmunizationEvaluation (target-dose-status-ext, evaluation-detail-ext), not written back onto the Immunization; until 2026-09-07 this profile declared thirteen evaluation extensions nothing ever emitted.",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "ValueSet"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "ValueSet-dose-status-reason.html"
      }],
      "reference" : {
        "reference" : "ValueSet/dose-status-reason"
      },
      "name" : "Dose Status Reason Value Set",
      "description" : "Value set for dose evaluation status reasons, referencing the published ImmDS IG StatusReason CodeSystem.",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "StructureDefinition:extension"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "StructureDefinition-doses-remaining-ext.html"
      }],
      "reference" : {
        "reference" : "StructureDefinition/doses-remaining-ext"
      },
      "name" : "Doses Remaining",
      "description" : "How many doses remain in the series after the one being forecast, or 'Recurring' where the series ends in a recurring dose. seriesDoses and doseNumber allow a reader to subtract, but no arithmetic says the series never ends.",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "StructureDefinition:extension"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "StructureDefinition-end-age.html"
      }],
      "reference" : {
        "reference" : "StructureDefinition/end-age"
      },
      "name" : "End Age",
      "description" : "The age at which the vaccine is no longer applicable.",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "StructureDefinition:extension"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "StructureDefinition-engine-version-ext.html"
      }],
      "reference" : {
        "reference" : "StructureDefinition/engine-version-ext"
      },
      "name" : "Engine and Supporting Data Version",
      "description" : "The engine build and the CDSi supporting-data release that produced this resource. A forecast is a function of both, so a stored response naming neither cannot be traced to what produced it. Parameters is not a DomainResource and carries no extension, so the stamp sits on each evaluation and on each recommendation.",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "ValueSet"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "ValueSet-eval-reason.html"
      }],
      "reference" : {
        "reference" : "ValueSet/eval-reason"
      },
      "name" : "Evaluation Reason",
      "description" : "The reason for the evaluation.",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "CodeSystem"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "CodeSystem-EvalReason.html"
      }],
      "reference" : {
        "reference" : "CodeSystem/EvalReason"
      },
      "name" : "Evaluation Reason",
      "description" : "The reason for the evaluation.",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "ValueSet"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "ValueSet-eval-status.html"
      }],
      "reference" : {
        "reference" : "ValueSet/eval-status"
      },
      "name" : "Evaluation Status Value Set",
      "description" : "Combined value set for dose evaluation status, including HL7 THO standard codes (valid, notvalid) and the Cicada extension code (extraneous).",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "StructureDefinition:extension"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "StructureDefinition-evaluation-detail-ext.html"
      }],
      "reference" : {
        "reference" : "StructureDefinition/evaluation-detail-ext"
      },
      "name" : "Evaluation Sub-step Detail",
      "description" : "The CDSi Chapter 6 sub-step outcomes behind a dose's evaluation: which of age, interval, conflict and vaccine choice passed, and for those that failed, which rule failed. doseStatusReason carries ten ImmDS codes; the engine knows more than that.",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "ValueSet"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "ValueSet-forecast-status.html"
      }],
      "reference" : {
        "reference" : "ValueSet/forecast-status"
      },
      "name" : "Forecast Status Value Set",
      "description" : "Combined value set for immunization forecast status, referencing published standard CodeSystems. Includes ImmDS IG ForecastStatus (CDSi-compatible), HL7 THO immunization-recommendation-status, and LOINC answer list LL940-8.",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "CodeSystem"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "CodeSystem-icd-10-cm.html"
      }],
      "reference" : {
        "reference" : "CodeSystem/icd-10-cm"
      },
      "name" : "ICD-10-CM (external, content not present)",
      "description" : "Placeholder for the International Classification of Diseases, Tenth Revision, Clinical Modification, maintained by the US National Center for Health Statistics. No concepts are carried here; codes are validated by the terminology server.",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "ConceptMap"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "ConceptMap-Icd10ToCdsiObservation.html"
      }],
      "reference" : {
        "reference" : "ConceptMap/Icd10ToCdsiObservation"
      },
      "name" : "ICD-10-CM to CDSi Observation Code Map",
      "description" : "Maps ICD-10-CM codes to CDSi observation codes used in immunization decision support. Generated from the cicada crosswalk.",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "StructureDefinition:resource"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "StructureDefinition-ProcedureProfile.html"
      }],
      "reference" : {
        "reference" : "StructureDefinition/ProcedureProfile"
      },
      "name" : "Immunization Procedures Profile",
      "description" : "Profile for medical procedures related to immunization based on SNOMED CT or CPT codes.",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "ValueSet"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "ValueSet-vaccine-medication-codes-rxnorm.html"
      }],
      "reference" : {
        "reference" : "ValueSet/vaccine-medication-codes-rxnorm"
      },
      "name" : "Immunization-Relevant Medications (RxNorm)",
      "description" : "RxNorm codes for medications relevant to immunization decision support, including antivirals and aspirin.",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "ValueSet"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "ValueSet-immunization-procedures-cpt.html"
      }],
      "reference" : {
        "reference" : "ValueSet/immunization-procedures-cpt"
      },
      "name" : "Immunization-Relevant Procedures (CPT)",
      "description" : "CPT codes for procedures relevant to immunization decision support, including splenectomy and cochlear implant.",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "ValueSet"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "ValueSet-interval-reason.html"
      }],
      "reference" : {
        "reference" : "ValueSet/interval-reason"
      },
      "name" : "Interval Reason",
      "description" : "This value set includes codes for the reason an interval is considered to be invalid.",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "CodeSystem"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "CodeSystem-IntervalReason.html"
      }],
      "reference" : {
        "reference" : "CodeSystem/IntervalReason"
      },
      "name" : "Interval Reason",
      "description" : "This value set includes codes for the reason an interval is considered to be invalid.",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "ValueSet"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "ValueSet-vaccine-lab-evidence-of-immunity-loinc.html"
      }],
      "reference" : {
        "reference" : "ValueSet/vaccine-lab-evidence-of-immunity-loinc"
      },
      "name" : "Lab Evidence of Immunity (LOINC)",
      "description" : "LOINC codes for laboratory tests that provide evidence of immunity, mapped to CDSi observation codes for immunization decision support. Serum IgG in every case, plus total antibody for hepatitis A, which is what evidence of immunity means for these antigens; IgM, cerebrospinal fluid and avidity codes are deliberately excluded.",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "Parameters"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "Parameters-manifest.html"
      }],
      "reference" : {
        "reference" : "Parameters/manifest"
      },
      "name" : "manifest",
      "description" : "Expansion parameters for the build: SNOMED CT is expanded and validated against the US edition, which carries the US-extension concepts CDSi cites.",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "StructureDefinition:resource"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "StructureDefinition-MedicationAdministrationProfile.html"
      }],
      "reference" : {
        "reference" : "StructureDefinition/MedicationAdministrationProfile"
      },
      "name" : "Medication Administration Profile with Vaccine Codes",
      "description" : "Profile for medication administrations with vaccine codes from CVX or MVX.",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "StructureDefinition:resource"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "StructureDefinition-MedicationDispenseProfile.html"
      }],
      "reference" : {
        "reference" : "StructureDefinition/MedicationDispenseProfile"
      },
      "name" : "Medication Dispense Profile with Vaccine Codes",
      "description" : "Profile for medication dispenses with vaccine codes from CVX or MVX.",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "StructureDefinition:resource"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "StructureDefinition-MedicationRequestProfile.html"
      }],
      "reference" : {
        "reference" : "StructureDefinition/MedicationRequestProfile"
      },
      "name" : "Medication Request Profile with Vaccine Codes",
      "description" : "Profile for medication requests with vaccine codes from CVX or MVX.",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "StructureDefinition:resource"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "StructureDefinition-MedicationStatementProfile.html"
      }],
      "reference" : {
        "reference" : "StructureDefinition/MedicationStatementProfile"
      },
      "name" : "Medication Statement Profile with Vaccine Codes",
      "description" : "Profile for medication statements with vaccine codes from CVX or MVX.",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "Medication"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "Medication-vaccine-hepb-adult.html"
      }],
      "reference" : {
        "reference" : "Medication/vaccine-hepb-adult"
      },
      "name" : "Medication: Hep B, adult",
      "description" : "A vaccine product as a Medication: CVX 43 with a trade name, the age from which CDC's HepB 3-dose series lists it as a preferable vaccine (20 years, no upper bound), and its vaccine type. CVX 08's begin age of 0 days cannot be an example here: FHIR's Age datatype requires a positive value (age-1).",
      "exampleCanonical" : "http://fhirfli.dev/fhir/ig/cicada/StructureDefinition/Vaccine"
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "MedicationAdministration"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "MedicationAdministration-medication-administration-hepb.html"
      }],
      "reference" : {
        "reference" : "MedicationAdministration/medication-administration-hepb"
      },
      "name" : "MedicationAdministration: a vaccine given as a medication",
      "description" : "A hepatitis B dose recorded as a MedicationAdministration, which the engine accepts as an administered dose.",
      "exampleCanonical" : "http://fhirfli.dev/fhir/ig/cicada/StructureDefinition/MedicationAdministrationProfile"
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "MedicationDispense"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "MedicationDispense-medication-dispense-hepb.html"
      }],
      "reference" : {
        "reference" : "MedicationDispense/medication-dispense-hepb"
      },
      "name" : "MedicationDispense: a vaccine dispensed as a medication",
      "description" : "A hepatitis B dose dispensed as a MedicationDispense.",
      "exampleCanonical" : "http://fhirfli.dev/fhir/ig/cicada/StructureDefinition/MedicationDispenseProfile"
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "MedicationRequest"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "MedicationRequest-medication-request-hepb.html"
      }],
      "reference" : {
        "reference" : "MedicationRequest/medication-request-hepb"
      },
      "name" : "MedicationRequest: a vaccine ordered as a medication",
      "description" : "A hepatitis B dose ordered as a MedicationRequest.",
      "exampleCanonical" : "http://fhirfli.dev/fhir/ig/cicada/StructureDefinition/MedicationRequestProfile"
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "ValueSet"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "ValueSet-vaccine-medication-codes-snomed.html"
      }],
      "reference" : {
        "reference" : "ValueSet/vaccine-medication-codes-snomed"
      },
      "name" : "Medications",
      "description" : "Value set for medications and substances based on SNOMED CT, including both active ingredients and marketed products.",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "MedicationStatement"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "MedicationStatement-medication-statement-hepb.html"
      }],
      "reference" : {
        "reference" : "MedicationStatement/medication-statement-hepb"
      },
      "name" : "MedicationStatement: a vaccine recorded as a medication",
      "description" : "A hepatitis B dose recorded as a MedicationStatement, which the engine accepts as an administered dose.",
      "exampleCanonical" : "http://fhirfli.dev/fhir/ig/cicada/StructureDefinition/MedicationStatementProfile"
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "StructureDefinition:resource"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "StructureDefinition-VaccineObservationFhir.html"
      }],
      "reference" : {
        "reference" : "StructureDefinition/VaccineObservationFhir"
      },
      "name" : "Observation Profile for Immunization Decision Support",
      "description" : "Profile for Observation resources carrying lab evidence of immunity or other findings relevant to immunization decisions. Codes may be from SNOMED CT, ICD-10-CM, or LOINC.",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "Observation"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "Observation-observation-immunocompromised.html"
      }],
      "reference" : {
        "reference" : "Observation/observation-immunocompromised"
      },
      "name" : "Observation: patient immunocompromised",
      "description" : "A coded observation carrying CDSi observation 003, Immunocompromised, as its SNOMED coded value 370388006.",
      "exampleCanonical" : "http://fhirfli.dev/fhir/ig/cicada/StructureDefinition/VaccineObservationFhir"
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "Procedure"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "Procedure-procedure-stem-cell-transplant.html"
      }],
      "reference" : {
        "reference" : "Procedure/procedure-stem-cell-transplant"
      },
      "name" : "Procedure: haemopoietic stem cell transplant",
      "description" : "A procedure the engine reads as an immunization-relevant history item: SNOMED 234336002, one of the roots of the immunization procedures value set.",
      "exampleCanonical" : "http://fhirfli.dev/fhir/ig/cicada/StructureDefinition/ProcedureProfile"
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "ValueSet"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "ValueSet-procedures.html"
      }],
      "reference" : {
        "reference" : "ValueSet/procedures"
      },
      "name" : "Procedures",
      "description" : "Comprehensive Value Set for medical procedures based on SNOMED CT codes.",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "ValueSet"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "ValueSet-preferred-allowed-reason.html"
      }],
      "reference" : {
        "reference" : "ValueSet/preferred-allowed-reason"
      },
      "name" : "Reasons why certain doses are Preferred or Allowed doses",
      "description" : "Reasons why certain doses are Preferred or Allowed doses",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "CodeSystem"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "CodeSystem-PreferredAllowedReason.html"
      }],
      "reference" : {
        "reference" : "CodeSystem/PreferredAllowedReason"
      },
      "name" : "Reasons why certain doses are Preferred or Allowed doses",
      "description" : "Reasons why certain doses are Preferred or Allowed doses",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "StructureDefinition:logical"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "StructureDefinition-ScheduleSupportingData.html"
      }],
      "reference" : {
        "reference" : "StructureDefinition/ScheduleSupportingData"
      },
      "name" : "Schedule Supporting Data",
      "description" : "This resource consolidates various mapping and conflict information related to vaccine scheduling to support decision-making processes.",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "StructureDefinition:extension"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "StructureDefinition-series-group-ext.html"
      }],
      "reference" : {
        "reference" : "StructureDefinition/series-group-ext"
      },
      "name" : "Series Group",
      "description" : "The series group this forecast is scoped to, per CDSi FORECASTVG-1. recommendation.series names the series; core FHIR has nowhere for the group.",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "StructureDefinition:extension"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "StructureDefinition-series-type-ext.html"
      }],
      "reference" : {
        "reference" : "StructureDefinition/series-type-ext"
      },
      "name" : "Series Type",
      "description" : "Whether this recommendation came from the standard series group or a risk series group. Present so a client receiving two recommendations for one vaccine group can tell which pathway each describes.",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "CodeSystem"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "CodeSystem-series-type.html"
      }],
      "reference" : {
        "reference" : "CodeSystem/series-type"
      },
      "name" : "Series Type Code System",
      "description" : "CDSi series type: whether a patient series is the routine schedule, one indicated by a risk condition, or evaluation-only. Mirrors the seriesType attribute of the CDSi antigen supporting data.",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "ValueSet"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "ValueSet-series-type-vs.html"
      }],
      "reference" : {
        "reference" : "ValueSet/series-type-vs"
      },
      "name" : "Series Type Value Set",
      "description" : "Series types a forecast can be scoped to. In practice a forecast carries standard or risk: CDSi Table 8-14 excludes Evaluation Only series from best patient series.",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "ConceptMap"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "ConceptMap-SnomedToCdsiObservation.html"
      }],
      "reference" : {
        "reference" : "ConceptMap/SnomedToCdsiObservation"
      },
      "name" : "SNOMED CT to CDSi Observation Code Map",
      "description" : "Maps SNOMED CT codes to CDSi observation codes used in immunization decision support. Generated from CDC's supporting data.",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "StructureDefinition:extension"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "StructureDefinition-target-dose-status-ext.html"
      }],
      "reference" : {
        "reference" : "StructureDefinition/target-dose-status-ext"
      },
      "name" : "Target Dose Status",
      "description" : "The CDSi target dose status this administered dose produced.",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "CodeSystem"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "CodeSystem-target-dose-status.html"
      }],
      "reference" : {
        "reference" : "CodeSystem/target-dose-status"
      },
      "name" : "Target Dose Status Code System",
      "description" : "CDSi Table 3-2. The status of the target dose an administered dose was evaluated against. R4 ImmunizationEvaluation carries only doseNumber, derived from this, so a skipped target dose and a satisfied one are otherwise indistinguishable.",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "ValueSet"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "ValueSet-target-dose-status-vs.html"
      }],
      "reference" : {
        "reference" : "ValueSet/target-dose-status-vs"
      },
      "name" : "Target Dose Status Value Set",
      "description" : "CDSi target dose statuses.",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "StructureDefinition:resource"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "StructureDefinition-vax-patient.html"
      }],
      "reference" : {
        "reference" : "StructureDefinition/vax-patient"
      },
      "name" : "Vaccination Patient",
      "description" : "A profile that extends the base FHIR Patient resource to include detailed vaccination-related information.",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "StructureDefinition:resource"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "StructureDefinition-Vaccine.html"
      }],
      "reference" : {
        "reference" : "StructureDefinition/Vaccine"
      },
      "name" : "Vaccine",
      "description" : "A vaccine product as CDC's supporting data describes one: the CVX, the trade name, the ages between which it is a preferable vaccine, and its type. Note that beginAge and endAge are FHIR Age values, which must be positive (age-1), so CDC's \"0 days\" cannot be carried; a begin age of 0 days is expressed by omitting beginAge.",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "ValueSet"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "ValueSet-VaccineCodesCvxMvx.html"
      }],
      "reference" : {
        "reference" : "ValueSet/VaccineCodesCvxMvx"
      },
      "name" : "Vaccine Codes (CVX and MVX)",
      "description" : "Every code from CVX (vaccine administered) and MVX (manufacturer), the two CDC code systems a vaccine dose is recorded with.",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "ValueSet"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "ValueSet-vaccine-condition-codes-snomed.html"
      }],
      "reference" : {
        "reference" : "ValueSet/vaccine-condition-codes-snomed"
      },
      "name" : "Vaccine Condition Codes",
      "description" : "Value set for conditions based on SNOMED CT, that may impact immunization.",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "ValueSet"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "ValueSet-vaccine-condition-codes-icd10.html"
      }],
      "reference" : {
        "reference" : "ValueSet/vaccine-condition-codes-icd10"
      },
      "name" : "Vaccine Condition Codes (ICD-10-CM)",
      "description" : "Value set for conditions based on ICD-10-CM that may impact immunization decisions, mapped to CDSi observation codes.",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "ValueSet"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "ValueSet-vaccine-gender.html"
      }],
      "reference" : {
        "reference" : "ValueSet/vaccine-gender"
      },
      "name" : "Vaccine Gender",
      "description" : "Value set for gender categories relevant to vaccination data.",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "CodeSystem"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "CodeSystem-VaccineGender.html"
      }],
      "reference" : {
        "reference" : "CodeSystem/VaccineGender"
      },
      "name" : "Vaccine Gender",
      "description" : "Value set for gender categories relevant to vaccination data.",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "StructureDefinition:extension"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "StructureDefinition-vaccine-recommendation-category-ext.html"
      }],
      "reference" : {
        "reference" : "StructureDefinition/vaccine-recommendation-category-ext"
      },
      "name" : "Vaccine Recommendation Category",
      "description" : "CDC's vaccine recommendation category for one Best Patient Series in this forecast: Routine, High-Risk, or SCDM (shared clinical decision making), determined per CDC's Vaccine Recommendation Category Determination (CDSi supporting data 4.65) once the forecast is known, for a series whose status is Not Complete. Carries the series name, the category, and CDC's material for it. One extension per contributing series that has a category.",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "CodeSystem"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "CodeSystem-vaccine-recommendation-category.html"
      }],
      "reference" : {
        "reference" : "CodeSystem/vaccine-recommendation-category"
      },
      "name" : "Vaccine Recommendation Category",
      "description" : "The three categories of CDC's Vaccine Recommendation Category Determination (CDSi supporting data 4.65): the type of recommendation a Best Patient Series carries for a patient who is recommended further doses. Displays are CDC's own words.",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "ValueSet"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "ValueSet-vaccine-recommendation-category-vs.html"
      }],
      "reference" : {
        "reference" : "ValueSet/vaccine-recommendation-category-vs"
      },
      "name" : "Vaccine Recommendation Category Value Set",
      "description" : "All codes from the Vaccine Recommendation Category code system.",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "StructureDefinition:extension"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "StructureDefinition-vaccine-type.html"
      }],
      "reference" : {
        "reference" : "StructureDefinition/vaccine-type"
      },
      "name" : "Vaccine Type",
      "description" : "Type of the vaccine.",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "ValueSet"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "ValueSet-valid-age-reason.html"
      }],
      "reference" : {
        "reference" : "ValueSet/valid-age-reason"
      },
      "name" : "Valid Age Reason",
      "description" : "Value set for reasons why a patient's age is considered valid/invalid for a vaccine.",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "CodeSystem"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "CodeSystem-ValidAgeReason.html"
      }],
      "reference" : {
        "reference" : "CodeSystem/ValidAgeReason"
      },
      "name" : "Valid Age Reason",
      "description" : "Value set for reasons why a patient's age is considered valid/invalid for a vaccine.",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "StructureMap"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "StructureMap-MapVaccineCodes.html"
      }],
      "reference" : {
        "reference" : "StructureMap/MapVaccineCodes"
      },
      "name" : "MapVaccineCodes",
      "description" : "Define the usage of FHIR resource types with specific aliases"
    }],
    "page" : {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-page-name",
        "valueUrl" : "toc.html"
      }],
      "nameUrl" : "toc.html",
      "title" : "Table of Contents",
      "generation" : "html",
      "page" : [{
        "extension" : [{
          "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-page-name",
          "valueUrl" : "index.html"
        }],
        "nameUrl" : "index.html",
        "title" : "Cicada IG Home",
        "generation" : "markdown"
      },
      {
        "extension" : [{
          "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-page-name",
          "valueUrl" : "01_preparation.html"
        }],
        "nameUrl" : "01_preparation.html",
        "title" : "Preparation",
        "generation" : "markdown"
      },
      {
        "extension" : [{
          "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-page-name",
          "valueUrl" : "02_logical-specification-concepts.html"
        }],
        "nameUrl" : "02_logical-specification-concepts.html",
        "title" : "Logical Specification Concepts",
        "generation" : "markdown"
      },
      {
        "extension" : [{
          "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-page-name",
          "valueUrl" : "03_processing-model.html"
        }],
        "nameUrl" : "03_processing-model.html",
        "title" : "Processing Model",
        "generation" : "markdown"
      },
      {
        "extension" : [{
          "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-page-name",
          "valueUrl" : "04_evaluate-vaccine-dose-administered.html"
        }],
        "nameUrl" : "04_evaluate-vaccine-dose-administered.html",
        "title" : "Evaluate Vaccine Dose Administered",
        "generation" : "markdown"
      },
      {
        "extension" : [{
          "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-page-name",
          "valueUrl" : "05_forecast-dates-and-reasons.html"
        }],
        "nameUrl" : "05_forecast-dates-and-reasons.html",
        "title" : "Forecast Dates and Reasons",
        "generation" : "markdown"
      },
      {
        "extension" : [{
          "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-page-name",
          "valueUrl" : "06_select-patient-series.html"
        }],
        "nameUrl" : "06_select-patient-series.html",
        "title" : "Select Patient Series",
        "generation" : "markdown"
      },
      {
        "extension" : [{
          "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-page-name",
          "valueUrl" : "07_response-extensions.html"
        }],
        "nameUrl" : "07_response-extensions.html",
        "title" : "What Cicada Returns",
        "generation" : "markdown"
      }]
    },
    "parameter" : [{
      "code" : "path-resource",
      "value" : "input/capabilities"
    },
    {
      "code" : "path-resource",
      "value" : "input/examples"
    },
    {
      "code" : "path-resource",
      "value" : "input/extensions"
    },
    {
      "code" : "path-resource",
      "value" : "input/models"
    },
    {
      "code" : "path-resource",
      "value" : "input/operations"
    },
    {
      "code" : "path-resource",
      "value" : "input/profiles"
    },
    {
      "code" : "path-resource",
      "value" : "input/resources"
    },
    {
      "code" : "path-resource",
      "value" : "input/vocabulary"
    },
    {
      "code" : "path-resource",
      "value" : "input/maps"
    },
    {
      "code" : "path-resource",
      "value" : "input/testing"
    },
    {
      "code" : "path-resource",
      "value" : "input/history"
    },
    {
      "code" : "path-resource",
      "value" : "fsh-generated/resources"
    },
    {
      "code" : "path-pages",
      "value" : "template/config"
    },
    {
      "code" : "path-pages",
      "value" : "input/images"
    },
    {
      "code" : "path-tx-cache",
      "value" : "input-cache/txcache"
    }]
  }
}

```
