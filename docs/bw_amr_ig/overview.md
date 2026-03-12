---
id: bw_amr_ig_overview
title: Overview
---

# Botswana AMR Implementation Guide

The Botswana AMR Implementation Guide defines FHIR R4 profiles and terminology for antimicrobial resistance surveillance as part of the **Botswana AMR Data Analytics Platform** — a collaboration between the University of Botswana and Children's Hospital of Philadelphia.

## The Problem

Antimicrobial Resistance (AMR) now causes more deaths than HIV/AIDS and malaria worldwide and is estimated to be the number-5 leading cause of death in Botswana. Approximately 1 in 10 patients admitted to a hospital in Botswana will experience a health-associated infection.

## What This IG Does

The IG standardizes AMR culture and susceptibility data using FHIR, enabling:

- **Electronic surveillance** — structured data capture replaces paper-based reporting
- **WHONET compatibility** — a `$export-whonet` operation generates flat files for WHONET import
- **GLASS reporting** — ward type, admission date, and facility data support WHO Global AMR Surveillance System submissions
- **Interoperability** — standard FHIR profiles allow integration with national health information systems and the National Data Warehouse

## Profiles

| Profile | Purpose |
|---------|---------|
| **DiagnosticReport** | Bundles a complete culture result: gram stain, organism identifications, and susceptibility panels |
| **Encounter** | Ward type, admission date, and facility — required for GLASS origin classification |
| **OrganismObservation** | Identified organism per isolate, links to susceptibility and special test results via `hasMember` |
| **SusceptibilityObservation** | S/I/R interpretation with optional MIC or zone diameter per antibiotic |
| **SpecialTestObservation** | ESBL, carbapenemase, MRSA, D-zone, and beta-lactamase detection |
| **GramStainObservation** | Gram stain morphology result |
| **Specimen** | Specimen type, collection date, body site |
| **Patient** | Demographics with Omang (national ID) support |

## Technology Stack

- **IG authoring**: FSH (FHIR Shorthand) compiled with SUSHI
- **Data capture**: Flutter/Dart mobile application using [fhir_r4](../core/fhir_r4)
- **Server**: Any FHIR R4 server (designed to work with [FHIR ANT](../fhirant/fhirant_overview) for mobile-first deployments)
- **WHONET export**: Server-side `$export-whonet` FHIR operation

## Source Code

- **IG repository**: [github.com/Dokotela/bw-amr-ig](https://github.com/Dokotela/bw-amr-ig)
