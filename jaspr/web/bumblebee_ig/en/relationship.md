# Other guides - Bumblebee — a clinical record for emergency medical teams v0.1.0

## Other guides

### Relationship to other guides

**The policy, in Grey's words:** **"we don't HAVE to conform to other IGs, it's just nice when we can and when it makes sense."**

Alignment is free value, taken wherever it costs nothing. Where a published guide and a patient in a tent disagree, the patient wins, and the difference is written down. What this rules out runs in both directions: contorting the design to match somebody's national profile, and ignoring a published profile because we did not write it. Where independently-written guides agree with each other, that agreement is evidence about what implementers actually needed, and it is cheap to take.

### What this guide does conform to

| | |
| :--- | :--- |
| Base | **FHIR R4**(4.0.1) |
| Standing state, and the copy the patient keeps | **IPS**— the International Patient Summary |
| Guide structure and the layering of computable artefacts | **WHO SMART Guidelines**— their base guide and starter kit |
| The visit layer | **ours, on base R4**, patterned on where the national cores agree |

The last row is the one that needed establishing, and the search behind it is named below rather than assumed.

### Why the visit layer is ours

**Searched:** IPA 1.1.0 · IPS · US Core 9.0.0 `Encounter` and `Condition-encounter-diagnosis` · AU Core 2.0.0 `Encounter` · AU Core's own published cross-guide comparison page · the WHO SMART `smart-base-clinical` draft · the base specification's Administration module and the `Encounter` / `EpisodeOfCare` boundaries text.

**International Patient Access does not fit**, and the reason is structural rather than a matter of taste: it **"describes how an application acting on behalf of **a patient** can access information about the patient"**, this version of it is **"read-only"**, and it does not profile `Encounter` or `EpisodeOfCare` at all. Its content set is the standing-state list already taken from IPS.

**The strongest finding is not ours.** AU Core publishes a comparison of itself against other national and international guides, and the only three it finds worth comparing against are IPA, IPS and US Core — one patient-access API, one patient summary, and one national core. A published guide's own survey arrives where we did: the international guides are patient-summary and patient-access shaped, and the practitioner-facing ones are nationally bound.

**WHO's own clinical guide profiles `EpisodeOfCare` and does not profile `Encounter`.** `smart-base-clinical` defines four profiles and carries no encounter guidance. It is a draft on a continuous build rather than an authorised publication, so it is a signal about intent and not a standard to follow — but the group writing for this exact setting thought `EpisodeOfCare` was the piece worth profiling. The successor guide named for clinical encounters returned 404 at both its published and its continuous-build address when this was checked on 2026-08-04, so its current content is unverified.

### How the comparison was made

Each profile was downloaded as its `StructureDefinition` JSON and its element table extracted mechanically — no reading of rendered pages, no summarising. The per-element matrix is `AGREEMENT.tsv` in the project's design record.

| | | |
| :--- | :--- | :--- |
| US Core`Encounter` | 9.0.0 | 2023-10-17 |
| AU Core`Encounter` | 2.0.0 | 2026-01-28 |
| UK Core`Encounter` | 2.5.0 | 2023-12-12 |
| ISiK Kontakt (Germany) | 4.0.3 | 2025-02-19 |
| nl-core`Encounter` | unversioned draft | — |

**nl-core marks nothing Must Support** — zero occurrences in its `StructureDefinition` — so its contribution is its **definition** of an encounter, not an element set, and the counts below are out of four guides rather than five. Germany's general base profile package carries no `Encounter` at all; every `StructureDefinition` in it was searched, and its encounter profiling is in ISiK.

### Where we already match

Four of four guides flag `status`, `class` and `subject`; we have all three, and `subject` at `1..`.

Three of four flag `period`, `reasonCode` and `participant`; we have all three, and we **require** `period` where they do not. Two of four flag `hospitalization.dischargeDisposition`, and we mark it Must Support.

### Where their agreement changed our profile

**`reasonReference`** — three guides mark it Must Support beside `reasonCode`. It carries **she is here about the wound we dressed on Tuesday**, pointing at the `Condition` itself instead of a retyped complaint that only looks like the same words, which is what Decision 22 settled on in place of an episode. It is now Must Support, typed to a diagnosis, a standing problem or an observation, and **left at `0..*` on purpose**: a first visit has nothing to point at.

**`serviceProvider`** — three guides mark it Must Support. It is now Must Support, typed to [the team](StructureDefinition-bumblebee-organization.md), which gained `telecom` and `address` in the same pass. The deployment tag is an `Identifier` and carries none of that; purge is a different job from **who looked after this person**.

### Where we deliberately differ

| | | |
| :--- | :--- | :--- |
| `period 1..1`and`period.start 1..1` | All four leave`period`optional | Arrival time is what distinguishes dead-on-arrival from a death in the facility |
| Triage as an`Observation`, one per decision | No guide read here profiles a triage element on`Encounter`— US Core, AU Core, UK Core, ISiK and nl-core were searched | A triage category is a judgement about how soon to see someone, not something the patient has.`Encounter.priority`is single-valued and there is no`priorityHistory`, so a re-assessment would overwrite the first |
| A deployment tag on every resource | None of the four carries an equivalent, same search | Purge as one verifiable operation |
| A mass-casualty flag on the visit | None of the four carries an equivalent, same search | Whether the visit was triaged under mass-casualty rules changes how the triage value is read back |

### What they carry that we do not, and will not

| | | |
| :--- | :--- | :--- |
| `account` | ISiK | Billing. Germany separates the billing case from both the encounter and the episode deliberately; we have no billing, so the axis is absent |
| `hospitalization.admitSource` | ISiK | Admission machinery. Nearly all of this caseload is never admitted |
| `diagnosis.condition`,`.use`,`.rank` | ISiK | The encounter diagnosis is a separate`Condition`with`category = encounter-diagnosis`and`encounter 1..1`— the shape US Core uses |
| `meta.lastUpdated` | US Core | Server-side revision querying. Nothing about the patient, and these devices are local |

### Where they agree and we still say nothing

`location`, `identifier` and `type` are each flagged by three of four guides and are each absent here — not by oversight, but because each is a question about how a team actually works rather than a modelling question. They are on [the open questions page](open.md).

