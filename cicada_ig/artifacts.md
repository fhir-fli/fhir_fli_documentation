# Artifacts Summary - The Cicada Vaccine Forecasting Engine and Guide v0.1.0

* [**Table of Contents**](toc.md)
* **Artifacts Summary**

## Artifacts Summary

This page provides a list of the FHIR artifacts defined as part of this implementation guide.

### Structures: Resource Profiles 

These define constraints on FHIR resources for systems conforming to this implementation guide.

| | |
| :--- | :--- |
| [Allergy Intolerance Profile for Immunization Decision Support](StructureDefinition-ReactionProfile.md) | Profile for allergy intolerances relevant to immunization. The code (allergen/substance) may use SNOMED CT or ICD-10-CM. Reaction substances may use CVX, MVX, SNOMED CT, or RxNorm. |
| [Cicada Immunization Recommendation](StructureDefinition-cicada-immunization-recommendation.md) | The forecast cicada returns. Constrains ImmunizationRecommendation to say which series group each recommendation belongs to, so that more than one recommendation for a single vaccine group can be told apart. |
| [Condition Profile with Vaccine Condition Codes](StructureDefinition-VaccineConditionFhir.md) | Profile for conditions where the code must be from the Vaccine Condition Codes value set. Accepts SNOMED CT and ICD-10-CM coded conditions. |
| [Dose of a Vaccine](StructureDefinition-vax-dose.md) | Detailed information about each vaccination dose. |
| [Immunization Procedures Profile](StructureDefinition-ProcedureProfile.md) | Profile for medical procedures related to immunization based on SNOMED CT or CPT codes. |
| [Medication Administration Profile with Vaccine Codes](StructureDefinition-MedicationAdministrationProfile.md) | Profile for medication administrations with vaccine codes from CVX or MVX. |
| [Medication Dispense Profile with Vaccine Codes](StructureDefinition-MedicationDispenseProfile.md) | Profile for medication dispenses with vaccine codes from CVX or MVX. |
| [Medication Request Profile with Vaccine Codes](StructureDefinition-MedicationRequestProfile.md) | Profile for medication requests with vaccine codes from CVX or MVX. |
| [Medication Statement Profile with Vaccine Codes](StructureDefinition-MedicationStatementProfile.md) | Profile for medication statements with vaccine codes from CVX or MVX. |
| [Observation Profile for Immunization Decision Support](StructureDefinition-VaccineObservationFhir.md) | Profile for Observation resources carrying lab evidence of immunity or other findings relevant to immunization decisions. Codes may be from SNOMED CT, ICD-10-CM, or LOINC. |
| [Vaccination Patient](StructureDefinition-vax-patient.md) | A profile that extends the base FHIR Patient resource to include detailed vaccination-related information. |
| [Vaccine](StructureDefinition-Vaccine.md) | Simple vaccine to easily obtain needed information for forecasting |

### Structures: Extension Definitions 

These define constraints on FHIR data types for systems conforming to this implementation guide.

| | |
| :--- | :--- |
| [Allowed Interval Reason](StructureDefinition-allowed-interval-reason.md) | Captures the reason for the allowed interval between vaccine doses. |
| [Allowed Interval Status](StructureDefinition-allowed-interval-status.md) | Captures the status of the allowed interval for vaccination. |
| [Allowed Vaccine Reason](StructureDefinition-allowed-vaccine-reason.md) | Captures the reason why a particular vaccine is allowed. |
| [Allowed Vaccine Status](StructureDefinition-allowed-vaccine-status.md) | Indicates if the vaccine administered is allowed under certain conditions. |
| [Antigen Needing a Dose](StructureDefinition-antigen-needing-dose-ext.md) | An antigen within this vaccine group that needs the forecast dose. A multi-antigen group forecasts as one recommendation, so without this a caller cannot tell whether all of MMR is due or only the measles component. Repeats, one per antigen. |
| [AssessmentDate](StructureDefinition-assessment-date.md) | The date on which the vaccination assessment was made. |
| [Begin Age](StructureDefinition-begin-age.md) | The age at which the vaccine becomes applicable. |
| [Contributing Series Detail](StructureDefinition-series-detail-ext.md) | One contributing series: its own status, its own four dates, and the component dates that produced them. A vaccine group forecast reports the aggregate over several series, so without this a group covered by more than one reports a single answer for all of them, and a due date arrives with no way to see whether age or interval produced it. Repeats, one per series. |
| [Doses Remaining](StructureDefinition-doses-remaining-ext.md) | How many doses remain in the series after the one being forecast, or 'Recurring' where the series ends in a recurring dose. seriesDoses and doseNumber allow a reader to subtract, but no arithmetic says the series never ends. |
| [End Age](StructureDefinition-end-age.md) | The age at which the vaccine is no longer applicable. |
| [Engine and Supporting Data Version](StructureDefinition-engine-version-ext.md) | The engine build and the CDSi supporting-data release that produced this resource. A forecast is a function of both, so a stored response naming neither cannot be traced to what produced it. Parameters is not a DomainResource and carries no extension, so the stamp sits on each evaluation and on each recommendation. |
| [Evaluation Sub-step Detail](StructureDefinition-evaluation-detail-ext.md) | The CDSi Chapter 6 sub-step outcomes behind a dose's evaluation: which of age, interval, conflict and vaccine choice passed, and for those that failed, which rule failed. doseStatusReason carries ten ImmDS codes; the engine knows more than that. |
| [Inadvertent Administration Status](StructureDefinition-inadvertent-administration-status.md) | Indicates if the vaccine was administered inadvertently. |
| [Preferred Interval Reason](StructureDefinition-preferred-interval-reason.md) | Captures the reason for the preferred interval between vaccine doses. |
| [Preferred Interval Status](StructureDefinition-preferred-interval-status.md) | Indicates if the vaccine was administered at the preferred interval. |
| [Preferred Vaccine Reason](StructureDefinition-preferred-vaccine-reason.md) | Captures the reason why a particular vaccine is preferred. |
| [Preferred Vaccine Status](StructureDefinition-preferred-vaccine-status.md) | Indicates if the vaccine administered is the preferred vaccine. |
| [Series Group](StructureDefinition-series-group-ext.md) | The series group this forecast is scoped to, per CDSi FORECASTVG-1. recommendation.series names the series; core FHIR has nowhere for the group. |
| [Series Type](StructureDefinition-series-type-ext.md) | Whether this recommendation came from the standard series group or a risk series group. Present so a client receiving two recommendations for one vaccine group can tell which pathway each describes. |
| [Target Dose Status](StructureDefinition-target-dose-status-ext.md) | The CDSi target dose status this administered dose produced. |
| [Vaccination Conflict](StructureDefinition-vaccination-conflict.md) | Indicates any conflicts with other vaccinations. |
| [Vaccine Type](StructureDefinition-vaccine-type.md) | Type of the vaccine. |
| [Valid Age Reason](StructureDefinition-valid-age-reason.md) | Captures the reason why the vaccine was administered at a particular age. |
| [Valid Age Status](StructureDefinition-valid-age-status.md) | Indicates if the vaccine was administered at the correct age. |

### Terminology: Value Sets 

These define sets of codes used by systems conforming to this implementation guide.

| | |
| :--- | :--- |
| [Cicada Data Integrity Value Set](ValueSet-data-integrity-vs.md) | Reasons a dose was reported rather than evaluated. |
| [Cicada Forecast Reason Value Set](ValueSet-forecast-reason-vs.md) | Forecast reasons the engine can report. |
| [Dose Status Reason Value Set](ValueSet-dose-status-reason.md) | Value set for dose evaluation status reasons, referencing the published ImmDS IG StatusReason CodeSystem. |
| [Evaluation Reason](ValueSet-eval-reason.md) | The reason for the evaluation. |
| [Evaluation Status Value Set](ValueSet-eval-status.md) | Combined value set for dose evaluation status, including HL7 THO standard codes (valid, notvalid) and the Cicada extension code (extraneous). |
| [Forecast Status Value Set](ValueSet-forecast-status.md) | Combined value set for immunization forecast status, referencing published standard CodeSystems. Includes ImmDS IG ForecastStatus (CDSi-compatible), HL7 THO immunization-recommendation-status, and LOINC answer list LL940-8. |
| [Immunization-Relevant Medications (RxNorm)](ValueSet-vaccine-medication-codes-rxnorm.md) | RxNorm codes for medications relevant to immunization decision support, including antivirals and aspirin. |
| [Immunization-Relevant Procedures (CPT)](ValueSet-immunization-procedures-cpt.md) | CPT codes for procedures relevant to immunization decision support, including splenectomy and cochlear implant. |
| [Interval Reason](ValueSet-interval-reason.md) | This value set includes codes for the reason an interval is considered to be invalid. |
| [Lab Evidence of Immunity (LOINC)](ValueSet-vaccine-lab-evidence-of-immunity-loinc.md) | LOINC codes for laboratory tests that provide evidence of immunity, mapped to CDSi observation codes for immunization decision support. |
| [Medications](ValueSet-vaccine-medication-codes-snomed.md) | Value set for medications and substances based on SNOMED CT, including both active ingredients and marketed products. |
| [Procedures](ValueSet-procedures.md) | Comprehensive Value Set for medical procedures based on SNOMED CT codes. |
| [Reasons why certain doses are Preferred or Allowed doses](ValueSet-preferred-allowed-reason.md) | Reasons why certain doses are Preferred or Allowed doses |
| [Series Type Value Set](ValueSet-series-type-vs.md) | Series types a forecast can be scoped to. In practice a forecast carries standard or risk: CDSi Table 8-14 excludes Evaluation Only series from best patient series. |
| [Target Dose Status Value Set](ValueSet-target-dose-status-vs.md) | CDSi target dose statuses. |
| [Vaccine Condition Codes](ValueSet-vaccine-condition-codes-snomed.md) | Value set for conditions based on SNOMED CT, that may impact immunization. |
| [Vaccine Condition Codes (ICD-10-CM)](ValueSet-vaccine-condition-codes-icd10.md) | Value set for conditions based on ICD-10-CM that may impact immunization decisions, mapped to CDSi observation codes. |
| [Vaccine Gender](ValueSet-vaccine-gender.md) | Value set for gender categories relevant to vaccination data. |
| [VaccineCodesCvxMvx](ValueSet-VaccineCodesCvxMvx.md) |  |
| [Valid Age Reason](ValueSet-valid-age-reason.md) | Value set for reasons why a patient's age is considered valid/invalid for a vaccine. |

### Terminology: Code Systems 

These define new code systems used by systems conforming to this implementation guide.

| | |
| :--- | :--- |
| [CDSI Observation Codes](CodeSystem-cdsi-observation-codes.md) | Observations and Conditions that are important to indications or contraindications in vaccine forecasting |
| [Cicada Data Integrity Code System](CodeSystem-data-integrity.md) | Records that cannot describe an administration. CDSi evaluates a vaccine dose administered and defines the assessment date as the current date, so these doses are excluded from evaluation and forecasting and reported in an OperationOutcome. They are statements about the data, never about the patient's immunity, which is why they are not evaluation statuses. |
| [Cicada Evaluation Status](CodeSystem-EvalStatus.md) | Extension codes for dose evaluation status beyond the HL7 THO immunization-evaluation-dose-status CodeSystem. Only codes not covered by the standard are defined here. |
| [Cicada Forecast Reason Code System](CodeSystem-forecast-reason.md) | Why the engine forecast what it did. The ImmDS ForecastReason code system covers four of these; the rest have no ImmDS concept, and the ImmDS binding on ImmunizationRecommendation.recommendation.forecastReason is example strength, so they travel as a second coding rather than being dropped. |
| [Evaluation Reason](CodeSystem-EvalReason.md) | The reason for the evaluation. |
| [Interval Reason](CodeSystem-IntervalReason.md) | This value set includes codes for the reason an interval is considered to be invalid. |
| [Reasons why certain doses are Preferred or Allowed doses](CodeSystem-PreferredAllowedReason.md) | Reasons why certain doses are Preferred or Allowed doses |
| [Series Type Code System](CodeSystem-series-type.md) | CDSi series type: whether a patient series is the routine schedule, one indicated by a risk condition, or evaluation-only. Mirrors the seriesType attribute of the CDSi antigen supporting data. |
| [Target Dose Status Code System](CodeSystem-target-dose-status.md) | CDSi Table 3-2. The status of the target dose an administered dose was evaluated against. R4 ImmunizationEvaluation carries only doseNumber, derived from this, so a skipped target dose and a satisfied one are otherwise indistinguishable. |
| [Vaccine Gender](CodeSystem-VaccineGender.md) | Value set for gender categories relevant to vaccination data. |
| [Valid Age Reason](CodeSystem-ValidAgeReason.md) | Value set for reasons why a patient's age is considered valid/invalid for a vaccine. |

### Terminology: Structure Maps 

These define transformations to convert between data structures used by systems conforming to this implementation guide.

| | |
| :--- | :--- |
| [MapVaccineCodes](StructureMap-MapVaccineCodes.md) | Define the usage of FHIR resource types with specific aliases |

### Terminology: Concept Maps 

These define transformations to convert between codes by systems conforming with this implementation guide.

| | |
| :--- | :--- |
| [ICD-10-CM to CDSi Observation Code Map](ConceptMap-Icd10ToCdsiObservation.md) | Maps ICD-10-CM diagnosis codes to CDSi observation codes used in immunization decision support. |
| [SNOMED CT to CDSi Observation Code Map](ConceptMap-SnomedToCdsiObservation.md) | Maps SNOMED CT codes to CDSi observation codes used in immunization decision support. |

### Other 

These are resources that are used within this implementation guide that do not fit into one of the other categories.

| | |
| :--- | :--- |
| [2016-UC-0032](Patient-2016-UC-0032.md) |  |
| [Antigen Supporting Data](StructureDefinition-antigen-supporting-data.md) | A resource to store supporting data for antigens including target disease, vaccine groups, immunity criteria, contraindications, and vaccination series. |
| [Schedule Supporting Data](StructureDefinition-schedule-supporting-data.md) | This resource consolidates various mapping and conflict information related to vaccine scheduling to support decision-making processes. |
| [cicada-forecast-example](ImmunizationRecommendation-cicada-forecast-example.md) |  |

