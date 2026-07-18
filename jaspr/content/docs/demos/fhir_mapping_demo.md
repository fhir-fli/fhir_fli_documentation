---
title: FHIR Mapping Demo
---

This playground is a Flutter web build of a small app that runs the same FHIR Mapping Language implementation documented on this site: [`fhir_r4_mapping`](https://pub.dev/packages/fhir_r4_mapping). Under the hood it parses your map text with `StructureMapParser`, then executes it with `FhirMapEngine.transformFromFhir` against the source resource you provide — entirely in the browser, no server round-trip.

How to use it:

- **StructureMap (FHIR Mapping Language)** (top left): write or paste a map in [FHIR Mapping Language](https://hl7.org/fhir/mapping-language.html) syntax. The pre-loaded example extracts a `Patient` from a completed `QuestionnaireResponse`.
- **Source Resource** (bottom left): paste the FHIR R4 resource the map's `source` group parameter expects, as JSON.
- **Transform** (right): runs the map. The **Output Resource** panel shows the transform result as JSON; parse or transform errors are shown in its place.
- **View parsed StructureMap**: after a transform, shows the `StructureMap` resource the FML text was parsed into.

Maps that only move data between standard FHIR R4 resources (like the example) run fully self-contained. Maps that reference custom logical models need their `StructureDefinition`s to be resolvable.

Inspired by the [fhirpath-lab mapper](https://fhirpath-lab.com/FhirMapper2) and the [matchbox](https://github.com/ahdis/matchbox) transform tooling.

Here's the live FHIR Mapping playground [link for full screen](https://fhir-fli.github.io/fhir_fli_documentation/fhir_mapping_demo/):

<iframe
  src="fhir_mapping_demo/index.html"
  sandbox="allow-scripts allow-same-origin"
  style="width: 100%; height: 800px; border: none;">
</iframe>
