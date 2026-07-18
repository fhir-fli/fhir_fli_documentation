---
title: FHIR‑Path Demo
---

This playground is a Flutter web build of a small app that runs the same FHIRPath implementation documented on this site: the model-independent [`fhir_path`](https://pub.dev/packages/fhir_path) engine via its R4 binding, [`fhir_r4_path`](https://pub.dev/packages/fhir_r4_path). Under the hood it creates a `FHIRPathEngine`, parses your expression, and evaluates it with `evaluateWithContext` against the resource you provide.

How to use it:

- **Context Resource** (left): paste any FHIR R4 resource as JSON. It is used as the evaluation context, `%resource`, and `%rootResource`. The pre-loaded example is a `QuestionnaireResponse`.
- **FHIRPath Expression** (right): type an expression and press **Evaluate** (or hit Enter). The pre-loaded expression walks the questionnaire answers with `descendants()`.
- **Results**: shown as a JSON list — primitive results as values, complex results as JSON objects. Errors (bad JSON, invalid expressions) are shown in place of results.

Credit to [fhirpath.js](https://hl7.github.io/fhirpath.js/), whose demo inspired this one.

Here's the live FHIRPath playground [link for full screen](https://fhir-fli.github.io/fhir_fli_documentation/fhir_path_demo/):

<iframe
  src="fhir_path_demo/index.html"
  sandbox="allow-scripts allow-same-origin"
  style="width: 100%; height: 800px; border: none;">
</iframe>
