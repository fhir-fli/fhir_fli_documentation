# AllergyIntolerance: adverse reaction to a vaccine - The Cicada Vaccine Forecasting Engine and Guide v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **AllergyIntolerance: adverse reaction to a vaccine**

## Example AllergyIntolerance: AllergyIntolerance: adverse reaction to a vaccine

Profile: [Allergy Intolerance Profile for Immunization Decision Support](StructureDefinition-ReactionProfile.md)

**clinicalStatus**: Active

**code**: Vaccine adverse reaction

**patient**: [MMR: Patient is a healthcare worker, born before 1957, has received one dose of the MMR vaccine. Female, DoB: 1955-08-12](Patient-2016-UC-0032.md)

### Reactions

| | | | |
| :--- | :--- | :--- | :--- |
| - | **Substance** | **Manifestation** | **Severity** |
| * | Hep B, adolescent or pediatric | Anaphylaxis | Severe |



## Resource Content

```json
{
  "resourceType" : "AllergyIntolerance",
  "id" : "allergy-vaccine-reaction",
  "meta" : {
    "profile" : ["http://fhirfli.dev/fhir/ig/cicada/StructureDefinition/ReactionProfile"]
  },
  "clinicalStatus" : {
    "coding" : [{
      "system" : "http://terminology.hl7.org/CodeSystem/allergyintolerance-clinical",
      "code" : "active"
    }]
  },
  "code" : {
    "coding" : [{
      "system" : "http://snomed.info/sct",
      "code" : "293104008"
    }]
  },
  "patient" : {
    "reference" : "Patient/2016-UC-0032"
  },
  "reaction" : [{
    "substance" : {
      "coding" : [{
        "system" : "http://hl7.org/fhir/sid/cvx",
        "code" : "08",
        "display" : "Hep B, adolescent or pediatric"
      }]
    },
    "manifestation" : [{
      "coding" : [{
        "system" : "http://snomed.info/sct",
        "code" : "39579001",
        "display" : "Anaphylaxis"
      }]
    }],
    "severity" : "severe"
  }]
}

```
