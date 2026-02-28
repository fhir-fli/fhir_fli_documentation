---
id: getting-started
title: Getting Started
slug: /
---

# Getting Started with FHIR-FLI <img src="/fhir_fli_documentation/img/fhir-fli-logo.png" alt="FHIR-FLI Logo" style={{width: "150px", verticalAlign: "middle"}} />

Welcome to the Getting Started guide for FHIR-FLI. This guide will walk you through setting up and using the FHIR-FLI Dart libraries in your projects.

## What is FHIR-FLI?

FHIR-FLI (<b>F</b>ast <b>H</b>ealthcare <b>I</b>nteroperability <b>R</b>esources - with <b>F</b>lutter <b>L</b>ibrary <b>I</b>ntegration) is a set of Dart libraries that enable Flutter developers to easily work with [FHIR](docs/core/fhir_r4) data. These libraries provide common functionality that is needed for working with FHIR, including serialization/deserialization, making [RESTful](docs/at_rest/fhir_r4_at_rest) requests, [SMART on FHIR authentication](docs/auth), [local secure storage](docs/fhir_r4_db), [FHIRPath](docs/fhir_r4_path), [FHIR Bulk Data](docs/fhir_r4_bulk), [FHIR Mapping](docs/mapping/fhir_mapping), [CQL](docs/fhir_r4_cql), and [resource validation](docs/fhir_r4_validation).

## FHIR Version Support

All packages are available for **FHIR R4, R5, and R6**. The APIs are identical across versions - just swap the package name:

| Package | R4 | R5 | R6 |
|---------|----|----|-----|
| Core types | `fhir_r4` | `fhir_r5` | `fhir_r6` |
| REST client | `fhir_r4_at_rest` | `fhir_r5_at_rest` | `fhir_r6_at_rest` |
| Auth (SMART) | `fhir_r4_auth` | `fhir_r5_auth` | `fhir_r6_auth` |
| Bulk data | `fhir_r4_bulk` | `fhir_r5_bulk` | `fhir_r6_bulk` |
| CQL | `fhir_r4_cql` | `fhir_r5_cql` | `fhir_r6_cql` |
| Database | `fhir_r4_db` | `fhir_r5_db` | `fhir_r6_db` |
| Mapping | `fhir_r4_mapping` | `fhir_r5_mapping` | `fhir_r6_mapping` |
| FHIRPath | `fhir_r4_path` | `fhir_r5_path` | `fhir_r6_path` |
| Validation | `fhir_r4_validation` | `fhir_r5_validation` | `fhir_r6_validation` |

The documentation focuses on R4 examples, but all code works identically with R5 and R6 by changing the import.

## Here are the official HL7 references for the above functionality
- [FHIR](https://www.hl7.org/fhir/overview.html)
- [FHIR RESTful API](https://www.hl7.org/fhir/http.html)
- [SMART App Launch](http://hl7.org/fhir/smart-app-launch/)
- [FHIRPath](https://hl7.org/fhirpath/N1/)
- [FHIR Bulk Data](https://build.fhir.org/ig/HL7/bulk-data/)
- [FHIR Mapping](https://build.fhir.org/mapping-language.html)
- [Clinical Quality Language (CQL)](https://cql.hl7.org/)
