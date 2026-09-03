# cicada-forecast-example - The Cicada Vaccine Forecasting Engine and Guide v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **cicada-forecast-example**

## ImmunizationRecommendation: cicada-forecast-example

Profile: [Cicada Immunization Recommendation](StructureDefinition-cicada-immunization-recommendation.md)

**patient**: [MMR: Patient is a healthcare worker, born before 1957, has received one dose of the MMR vaccine. Female, DoB: 1955-08-12](Patient-2016-UC-0032.md)

**date**: 2015-04-30 00:00:00-0400

> **recommendation****Series Type**: Risk**vaccineCode**: MMR**targetDisease**: MMR**forecastStatus**: Not Complete
> **dateCriterion****code**: Earliest date to give**value**: 2015-05-28 00:00:00-0400

> **dateCriterion****code**: Date vaccine due**value**: 2015-05-28 00:00:00-0400

> **dateCriterion****code**: Date when overdue for immunization**value**: 2015-05-28 00:00:00-0400
**description**: Antigens: Mumps, Measles, Rubella**doseNumber**: 2**supportingPatientInformation**: Health care personnel

> **recommendation****Series Type**: Standard**vaccineCode**: MMR**targetDisease**: MMR**forecastStatus**: Complete**description**: Antigens: Mumps, Measles, Rubella

> **recommendation****Series Type**: Standard**vaccineCode**: DTaP, unspecified formulation**targetDisease**: DTaP/Tdap/Td**forecastStatus**: Not Complete
> **dateCriterion****code**: Earliest date to give**value**: 1962-08-12 00:00:00-0400

> **dateCriterion****code**: Date vaccine due**value**: 1962-08-12 00:00:00-0400

> **dateCriterion****code**: Date when overdue for immunization**value**: 1962-08-12 00:00:00-0400
**description**: Antigens: Pertussis, Tetanus, Diphtheria**doseNumber**: 1

> **recommendation****Series Type**: Standard**vaccineCode**: influenza, unspecified formulation**targetDisease**: Influenza**forecastStatus**: Not Complete
> **dateCriterion****code**: Earliest date to give**value**: 2025-07-01 00:00:00-0400

> **dateCriterion****code**: Date vaccine due**value**: 2025-07-01 00:00:00-0400

> **dateCriterion****code**: Date when overdue for immunization**value**: 2025-07-01 00:00:00-0400
**series**: Influenza standard series**doseNumber**: 1

> **recommendation****Series Type**: Standard**vaccineCode**: Hib, unspecified formulation**targetDisease**: Hib**forecastStatus**: Aged Out

> **recommendation****Series Type**: Standard**vaccineCode**: Pneumococcal Conjugate, unspecified formulation**targetDisease**: Pneumococcal**forecastStatus**: Not Complete
> **dateCriterion****code**: Earliest date to give**value**: 2005-08-12 00:00:00-0400

> **dateCriterion****code**: Date vaccine due**value**: 2005-08-12 00:00:00-0400

> **dateCriterion****code**: Date when overdue for immunization**value**: 2005-08-12 00:00:00-0400
**series**: Pneumococcal 50+ 1-dose PCV series**doseNumber**: 1

> **recommendation****Series Type**: Standard**vaccineCode**: varicella**targetDisease**: Varicella**forecastStatus**: Not Complete
> **dateCriterion****code**: Earliest date to give**value**: 2015-05-28 00:00:00-0400

> **dateCriterion****code**: Date vaccine due**value**: 2015-05-28 00:00:00-0400

> **dateCriterion****code**: Date when overdue for immunization**value**: 2015-05-28 00:00:00-0400
**series**: Varicella childhood 2-dose series**doseNumber**: 1

> **recommendation****Series Type**: Standard**vaccineCode**: Hep B, unspecified formulation**targetDisease**: HepB**forecastStatus**: Not Complete
> **dateCriterion****code**: Earliest date to give**value**: 1955-08-12 00:00:00-0400

> **dateCriterion****code**: Date vaccine due**value**: 1955-08-12 00:00:00-0400

> **dateCriterion****code**: Date when overdue for immunization**value**: 1955-09-08 00:00:00-0400
**series**: HepB 3-dose series**doseNumber**: 1

> **recommendation****Series Type**: Standard**vaccineCode**: meningococcal, unspecified formulation**targetDisease**: Meningococcal**forecastStatus**: Aged Out

> **recommendation****Series Type**: Standard**vaccineCode**: SARS-COV-2 (COVID-19) vaccine, unspecified**targetDisease**: COVID-19**forecastStatus**: Not Complete
> **dateCriterion****code**: Earliest date to give**value**: 2025-08-27 00:00:00-0400

> **dateCriterion****code**: Date vaccine due**value**: 2025-08-27 00:00:00-0400

> **dateCriterion****code**: Date when overdue for immunization**value**: 2025-08-27 00:00:00-0400
**series**: COVID-19 start at 6mo-23mo shared clinical decision-making series**doseNumber**: 1

> **recommendation****Series Type**: Standard**vaccineCode**: polio, unspecified formulation**targetDisease**: Polio**forecastStatus**: Aged Out

> **recommendation****Series Type**: Standard**vaccineCode**: zoster, unspecified formulation**targetDisease**: Zoster**forecastStatus**: Not Complete
> **dateCriterion****code**: Earliest date to give**value**: 2005-08-12 00:00:00-0400

> **dateCriterion****code**: Date vaccine due**value**: 2005-08-12 00:00:00-0400

> **dateCriterion****code**: Date when overdue for immunization**value**: 2005-08-12 00:00:00-0400
**series**: Zoster 2-dose series**doseNumber**: 1

> **recommendation****Series Type**: Standard**vaccineCode**: Hep A, unspecified formulation**targetDisease**: HepA**forecastStatus**: Aged Out

> **recommendation****Series Type**: Standard**vaccineCode**: RSV, unspecified**targetDisease**: RSV**forecastStatus**: Not Complete
> **dateCriterion****code**: Earliest date to give**value**: 2030-08-12 00:00:00-0400

> **dateCriterion****code**: Date vaccine due**value**: 2030-08-12 00:00:00-0400

> **dateCriterion****code**: Date when overdue for immunization**value**: 2030-08-12 00:00:00-0400
**series**: RSV 75 years+ 1-dose series**doseNumber**: 1

> **recommendation****Series Type**: Standard**vaccineCode**: HPV, unspecified formulation**targetDisease**: HPV**forecastStatus**: Aged Out

> **recommendation****Series Type**: Standard**vaccineCode**: meningococcal B, unspecified**targetDisease**: Meningococcal B**forecastStatus**: Aged Out

> **recommendation****Series Type**: Standard**vaccineCode**: rotavirus, unspecified formulation**targetDisease**: Rotavirus**forecastStatus**: Aged Out



## Resource Content

```json
{
  "resourceType" : "ImmunizationRecommendation",
  "id" : "cicada-forecast-example",
  "meta" : {
    "profile" : [
      "http://fhirfli.dev/fhir/ig/cicada/StructureDefinition/cicada-immunization-recommendation"
    ]
  },
  "patient" : {
    "reference" : "Patient/2016-UC-0032"
  },
  "date" : "2015-04-30T00:00:00.000-04:00",
  "recommendation" : [
    {
      "extension" : [
        {
          "url" : "http://fhirfli.dev/fhir/ig/cicada/StructureDefinition/series-type-ext",
          "valueCodeableConcept" : {
            "coding" : [
              {
                "system" : "http://fhirfli.dev/fhir/ig/cicada/CodeSystem/series-type",
                "code" : "risk",
                "display" : "Risk"
              }
            ]
          }
        }
      ],
      "vaccineCode" : [
        {
          "coding" : [
            {
              "system" : "http://hl7.org/fhir/sid/cvx",
              "code" : "03",
              "display" : "MMR"
            }
          ]
        }
      ],
      "targetDisease" : {
        "coding" : [
          {
            "system" : "http://snomed.info/sct",
            "code" : "36989005",
            "display" : "Mumps"
          },
          {
            "system" : "http://snomed.info/sct",
            "code" : "14189004",
            "display" : "Measles"
          },
          {
            "system" : "http://snomed.info/sct",
            "code" : "36653000",
            "display" : "Rubella"
          }
        ],
        "text" : "MMR"
      },
      "forecastStatus" : {
        "coding" : [
          {
            "system" : "http://hl7.org/fhir/us/immds/CodeSystem/ForecastStatus",
            "code" : "Not Complete",
            "display" : "Not Complete"
          },
          {
            "system" : "http://terminology.hl7.org/CodeSystem/immunization-recommendation-status",
            "code" : "due",
            "display" : "Due"
          },
          {
            "system" : "http://loinc.org",
            "code" : "LA13422-3",
            "display" : "On schedule"
          }
        ]
      },
      "dateCriterion" : [
        {
          "code" : {
            "coding" : [
              {
                "system" : "http://loinc.org",
                "code" : "30981-5",
                "display" : "Earliest date to give"
              }
            ]
          },
          "value" : "2015-05-28T00:00:00.000-04:00"
        },
        {
          "code" : {
            "coding" : [
              {
                "system" : "http://loinc.org",
                "code" : "30980-7",
                "display" : "Date vaccine due"
              }
            ]
          },
          "value" : "2015-05-28T00:00:00.000-04:00"
        },
        {
          "code" : {
            "coding" : [
              {
                "system" : "http://loinc.org",
                "code" : "59778-1",
                "display" : "Date when overdue for immunization"
              }
            ]
          },
          "value" : "2015-05-28T00:00:00.000-04:00"
        }
      ],
      "description" : "Antigens: Mumps, Measles, Rubella",
      "doseNumberString" : "2",
      "supportingPatientInformation" : [
        {
          "display" : "Health care personnel"
        }
      ]
    },
    {
      "extension" : [
        {
          "url" : "http://fhirfli.dev/fhir/ig/cicada/StructureDefinition/series-type-ext",
          "valueCodeableConcept" : {
            "coding" : [
              {
                "system" : "http://fhirfli.dev/fhir/ig/cicada/CodeSystem/series-type",
                "code" : "standard",
                "display" : "Standard"
              }
            ]
          }
        }
      ],
      "vaccineCode" : [
        {
          "coding" : [
            {
              "system" : "http://hl7.org/fhir/sid/cvx",
              "code" : "03",
              "display" : "MMR"
            }
          ]
        }
      ],
      "targetDisease" : {
        "coding" : [
          {
            "system" : "http://snomed.info/sct",
            "code" : "36989005",
            "display" : "Mumps"
          },
          {
            "system" : "http://snomed.info/sct",
            "code" : "14189004",
            "display" : "Measles"
          },
          {
            "system" : "http://snomed.info/sct",
            "code" : "36653000",
            "display" : "Rubella"
          }
        ],
        "text" : "MMR"
      },
      "forecastStatus" : {
        "coding" : [
          {
            "system" : "http://hl7.org/fhir/us/immds/CodeSystem/ForecastStatus",
            "code" : "Complete",
            "display" : "Complete"
          },
          {
            "system" : "http://terminology.hl7.org/CodeSystem/immunization-recommendation-status",
            "code" : "complete",
            "display" : "Complete"
          },
          {
            "system" : "http://loinc.org",
            "code" : "LA13421-5",
            "display" : "Complete"
          }
        ]
      },
      "description" : "Antigens: Mumps, Measles, Rubella"
    },
    {
      "extension" : [
        {
          "url" : "http://fhirfli.dev/fhir/ig/cicada/StructureDefinition/series-type-ext",
          "valueCodeableConcept" : {
            "coding" : [
              {
                "system" : "http://fhirfli.dev/fhir/ig/cicada/CodeSystem/series-type",
                "code" : "standard",
                "display" : "Standard"
              }
            ]
          }
        }
      ],
      "vaccineCode" : [
        {
          "coding" : [
            {
              "system" : "http://hl7.org/fhir/sid/cvx",
              "code" : "107",
              "display" : "DTaP, unspecified formulation"
            }
          ]
        }
      ],
      "targetDisease" : {
        "coding" : [
          {
            "system" : "http://snomed.info/sct",
            "code" : "27836007",
            "display" : "Pertussis"
          },
          {
            "system" : "http://snomed.info/sct",
            "code" : "76902006",
            "display" : "Tetanus"
          },
          {
            "system" : "http://snomed.info/sct",
            "code" : "397430003",
            "display" : "Diphtheria"
          }
        ],
        "text" : "DTaP/Tdap/Td"
      },
      "forecastStatus" : {
        "coding" : [
          {
            "system" : "http://hl7.org/fhir/us/immds/CodeSystem/ForecastStatus",
            "code" : "Not Complete",
            "display" : "Not Complete"
          },
          {
            "system" : "http://terminology.hl7.org/CodeSystem/immunization-recommendation-status",
            "code" : "overdue",
            "display" : "Overdue"
          },
          {
            "system" : "http://loinc.org",
            "code" : "LA13423-1",
            "display" : "Overdue"
          }
        ]
      },
      "dateCriterion" : [
        {
          "code" : {
            "coding" : [
              {
                "system" : "http://loinc.org",
                "code" : "30981-5",
                "display" : "Earliest date to give"
              }
            ]
          },
          "value" : "1962-08-12T00:00:00.000-04:00"
        },
        {
          "code" : {
            "coding" : [
              {
                "system" : "http://loinc.org",
                "code" : "30980-7",
                "display" : "Date vaccine due"
              }
            ]
          },
          "value" : "1962-08-12T00:00:00.000-04:00"
        },
        {
          "code" : {
            "coding" : [
              {
                "system" : "http://loinc.org",
                "code" : "59778-1",
                "display" : "Date when overdue for immunization"
              }
            ]
          },
          "value" : "1962-08-12T00:00:00.000-04:00"
        }
      ],
      "description" : "Antigens: Pertussis, Tetanus, Diphtheria",
      "doseNumberString" : "1"
    },
    {
      "extension" : [
        {
          "url" : "http://fhirfli.dev/fhir/ig/cicada/StructureDefinition/series-type-ext",
          "valueCodeableConcept" : {
            "coding" : [
              {
                "system" : "http://fhirfli.dev/fhir/ig/cicada/CodeSystem/series-type",
                "code" : "standard",
                "display" : "Standard"
              }
            ]
          }
        }
      ],
      "vaccineCode" : [
        {
          "coding" : [
            {
              "system" : "http://hl7.org/fhir/sid/cvx",
              "code" : "88",
              "display" : "influenza, unspecified formulation"
            }
          ]
        }
      ],
      "targetDisease" : {
        "coding" : [
          {
            "system" : "http://snomed.info/sct",
            "code" : "6142004",
            "display" : "Influenza"
          }
        ],
        "text" : "Influenza"
      },
      "forecastStatus" : {
        "coding" : [
          {
            "system" : "http://hl7.org/fhir/us/immds/CodeSystem/ForecastStatus",
            "code" : "Not Complete",
            "display" : "Not Complete"
          },
          {
            "system" : "http://terminology.hl7.org/CodeSystem/immunization-recommendation-status",
            "code" : "due",
            "display" : "Due"
          },
          {
            "system" : "http://loinc.org",
            "code" : "LA13422-3",
            "display" : "On schedule"
          }
        ]
      },
      "dateCriterion" : [
        {
          "code" : {
            "coding" : [
              {
                "system" : "http://loinc.org",
                "code" : "30981-5",
                "display" : "Earliest date to give"
              }
            ]
          },
          "value" : "2025-07-01T00:00:00.000-04:00"
        },
        {
          "code" : {
            "coding" : [
              {
                "system" : "http://loinc.org",
                "code" : "30980-7",
                "display" : "Date vaccine due"
              }
            ]
          },
          "value" : "2025-07-01T00:00:00.000-04:00"
        },
        {
          "code" : {
            "coding" : [
              {
                "system" : "http://loinc.org",
                "code" : "59778-1",
                "display" : "Date when overdue for immunization"
              }
            ]
          },
          "value" : "2025-07-01T00:00:00.000-04:00"
        }
      ],
      "series" : "Influenza standard series",
      "doseNumberString" : "1"
    },
    {
      "extension" : [
        {
          "url" : "http://fhirfli.dev/fhir/ig/cicada/StructureDefinition/series-type-ext",
          "valueCodeableConcept" : {
            "coding" : [
              {
                "system" : "http://fhirfli.dev/fhir/ig/cicada/CodeSystem/series-type",
                "code" : "standard",
                "display" : "Standard"
              }
            ]
          }
        }
      ],
      "vaccineCode" : [
        {
          "coding" : [
            {
              "system" : "http://hl7.org/fhir/sid/cvx",
              "code" : "17",
              "display" : "Hib, unspecified formulation"
            }
          ]
        }
      ],
      "targetDisease" : {
        "coding" : [
          {
            "system" : "http://snomed.info/sct",
            "code" : "709410003",
            "display" : "Hib"
          }
        ],
        "text" : "Hib"
      },
      "forecastStatus" : {
        "coding" : [
          {
            "system" : "http://hl7.org/fhir/us/immds/CodeSystem/ForecastStatus",
            "code" : "Aged Out",
            "display" : "Aged Out"
          },
          {
            "system" : "http://terminology.hl7.org/CodeSystem/immunization-recommendation-status",
            "code" : "agedout",
            "display" : "Aged Out"
          },
          {
            "system" : "http://loinc.org",
            "code" : "LA13424-9",
            "display" : "Too old"
          }
        ]
      }
    },
    {
      "extension" : [
        {
          "url" : "http://fhirfli.dev/fhir/ig/cicada/StructureDefinition/series-type-ext",
          "valueCodeableConcept" : {
            "coding" : [
              {
                "system" : "http://fhirfli.dev/fhir/ig/cicada/CodeSystem/series-type",
                "code" : "standard",
                "display" : "Standard"
              }
            ]
          }
        }
      ],
      "vaccineCode" : [
        {
          "coding" : [
            {
              "system" : "http://hl7.org/fhir/sid/cvx",
              "code" : "152",
              "display" : "Pneumococcal Conjugate, unspecified formulation"
            }
          ]
        }
      ],
      "targetDisease" : {
        "coding" : [
          {
            "system" : "http://snomed.info/sct",
            "code" : "16814004",
            "display" : "Pneumococcal"
          }
        ],
        "text" : "Pneumococcal"
      },
      "forecastStatus" : {
        "coding" : [
          {
            "system" : "http://hl7.org/fhir/us/immds/CodeSystem/ForecastStatus",
            "code" : "Not Complete",
            "display" : "Not Complete"
          },
          {
            "system" : "http://terminology.hl7.org/CodeSystem/immunization-recommendation-status",
            "code" : "overdue",
            "display" : "Overdue"
          },
          {
            "system" : "http://loinc.org",
            "code" : "LA13423-1",
            "display" : "Overdue"
          }
        ]
      },
      "dateCriterion" : [
        {
          "code" : {
            "coding" : [
              {
                "system" : "http://loinc.org",
                "code" : "30981-5",
                "display" : "Earliest date to give"
              }
            ]
          },
          "value" : "2005-08-12T00:00:00.000-04:00"
        },
        {
          "code" : {
            "coding" : [
              {
                "system" : "http://loinc.org",
                "code" : "30980-7",
                "display" : "Date vaccine due"
              }
            ]
          },
          "value" : "2005-08-12T00:00:00.000-04:00"
        },
        {
          "code" : {
            "coding" : [
              {
                "system" : "http://loinc.org",
                "code" : "59778-1",
                "display" : "Date when overdue for immunization"
              }
            ]
          },
          "value" : "2005-08-12T00:00:00.000-04:00"
        }
      ],
      "series" : "Pneumococcal 50+ 1-dose PCV series",
      "doseNumberString" : "1"
    },
    {
      "extension" : [
        {
          "url" : "http://fhirfli.dev/fhir/ig/cicada/StructureDefinition/series-type-ext",
          "valueCodeableConcept" : {
            "coding" : [
              {
                "system" : "http://fhirfli.dev/fhir/ig/cicada/CodeSystem/series-type",
                "code" : "standard",
                "display" : "Standard"
              }
            ]
          }
        }
      ],
      "vaccineCode" : [
        {
          "coding" : [
            {
              "system" : "http://hl7.org/fhir/sid/cvx",
              "code" : "21",
              "display" : "varicella"
            }
          ]
        }
      ],
      "targetDisease" : {
        "coding" : [
          {
            "system" : "http://snomed.info/sct",
            "code" : "38907003",
            "display" : "Varicella"
          }
        ],
        "text" : "Varicella"
      },
      "forecastStatus" : {
        "coding" : [
          {
            "system" : "http://hl7.org/fhir/us/immds/CodeSystem/ForecastStatus",
            "code" : "Not Complete",
            "display" : "Not Complete"
          },
          {
            "system" : "http://terminology.hl7.org/CodeSystem/immunization-recommendation-status",
            "code" : "due",
            "display" : "Due"
          },
          {
            "system" : "http://loinc.org",
            "code" : "LA13422-3",
            "display" : "On schedule"
          }
        ]
      },
      "dateCriterion" : [
        {
          "code" : {
            "coding" : [
              {
                "system" : "http://loinc.org",
                "code" : "30981-5",
                "display" : "Earliest date to give"
              }
            ]
          },
          "value" : "2015-05-28T00:00:00.000-04:00"
        },
        {
          "code" : {
            "coding" : [
              {
                "system" : "http://loinc.org",
                "code" : "30980-7",
                "display" : "Date vaccine due"
              }
            ]
          },
          "value" : "2015-05-28T00:00:00.000-04:00"
        },
        {
          "code" : {
            "coding" : [
              {
                "system" : "http://loinc.org",
                "code" : "59778-1",
                "display" : "Date when overdue for immunization"
              }
            ]
          },
          "value" : "2015-05-28T00:00:00.000-04:00"
        }
      ],
      "series" : "Varicella childhood 2-dose series",
      "doseNumberString" : "1"
    },
    {
      "extension" : [
        {
          "url" : "http://fhirfli.dev/fhir/ig/cicada/StructureDefinition/series-type-ext",
          "valueCodeableConcept" : {
            "coding" : [
              {
                "system" : "http://fhirfli.dev/fhir/ig/cicada/CodeSystem/series-type",
                "code" : "standard",
                "display" : "Standard"
              }
            ]
          }
        }
      ],
      "vaccineCode" : [
        {
          "coding" : [
            {
              "system" : "http://hl7.org/fhir/sid/cvx",
              "code" : "45",
              "display" : "Hep B, unspecified formulation"
            }
          ]
        }
      ],
      "targetDisease" : {
        "coding" : [
          {
            "system" : "http://snomed.info/sct",
            "code" : "66071002",
            "display" : "HepB"
          }
        ],
        "text" : "HepB"
      },
      "forecastStatus" : {
        "coding" : [
          {
            "system" : "http://hl7.org/fhir/us/immds/CodeSystem/ForecastStatus",
            "code" : "Not Complete",
            "display" : "Not Complete"
          },
          {
            "system" : "http://terminology.hl7.org/CodeSystem/immunization-recommendation-status",
            "code" : "overdue",
            "display" : "Overdue"
          },
          {
            "system" : "http://loinc.org",
            "code" : "LA13423-1",
            "display" : "Overdue"
          }
        ]
      },
      "dateCriterion" : [
        {
          "code" : {
            "coding" : [
              {
                "system" : "http://loinc.org",
                "code" : "30981-5",
                "display" : "Earliest date to give"
              }
            ]
          },
          "value" : "1955-08-12T00:00:00.000-04:00"
        },
        {
          "code" : {
            "coding" : [
              {
                "system" : "http://loinc.org",
                "code" : "30980-7",
                "display" : "Date vaccine due"
              }
            ]
          },
          "value" : "1955-08-12T00:00:00.000-04:00"
        },
        {
          "code" : {
            "coding" : [
              {
                "system" : "http://loinc.org",
                "code" : "59778-1",
                "display" : "Date when overdue for immunization"
              }
            ]
          },
          "value" : "1955-09-08T00:00:00.000-04:00"
        }
      ],
      "series" : "HepB 3-dose series",
      "doseNumberString" : "1"
    },
    {
      "extension" : [
        {
          "url" : "http://fhirfli.dev/fhir/ig/cicada/StructureDefinition/series-type-ext",
          "valueCodeableConcept" : {
            "coding" : [
              {
                "system" : "http://fhirfli.dev/fhir/ig/cicada/CodeSystem/series-type",
                "code" : "standard",
                "display" : "Standard"
              }
            ]
          }
        }
      ],
      "vaccineCode" : [
        {
          "coding" : [
            {
              "system" : "http://hl7.org/fhir/sid/cvx",
              "code" : "108",
              "display" : "meningococcal, unspecified formulation"
            }
          ]
        }
      ],
      "targetDisease" : {
        "coding" : [
          {
            "system" : "http://snomed.info/sct",
            "code" : "23511006",
            "display" : "Meningococcal"
          }
        ],
        "text" : "Meningococcal"
      },
      "forecastStatus" : {
        "coding" : [
          {
            "system" : "http://hl7.org/fhir/us/immds/CodeSystem/ForecastStatus",
            "code" : "Aged Out",
            "display" : "Aged Out"
          },
          {
            "system" : "http://terminology.hl7.org/CodeSystem/immunization-recommendation-status",
            "code" : "agedout",
            "display" : "Aged Out"
          },
          {
            "system" : "http://loinc.org",
            "code" : "LA13424-9",
            "display" : "Too old"
          }
        ]
      }
    },
    {
      "extension" : [
        {
          "url" : "http://fhirfli.dev/fhir/ig/cicada/StructureDefinition/series-type-ext",
          "valueCodeableConcept" : {
            "coding" : [
              {
                "system" : "http://fhirfli.dev/fhir/ig/cicada/CodeSystem/series-type",
                "code" : "standard",
                "display" : "Standard"
              }
            ]
          }
        }
      ],
      "vaccineCode" : [
        {
          "coding" : [
            {
              "system" : "http://hl7.org/fhir/sid/cvx",
              "code" : "213",
              "display" : "SARS-COV-2 (COVID-19) vaccine, unspecified"
            }
          ]
        }
      ],
      "targetDisease" : {
        "coding" : [
          {
            "system" : "http://snomed.info/sct",
            "code" : "840539006",
            "display" : "COVID-19"
          }
        ],
        "text" : "COVID-19"
      },
      "forecastStatus" : {
        "coding" : [
          {
            "system" : "http://hl7.org/fhir/us/immds/CodeSystem/ForecastStatus",
            "code" : "Not Complete",
            "display" : "Not Complete"
          },
          {
            "system" : "http://terminology.hl7.org/CodeSystem/immunization-recommendation-status",
            "code" : "due",
            "display" : "Due"
          },
          {
            "system" : "http://loinc.org",
            "code" : "LA13422-3",
            "display" : "On schedule"
          }
        ]
      },
      "dateCriterion" : [
        {
          "code" : {
            "coding" : [
              {
                "system" : "http://loinc.org",
                "code" : "30981-5",
                "display" : "Earliest date to give"
              }
            ]
          },
          "value" : "2025-08-27T00:00:00.000-04:00"
        },
        {
          "code" : {
            "coding" : [
              {
                "system" : "http://loinc.org",
                "code" : "30980-7",
                "display" : "Date vaccine due"
              }
            ]
          },
          "value" : "2025-08-27T00:00:00.000-04:00"
        },
        {
          "code" : {
            "coding" : [
              {
                "system" : "http://loinc.org",
                "code" : "59778-1",
                "display" : "Date when overdue for immunization"
              }
            ]
          },
          "value" : "2025-08-27T00:00:00.000-04:00"
        }
      ],
      "series" : "COVID-19 start at 6mo-23mo shared clinical decision-making series",
      "doseNumberString" : "1"
    },
    {
      "extension" : [
        {
          "url" : "http://fhirfli.dev/fhir/ig/cicada/StructureDefinition/series-type-ext",
          "valueCodeableConcept" : {
            "coding" : [
              {
                "system" : "http://fhirfli.dev/fhir/ig/cicada/CodeSystem/series-type",
                "code" : "standard",
                "display" : "Standard"
              }
            ]
          }
        }
      ],
      "vaccineCode" : [
        {
          "coding" : [
            {
              "system" : "http://hl7.org/fhir/sid/cvx",
              "code" : "89",
              "display" : "polio, unspecified formulation"
            }
          ]
        }
      ],
      "targetDisease" : {
        "coding" : [
          {
            "system" : "http://snomed.info/sct",
            "code" : "398102009",
            "display" : "Polio"
          }
        ],
        "text" : "Polio"
      },
      "forecastStatus" : {
        "coding" : [
          {
            "system" : "http://hl7.org/fhir/us/immds/CodeSystem/ForecastStatus",
            "code" : "Aged Out",
            "display" : "Aged Out"
          },
          {
            "system" : "http://terminology.hl7.org/CodeSystem/immunization-recommendation-status",
            "code" : "agedout",
            "display" : "Aged Out"
          },
          {
            "system" : "http://loinc.org",
            "code" : "LA13424-9",
            "display" : "Too old"
          }
        ]
      }
    },
    {
      "extension" : [
        {
          "url" : "http://fhirfli.dev/fhir/ig/cicada/StructureDefinition/series-type-ext",
          "valueCodeableConcept" : {
            "coding" : [
              {
                "system" : "http://fhirfli.dev/fhir/ig/cicada/CodeSystem/series-type",
                "code" : "standard",
                "display" : "Standard"
              }
            ]
          }
        }
      ],
      "vaccineCode" : [
        {
          "coding" : [
            {
              "system" : "http://hl7.org/fhir/sid/cvx",
              "code" : "188",
              "display" : "zoster, unspecified formulation"
            }
          ]
        }
      ],
      "targetDisease" : {
        "coding" : [
          {
            "system" : "http://snomed.info/sct",
            "code" : "4740000",
            "display" : "Zoster"
          }
        ],
        "text" : "Zoster"
      },
      "forecastStatus" : {
        "coding" : [
          {
            "system" : "http://hl7.org/fhir/us/immds/CodeSystem/ForecastStatus",
            "code" : "Not Complete",
            "display" : "Not Complete"
          },
          {
            "system" : "http://terminology.hl7.org/CodeSystem/immunization-recommendation-status",
            "code" : "overdue",
            "display" : "Overdue"
          },
          {
            "system" : "http://loinc.org",
            "code" : "LA13423-1",
            "display" : "Overdue"
          }
        ]
      },
      "dateCriterion" : [
        {
          "code" : {
            "coding" : [
              {
                "system" : "http://loinc.org",
                "code" : "30981-5",
                "display" : "Earliest date to give"
              }
            ]
          },
          "value" : "2005-08-12T00:00:00.000-04:00"
        },
        {
          "code" : {
            "coding" : [
              {
                "system" : "http://loinc.org",
                "code" : "30980-7",
                "display" : "Date vaccine due"
              }
            ]
          },
          "value" : "2005-08-12T00:00:00.000-04:00"
        },
        {
          "code" : {
            "coding" : [
              {
                "system" : "http://loinc.org",
                "code" : "59778-1",
                "display" : "Date when overdue for immunization"
              }
            ]
          },
          "value" : "2005-08-12T00:00:00.000-04:00"
        }
      ],
      "series" : "Zoster 2-dose series",
      "doseNumberString" : "1"
    },
    {
      "extension" : [
        {
          "url" : "http://fhirfli.dev/fhir/ig/cicada/StructureDefinition/series-type-ext",
          "valueCodeableConcept" : {
            "coding" : [
              {
                "system" : "http://fhirfli.dev/fhir/ig/cicada/CodeSystem/series-type",
                "code" : "standard",
                "display" : "Standard"
              }
            ]
          }
        }
      ],
      "vaccineCode" : [
        {
          "coding" : [
            {
              "system" : "http://hl7.org/fhir/sid/cvx",
              "code" : "85",
              "display" : "Hep A, unspecified formulation"
            }
          ]
        }
      ],
      "targetDisease" : {
        "coding" : [
          {
            "system" : "http://snomed.info/sct",
            "code" : "40468003",
            "display" : "HepA"
          }
        ],
        "text" : "HepA"
      },
      "forecastStatus" : {
        "coding" : [
          {
            "system" : "http://hl7.org/fhir/us/immds/CodeSystem/ForecastStatus",
            "code" : "Aged Out",
            "display" : "Aged Out"
          },
          {
            "system" : "http://terminology.hl7.org/CodeSystem/immunization-recommendation-status",
            "code" : "agedout",
            "display" : "Aged Out"
          },
          {
            "system" : "http://loinc.org",
            "code" : "LA13424-9",
            "display" : "Too old"
          }
        ]
      }
    },
    {
      "extension" : [
        {
          "url" : "http://fhirfli.dev/fhir/ig/cicada/StructureDefinition/series-type-ext",
          "valueCodeableConcept" : {
            "coding" : [
              {
                "system" : "http://fhirfli.dev/fhir/ig/cicada/CodeSystem/series-type",
                "code" : "standard",
                "display" : "Standard"
              }
            ]
          }
        }
      ],
      "vaccineCode" : [
        {
          "coding" : [
            {
              "system" : "http://hl7.org/fhir/sid/cvx",
              "code" : "304",
              "display" : "RSV, unspecified"
            }
          ]
        }
      ],
      "targetDisease" : {
        "coding" : [
          {
            "system" : "http://snomed.info/sct",
            "code" : "55735004",
            "display" : "RSV"
          }
        ],
        "text" : "RSV"
      },
      "forecastStatus" : {
        "coding" : [
          {
            "system" : "http://hl7.org/fhir/us/immds/CodeSystem/ForecastStatus",
            "code" : "Not Complete",
            "display" : "Not Complete"
          },
          {
            "system" : "http://terminology.hl7.org/CodeSystem/immunization-recommendation-status",
            "code" : "due",
            "display" : "Due"
          },
          {
            "system" : "http://loinc.org",
            "code" : "LA13422-3",
            "display" : "On schedule"
          }
        ]
      },
      "dateCriterion" : [
        {
          "code" : {
            "coding" : [
              {
                "system" : "http://loinc.org",
                "code" : "30981-5",
                "display" : "Earliest date to give"
              }
            ]
          },
          "value" : "2030-08-12T00:00:00.000-04:00"
        },
        {
          "code" : {
            "coding" : [
              {
                "system" : "http://loinc.org",
                "code" : "30980-7",
                "display" : "Date vaccine due"
              }
            ]
          },
          "value" : "2030-08-12T00:00:00.000-04:00"
        },
        {
          "code" : {
            "coding" : [
              {
                "system" : "http://loinc.org",
                "code" : "59778-1",
                "display" : "Date when overdue for immunization"
              }
            ]
          },
          "value" : "2030-08-12T00:00:00.000-04:00"
        }
      ],
      "series" : "RSV 75 years+ 1-dose series",
      "doseNumberString" : "1"
    },
    {
      "extension" : [
        {
          "url" : "http://fhirfli.dev/fhir/ig/cicada/StructureDefinition/series-type-ext",
          "valueCodeableConcept" : {
            "coding" : [
              {
                "system" : "http://fhirfli.dev/fhir/ig/cicada/CodeSystem/series-type",
                "code" : "standard",
                "display" : "Standard"
              }
            ]
          }
        }
      ],
      "vaccineCode" : [
        {
          "coding" : [
            {
              "system" : "http://hl7.org/fhir/sid/cvx",
              "code" : "137",
              "display" : "HPV, unspecified formulation"
            }
          ]
        }
      ],
      "targetDisease" : {
        "coding" : [
          {
            "system" : "http://snomed.info/sct",
            "code" : "240532009",
            "display" : "HPV"
          }
        ],
        "text" : "HPV"
      },
      "forecastStatus" : {
        "coding" : [
          {
            "system" : "http://hl7.org/fhir/us/immds/CodeSystem/ForecastStatus",
            "code" : "Aged Out",
            "display" : "Aged Out"
          },
          {
            "system" : "http://terminology.hl7.org/CodeSystem/immunization-recommendation-status",
            "code" : "agedout",
            "display" : "Aged Out"
          },
          {
            "system" : "http://loinc.org",
            "code" : "LA13424-9",
            "display" : "Too old"
          }
        ]
      }
    },
    {
      "extension" : [
        {
          "url" : "http://fhirfli.dev/fhir/ig/cicada/StructureDefinition/series-type-ext",
          "valueCodeableConcept" : {
            "coding" : [
              {
                "system" : "http://fhirfli.dev/fhir/ig/cicada/CodeSystem/series-type",
                "code" : "standard",
                "display" : "Standard"
              }
            ]
          }
        }
      ],
      "vaccineCode" : [
        {
          "coding" : [
            {
              "system" : "http://hl7.org/fhir/sid/cvx",
              "code" : "164",
              "display" : "meningococcal B, unspecified"
            }
          ]
        }
      ],
      "targetDisease" : {
        "coding" : [
          {
            "system" : "http://snomed.info/sct",
            "code" : "860805006",
            "display" : "Meningococcal B"
          }
        ],
        "text" : "Meningococcal B"
      },
      "forecastStatus" : {
        "coding" : [
          {
            "system" : "http://hl7.org/fhir/us/immds/CodeSystem/ForecastStatus",
            "code" : "Aged Out",
            "display" : "Aged Out"
          },
          {
            "system" : "http://terminology.hl7.org/CodeSystem/immunization-recommendation-status",
            "code" : "agedout",
            "display" : "Aged Out"
          },
          {
            "system" : "http://loinc.org",
            "code" : "LA13424-9",
            "display" : "Too old"
          }
        ]
      }
    },
    {
      "extension" : [
        {
          "url" : "http://fhirfli.dev/fhir/ig/cicada/StructureDefinition/series-type-ext",
          "valueCodeableConcept" : {
            "coding" : [
              {
                "system" : "http://fhirfli.dev/fhir/ig/cicada/CodeSystem/series-type",
                "code" : "standard",
                "display" : "Standard"
              }
            ]
          }
        }
      ],
      "vaccineCode" : [
        {
          "coding" : [
            {
              "system" : "http://hl7.org/fhir/sid/cvx",
              "code" : "122",
              "display" : "rotavirus, unspecified formulation"
            }
          ]
        }
      ],
      "targetDisease" : {
        "coding" : [
          {
            "system" : "http://snomed.info/sct",
            "code" : "18624000",
            "display" : "Rotavirus"
          }
        ],
        "text" : "Rotavirus"
      },
      "forecastStatus" : {
        "coding" : [
          {
            "system" : "http://hl7.org/fhir/us/immds/CodeSystem/ForecastStatus",
            "code" : "Aged Out",
            "display" : "Aged Out"
          },
          {
            "system" : "http://terminology.hl7.org/CodeSystem/immunization-recommendation-status",
            "code" : "agedout",
            "display" : "Aged Out"
          },
          {
            "system" : "http://loinc.org",
            "code" : "LA13424-9",
            "display" : "Too old"
          }
        ]
      }
    }
  ]
}

```
