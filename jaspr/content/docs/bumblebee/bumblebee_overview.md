---
id: bumblebee_overview
title: Bumblebee
---

**A clinical record for emergency medical teams.** It exists to help a volunteer
clinician take care of a patient in a disaster — offline, on a cheap phone, with
a queue of people waiting.

Bumblebee is at the planning stage. No production code exists yet. What does
exist is a design record and the FHIR R4 implementation guide generated from it,
which is published here: [Bumblebee IG](docs/bumblebee_ig).

## What the setting demands

A team lands in a disaster zone with volunteers who last used the software 12–18
months ago and as little as three hours of pre-deployment training, no internet,
intermittent power, cheap Android phones, and a patient every few minutes.

Two measurements from the response to Cyclone Idai in Mozambique in 2019 — 13
teams over 110 days — govern what the record is optimised for:

- Of 13,738 health events, **56.5%** had no more specific description than
  "other". Major head and spine, torso and extremity injuries together were
  **0.5%**.
- **84.7%** of health events had nothing to do with the disaster, rising to
  94.5% by the end of the response, because a team in the acute phase substitutes
  for health facilities that are not working.

So the clinical surface has to be excellent at ordinary illness seen once in a
tent. Disaster trauma is the rare case.

## What is in the guide

**32 profiles · 8 extensions · 4 value sets · 3 code systems**, all on FHIR R4,
covering one contact between a patient and a team — registration, triage,
diagnosis, observations, medicines, procedures, and everything that happens at
the end of a visit — plus the standing facts about a person that outlive any one
visit.

The guide carries its own narrative: what the record holds, how to read the
profiles, the terminology, the design rationale behind each profile, the graded
evidence the design rests on, how it relates to published national guides, and
what is still open.

## Where it sits in the family

Bumblebee builds on the rest of the FHIR-FLI packages — `fhir_r4` and
`fhir_r4_db` for the model and the encrypted local store, `fhirant` as the site
server, `katydid` for questionnaires, and `fhir_path` and `cql` for computable
logic.

## Status

Draft, version 0.1.0. The profiles are proposed rather than agreed, several rest
on decisions taken provisionally for a partner to confirm, and there are no
examples yet. Nothing in the guide has been used to record the care of a real
patient. The project's design record — the decision log, the graded source
library and the review questions — is not published alongside it.
