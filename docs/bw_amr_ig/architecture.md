---
id: bw_amr_ig_architecture
title: Architecture
---

# Resource Architecture

## FHIR Resource Hierarchy

AMR culture results are modeled as a tree rooted at DiagnosticReport:

```
DiagnosticReport (BotswanaAMRDiagnosticReport)
├── encounter → Encounter (BotswanaAMREncounter)
│     ├── class: ward type (inpatient/outpatient/ICU/emergency)
│     ├── period.start: admission date
│     └── serviceProvider → Organization (facility)
├── specimen → Specimen (BotswanaAMRSpecimen)
├── result[gramStain] → GramStainObservation
└── result[organism] → OrganismObservation (1..*)
      ├── valueCodeableConcept: identified organism (SNOMED CT)
      ├── identifier: isolate number
      └── hasMember → SusceptibilityObservation (0..*)
      │     ├── code: antibiotic (LOINC panel code)
      │     ├── interpretation: S / I / R
      │     ├── valueQuantity: MIC (ug/mL) or zone diameter (mm)
      │     └── method: AST method (disk diffusion, MIC, Etest, automated)
      └── hasMember → SpecialTestObservation (0..*)
            └── ESBL, carbapenemase, MRSA, D-zone, beta-lactamase
```

Each OrganismObservation represents one isolate. Susceptibility results are linked as `hasMember` references, keeping antibiotic results grouped per organism. This pattern aligns with the [German MII Microbiology Module](https://samply.github.io/bbmri-fhir-ig/).

## Design Decisions

**hasMember grouping (not derivedFrom)**
Susceptibility results are children of their organism via `OrganismObservation.hasMember`, not via `SusceptibilityObservation.derivedFrom`. This keeps the parent→child direction consistent with how labs think about results and avoids orphaned susceptibility observations when querying.

**Triple category coding**
All observation profiles include both `laboratory` (HL7 ObservationCategory) and `Microbiology studies (set)` (LOINC 18725-2) category slices, following the MII pattern for discoverability.

**Encounter for GLASS classification**
Ward type and admission date live on a dedicated Encounter profile rather than extensions on DiagnosticReport. This matches the FHIR workflow pattern and allows the same encounter to be referenced by multiple reports.

**Intensional organism ValueSet**
The organism ValueSet uses `include codes from system SCT where concept is-a #410607006 "Organism"` rather than listing individual codes. This keeps the ValueSet current as SNOMED CT is updated. Local codes for organism combinations (e.g., "Acinetobacter baumannii complex") are maintained in `BotswanaAMRLocalOrganismCS`.

## Terminology Strategy

| Domain | CodeSystem | Example |
|--------|-----------|---------|
| Observation codes | LOINC | `634-6` (Bacteria identified), `58321-0` (Susceptibility panel) |
| Organisms | SNOMED CT | `112283007` (E. coli), `56415008` (K. pneumoniae) |
| Antibiotic substances | SNOMED CT | Via LOINC-SNOMED CT Ontology component relationships |
| GLASS antibiotics | ATC (WHO) | `J01CA04` (Amoxicillin), `J01DD04` (Ceftriaxone) |
| S/I/R | HL7 ObservationInterpretation | `S`, `I`, `R`, `SDD`, `NS` |
| Local codes | BotswanaAMRLocalOrganismCS | Organism combinations not in SNOMED |

### ConceptMaps

Four ConceptMaps bridge WHONET codes to standard terminologies:

- **whonet-organism-to-snomed** — 4,995 organism mappings
- **whonet-antibiotic-to-loinc** — 271 antibiotic-to-LOINC susceptibility codes
- **whonet-antibiotic-to-atc** — 374 antibiotic-to-ATC codes
- **whonet-antibiotic-to-snomed** — 213 authoritative substance mappings (from LOINC-SNOMED CT Ontology)
