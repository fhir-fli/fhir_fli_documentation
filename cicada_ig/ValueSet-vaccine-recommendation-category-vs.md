# Vaccine Recommendation Category Value Set - The Cicada Vaccine Forecasting Engine and Guide v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Vaccine Recommendation Category Value Set**

## ValueSet: Vaccine Recommendation Category Value Set 

| | |
| :--- | :--- |
| *Official URL*:http://fhirfli.dev/fhir/ig/cicada/ValueSet/vaccine-recommendation-category-vs | *Version*:0.1.0 |
| Draft as of 2026-09-06 | *Computable Name*:VaccineRecommendationCategoryVS |

 
All codes from the Vaccine Recommendation Category code system. 

 **References** 

* [Vaccine Recommendation Category](StructureDefinition-vaccine-recommendation-category-ext.md)

### Logical Definition (CLD)

 

### Expansion

-------

 Explanation of the columns that may appear on this page: 

| | |
| :--- | :--- |
| Level | A few code lists that FHIR defines are hierarchical - each code is assigned a level. In this scheme, some codes are under other codes, and imply that the code they are under also applies |
| System | The source of the definition of the code (when the value set draws in codes defined elsewhere) |
| Code | The code (used as the code in the resource instance) |
| Display | The display (used in the*display*element of a[Coding](http://hl7.org/fhir/R4/datatypes.html#Coding)). If there is no display, implementers should not simply display the code, but map the concept into their application |
| Definition | An explanation of the meaning of the concept |
| Comments | Additional notes about how to use the code |



## Resource Content

```json
{
  "resourceType" : "ValueSet",
  "id" : "vaccine-recommendation-category-vs",
  "url" : "http://fhirfli.dev/fhir/ig/cicada/ValueSet/vaccine-recommendation-category-vs",
  "version" : "0.1.0",
  "name" : "VaccineRecommendationCategoryVS",
  "title" : "Vaccine Recommendation Category Value Set",
  "status" : "draft",
  "date" : "2026-09-06T23:13:14-04:00",
  "publisher" : "FHIR-FLI",
  "contact" : [{
    "name" : "FHIR-FLI",
    "telecom" : [{
      "system" : "url",
      "value" : "http://fhirfli.dev"
    }]
  }],
  "description" : "All codes from the Vaccine Recommendation Category code system.",
  "compose" : {
    "include" : [{
      "system" : "http://fhirfli.dev/fhir/ig/cicada/CodeSystem/vaccine-recommendation-category"
    }]
  }
}

```
