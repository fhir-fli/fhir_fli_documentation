---
id: bw_amr_ig_ig
title: Implementation Guide
---

# Botswana AMR Implementation Guide

The Botswana AMR IG defines FHIR R4 profiles, value sets, code systems, concept maps, and operations for antimicrobial resistance surveillance in Botswana. It covers the full AMR culture workflow from specimen collection through organism identification, susceptibility testing, and WHONET/GLASS export.

The IG covers:
- **8 Profiles** for DiagnosticReport, Encounter, Patient, Specimen, and four Observation types (GramStain, Organism, Susceptibility, SpecialTest)
- **11 ValueSets** for organisms (SNOMED CT), antibiotics (LOINC), specimen types, AST methods, ward types, and interpretation codes
- **2 CodeSystems** for Botswana-specific organism combinations and identification methods
- **4 ConceptMaps** bridging WHONET codes to SNOMED CT, LOINC, and ATC
- **1 Operation** (`$export-whonet`) for generating WHONET/GLASS flat files

[Open full screen](https://fhir-fli.github.io/fhir_fli_documentation/bw_amr_ig/index.html)

<iframe
  src="/fhir_fli_documentation/bw_amr_ig/index.html"
  sandbox="allow-scripts allow-same-origin"
  style={{
    width: '100%',
    height: '800px',
    border: 'none'
  }}
/>
