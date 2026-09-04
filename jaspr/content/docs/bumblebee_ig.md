---
id: bumblebee_ig
title: Bumblebee Implementation Guide
---

The Bumblebee IG defines the FHIR R4 clinical record for an emergency medical
team working offline in a disaster: what a clinician records to take care of a
patient, and what software must be able to hold, show and pass on.

The IG covers:

- **32 profiles** across the whole of a visit — patient and accompanying person,
  the visit itself, triage as repeated assessments, diagnosis and standing
  problems, notifiable disease, observations from pain to burn surface area,
  medicines given, dispensed and already taken, allergies and whether anyone
  asked, procedures, referral and handover, follow-up, return advice, the
  documents that travel with the patient, consent, the team and the site
- **8 extensions** for the concepts FHIR has no home for — estimated age when a
  date of birth is unobtainable, relation to the disaster, treatment level,
  administrative division, anticipated departure date, the deployment tag,
  exposure history, and mass-casualty mode
- **3 code systems and 4 value sets**, including a hierarchical body-region list
  so a clinician can tap a diagram at the precision they actually have
- **Narrative pages** carrying the design rationale, the graded evidence the
  design rests on, the relationship to published national guides, and what is
  still open

[Open full screen](https://fhir-fli.github.io/fhir_fli_documentation/bumblebee_ig/index.html)

<iframe
  src="bumblebee_ig/index.html"
  sandbox="allow-scripts allow-same-origin"
  style="width: 100%; height: 800px; border: none;">
</iframe>
