# Series Type Value Set - The Cicada Vaccine Forecasting Engine and Guide v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Series Type Value Set**

## ValueSet: Series Type Value Set 

| | |
| :--- | :--- |
| *Official URL*:http://fhirfli.dev/fhir/ig/cicada/ValueSet/series-type-vs | *Version*:0.1.0 |
| Draft as of 2026-09-02 | *Computable Name*:SeriesTypeVS |

 
Series types a forecast can be scoped to. In practice a forecast carries standard or risk: CDSi Table 8-14 excludes Evaluation Only series from best patient series. 

 **References** 

* [Series Type](StructureDefinition-series-type-ext.md)

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
  "id" : "series-type-vs",
  "url" : "http://fhirfli.dev/fhir/ig/cicada/ValueSet/series-type-vs",
  "version" : "0.1.0",
  "name" : "SeriesTypeVS",
  "title" : "Series Type Value Set",
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
  "description" : "Series types a forecast can be scoped to. In practice a forecast carries standard or risk: CDSi Table 8-14 excludes Evaluation Only series from best patient series.",
  "compose" : {
    "include" : [
      {
        "system" : "http://fhirfli.dev/fhir/ig/cicada/CodeSystem/series-type"
      }
    ]
  }
}

```
