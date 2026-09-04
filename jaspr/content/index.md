---
title: FHIR for Dart and Flutter
description: Open-source Dart libraries for FHIR R4, R5 and R6 — resource models, REST, SMART on FHIR, FHIRPath, CQL, mapping, validation and an encrypted local database.
---

<div class="button-row not-content">
  <a class="primary" href="docs/">Get started</a>
  <a href="https://pub.dev/publishers/fhirfli.dev/packages">Packages on pub.dev</a>
  <a href="https://github.com/fhir-fli">GitHub</a>
</div>

Every package ships for **FHIR R4, R5 and R6** with identical APIs — swap the
package name and nothing else changes. The resource models are generated from
the HL7 specifications, so they follow the standard element for element.

```yaml
dependencies:
  fhir_r4: ^0.12.0
```

## Packages

<div class="card-grid not-content">
  <a class="card" href="docs/core/fhir_r4"><h3><code>fhir_r4</code> Core</h3><p>Every FHIR resource and data type as an immutable Dart class, with JSON serialization, validated primitives and typed enums.</p></a>
  <a class="card" href="docs/at_rest/fhir_r4_at_rest"><h3><code>fhir_r4_at_rest</code> REST</h3><p>Type-safe request builders for the FHIR RESTful API: read, search, create, update, delete, history, batch and transaction, without hand-building URLs and headers.</p></a>
  <a class="card" href="docs/auth/fhir_r4_auth"><h3><code>fhir_r4_auth</code> Auth</h3><p>SMART App Launch: standalone, EHR and backend-services launch with PKCE, secure token storage and JWT validation.</p></a>
  <a class="card" href="docs/fhir_r4_db"><h3><code>fhir_r4_db</code> Database</h3><p>Local SQLite storage built on Drift: type-safe CRUD, FHIR search-parameter indexing, versioning and sync tracking.</p></a>
  <a class="card" href="docs/fhir_r4_path"><h3><code>fhir_r4_path</code> FHIRPath</h3><p>The model-independent <code>fhir_path</code> engine bound to R4: parse once, evaluate against any resource.</p></a>
  <a class="card" href="docs/fhir_r4_cql"><h3><code>fhir_r4_cql</code> CQL</h3><p>The FHIR R4 binding for the <code>cql</code> engine: translate Clinical Quality Language to ELM and execute it against patient data.</p></a>
  <a class="card" href="docs/mapping/fhir_mapping"><h3><code>fhir_r4_mapping</code> Mapping</h3><p>FHIR Mapping Language parser and StructureMap engine for transforming between models.</p></a>
  <a class="card" href="docs/fhir_r4_bulk"><h3><code>fhir_r4_bulk</code> Bulk Data</h3><p>NDJSON file handling and the standard Bulk Data <code>$export</code> and <code>$import</code> operations for large datasets.</p></a>
  <a class="card" href="docs/fhir_r4_validation"><h3><code>fhir_r4_validation</code> Validation</h3><p>Validate resources against their StructureDefinitions: structure, cardinality, bindings, extensions and invariants.</p></a>
  <a class="card" href="docs/ucum"><h3><code>ucum</code> Units</h3><p>Unified Code for Units of Measure: unit validation, conversion, comparison and arithmetic. A port of the reference Ucum-java.</p></a>
</div>

## Applications

<div class="card-grid not-content">
  <a class="card" href="docs/fhirant/fhirant_overview"><h3>FHIR ANT <span class="tag">server</span></h3><p>A complete FHIR R4 server that runs on your Android phone, built on <code>fhir_r4</code>, for testing, demonstrations and low-resource settings.</p></a>
  <a class="card" href="docs/cicada/cicada_overview"><h3>Cicada <span class="tag">engine</span></h3><p>Immunization forecasting that evaluates past doses and recommends the next ones, implementing the CDC CDSi specification and WHO EPI schedules.</p></a>
  <a class="card" href="docs/drosophila/drosophila_overview"><h3>Drosophila <span class="tag">app</span></h3><p>Clinical trial matching for oncology via SMART on FHIR and CDS Hooks: extracts EHR data and compares it with ClinicalTrials.gov eligibility criteria.</p></a>
  <a class="card" href="docs/bumblebee/bumblebee_overview"><h3>Bumblebee <span class="tag">IG</span></h3><p>A clinical record for emergency medical teams in disaster response, offline on a cheap phone. Planning stage: the design record and its FHIR R4 implementation guide are published here.</p></a>
  <a class="card" href="docs/bw_amr_ig/bw_amr_ig_overview"><h3>Botswana AMR <span class="tag">IG</span></h3><p>FHIR R4 profiles and terminology for antimicrobial resistance surveillance in Botswana, with WHONET export and GLASS reporting support.</p></a>
</div>

## Try it in the browser

<div class="card-grid not-content">
  <a class="card" href="docs/demos/fhir_path_demo"><h3>FHIRPath playground</h3><p>Paste a resource, type an expression, see the result — running the same engine documented here.</p></a>
  <a class="card" href="docs/demos/fhir_mapping_demo"><h3>FHIR Mapping playground</h3><p>Write a map in the FHIR Mapping Language and transform a source resource live.</p></a>
  <a class="card" href="docs/cicada/cicada_demo"><h3>Cicada forecast demo</h3><p>Enter a vaccine history or pick a sample patient and see the CDC schedule forecast.</p></a>
</div>
