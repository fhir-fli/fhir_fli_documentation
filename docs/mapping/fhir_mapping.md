---
id: fhir_mapping
title: FHIR Mapping Package
---

# Introduction to FHIR Mapping in FHIR-FLI

## Installation

```yaml
dependencies:
  fhir_r4_mapping: ^0.4.0
  fhir_r4: ^0.4.2
  fhir_r4_path: ^0.4.3
```

## What is FHIR Mapping?

FHIR Mapping is a standardized approach to transforming data between different formats or structures within the FHIR ecosystem. At its core, FHIR Mapping uses a specialized language and the StructureMap resource to define how data should be transformed from one structure to another.

This capability is essential for interoperability, allowing systems to translate between:
- Different FHIR versions
- Different implementation guides
- FHIR and external data formats
- Various business requirements in healthcare systems

## The FHIR Mapping Language

The FHIR Mapping Language (sometimes called FHIRMap or FHIR Map) is a domain-specific language designed for expressing transformations. It has a syntax that describes:

- Source and target structures
- Rules for transformation
- Conditions and predicates
- Value manipulation and creation

```
map "http://example.org/map/PatientToPersonMap" = PatientToPerson

uses "http://hl7.org/fhir/StructureDefinition/Patient" as source
uses "http://hl7.org/fhir/StructureDefinition/Person" as target

group PatientToPerson(source src : Patient, target tgt : Person) {
  src.name -> tgt.name;
  src.gender -> tgt.gender;
  src.birthDate -> tgt.birthDate;
}
```

## The FHIR-FLI Implementation

FHIR-FLI provides a comprehensive implementation of FHIR Mapping with two key components:

1. **The StructureMap Parser** - Converts the FHIR mapping language text into a formal StructureMap FHIR resource
2. **The Mapping Engine** - Executes the transformations defined in a StructureMap against source data

Our implementation brings several advantages:

- **Type Safety** - Leverages Dart's strong typing for safer transformations
- **Performance** - Optimized for mobile and web environments
- **Integration** - Seamlessly works with the rest of the FHIR-FLI ecosystem
- **Flexibility** - Supports complex transformation patterns

## Key Concepts

Understanding a few key concepts will help you work effectively with FHIR Mapping in FHIR-FLI:

### StructureMap

A FHIR resource that formally defines mapping rules between different structures. It is typically authored using the FHIR mapping language and then parsed into a StructureMap resource.

### Resource Cache

A hierarchical system for managing canonical resources needed during mapping operations. It allows the mapping engine to resolve references to structure definitions, value sets, and other resources.

### Builders

Special mutable versions of FHIR resources that facilitate incremental construction during mapping.

### Transformation Context

The environment in which a mapping operation executes, keeping track of resources generated during mapping and other state information.

## When to Use FHIR Mapping

FHIR Mapping is particularly useful when:

- You need to transform data between different FHIR versions or profiles
- You're integrating with legacy systems that don't use FHIR natively
- You need to customize data flows between different parts of your application
- You're implementing complex validation or business rules during data transformation

## Next Steps

The following pages will dive deeper into:

1. [Using the StructureMap Parser](fhirmap_parsing.md) - How to convert mapping language text to StructureMap resources
2. [Working with the Mapping Engine](fhir_mapping_engine.md) - How to execute mappings and transform data

By the end of these guides, you'll have a solid understanding of how to use FHIR Mapping in your Dart applications with FHIR-FLI.