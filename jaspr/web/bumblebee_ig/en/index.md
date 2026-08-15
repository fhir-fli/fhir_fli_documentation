# Home - Bumblebee — a clinical record for emergency medical teams v0.1.0

## Home

### Bumblebee

**A clinical record for emergency medical teams.** It exists to help a volunteer clinician take care of a patient in a disaster — offline, on a cheap phone, with a queue of people waiting.

This guide is the machine-readable half of that design. It says which fields a record carries, which of them software has to handle, and what may go in them, so that a tool finds the mistakes rather than a reader.

### The setting these profiles are built for

A team lands in a disaster zone. It has volunteers who last used this software 12–18 months ago, with as little as three hours of pre-deployment training; no internet, intermittent power, and cheap Android phones; a patient every few minutes, sometimes many at once; a duty to give each patient something they can carry to the next clinician; and a duty to do all of that without creating a record that could endanger the patient if the device is lost or seized.

Two measurements from the response to Cyclone Idai in Mozambique in 2019 — 13 teams over 110 days, the largest set of numbers we have from a real deployment — govern what these profiles optimise for:

* **Of 13,738 health events, 56.5% had no more specific description than "other".** Major head and spine, torso and extremity injuries together were **0.5%** — 66 patients out of 13,738.
* **84.7% of health events had nothing to do with the disaster**, and the share rose from 68.7% to 94.5% over the response, because a team in the acute phase substitutes for health facilities that are not working.

So the clinical surface has to be excellent at **ordinary illness seen once in a tent**. Disaster trauma is the rare case, and a record shaped around it would be shaped around 0.5% of the work.

### Who reads and writes this record

| | |
| :--- | :--- |
| **Field clinician**— physician, PA/NP, nurse, paramedic. The primary user | Document a visit in under a minute of screen time, see what the last person did, and hand the patient something |
| **Triage and intake staff** | Register a person who may have no name and no document, record a category, and get them moving |
| **Team lead / medical director** | A live census, without asking anyone to count anything |
| **The receiving clinician**, days or months later | Read the record cold, without the team that wrote it, and without a network |
| **The patient** | A record of what happened to them that they can take to the next clinic |

The primary user is not a technologist and is not a full-time user of anything. Design decisions are settled in their favour.

### What this guide covers

The **clinical record**: one contact between a patient and a team, from walking up to walking away, and the standing facts about a person that outlive any one visit.

**32 profiles · 8 extensions · 4 value sets · 3 code systems**, all on FHIR R4 (4.0.1).

* [What the record holds](record.md) — the profiles, grouped by the moment of care they belong to
* [How to read the profiles](conventions.md) — the conventions, including what Must Support does and does not mean here
* [Terminology and extensions](terminology.md) — the code lists we define, and the six concepts FHIR has no home for
* [Design rationale](rationale.md) — what was decided, what was rejected, and where it came from
* [Evidence basis](evidence.md) — what the design is built on, and how the sources are graded
* [Other guides](relationship.md) — where we match published profiles, where we deliberately differ
* [Open questions](open.md) — what is not settled, and who can settle it

### What this guide does not cover

* **The application.** Screens, interaction and the queue are specified elsewhere in the project's design record, not here.
* **Storage, synchronisation and security.** Offline operation, replication between devices, purge and the handling of records that could endanger a patient are architectural, and this guide neither describes nor constrains them.
* **Examples.** There are none yet. A profile with no instance is how you ship something nobody can satisfy, and writing them is the next piece of work on this guide.

### Status

**Draft, version 0.1.0.** The project is at the planning stage: the profiles are proposed, not agreed, and several rest on decisions marked as taken provisionally for a partner to confirm. Every page here says which.

Nothing in this guide has been used to record the care of a real patient.

### Reading the citations

Claims on these pages cite the project's own design record — `DECISIONS.md` for what was decided, `EVIDENCE.md` for the graded source library, `PRINCIPLES.md` for the falsifiable commitments. Those files are not published alongside this guide. Where a claim rests on a published standard or a paper, the standard or the paper is named as well, so the claim can be checked without them.

