---
id: fhir_r4
title: Core Package
---

## fhir_r4

The core package that provides FHIR R4 resource models. The main purpose of this package is to create the base classes on which the rest of FHIR-FLI depends. These classes are all generated from structure definitions so they should be in line with the official FHIR specification. This library is mainly used for serialization/deserialization, but it does have some other functionality which is useful in certain situations.

Under the hood, every resource and data type extends `FhirBase`, which implements the `FhirNode` reflection contract from [`package:fhir_node`](https://pub.dev/packages/fhir_node). Because navigation (`getChildrenByName`, `listChildrenNames`, `fhirType`, ...) is expressed through that contract, the model-independent [`fhir_path`](https://pub.dev/packages/fhir_path), [`cql`](https://pub.dev/packages/cql), and [`ucum`](https://pub.dev/packages/ucum) engines can operate on R4 data without any coupling to a specific FHIR version. The same engines power the R5 and R6 packages unchanged.

### Installation

```yaml
dependencies:
  fhir_r4: ^0.6.1
```
