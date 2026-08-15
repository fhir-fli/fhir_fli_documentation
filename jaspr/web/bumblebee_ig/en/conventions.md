# How to read the profiles - Bumblebee — a clinical record for emergency medical teams v0.1.0

## How to read the profiles

### How to read the profiles

Nine conventions run through all 32 profiles. Each of them is a decision, and each has cost somebody an argument.

### 1. Must Support binds the software. min binds the clinician.

This distinction is load-bearing here, and it is the one most often collapsed.

* **Must Support** is an obligation on an implementation. R4: **"implementations that produce or consume resources SHALL provide 'support' for the element in some meaningful way."** It says the software must be able to hold this, show it, and pass it on.
* **`min`** is an obligation on the instance, and therefore on the person filling it in. R4: **"the minimum number of times this element SHALL appear in the instance."**

Most elements in this guide are **Must Support at `0..*` or `0..1`**. That is deliberate. Grey, on `Encounter.reasonReference`: **"do we force the clinicians to make something up to justify a required field? I don't like it."** A first visit has nothing to point at, leaves the element empty, and that is valid permanently.

**A blank clinical field is never auto-filled.** Filling `Encounter.reasonReference` from the first diagnosis on the visit would record a link nobody made — the same defect as asserting a triage category for a time when nobody looked.

Where an element **is** required, the requirement is a clinical one and the profile says what it is. `BumblebeeTriageAssessment.effectiveDateTime` is `1..1` because without it there is no trajectory, and the trajectory is the reason the profile exists.

### 2. Text alone is valid, and it is the expected case

`BumblebeeDiagnosis.code` is `1..1`. That means **say what was wrong**, not **pick from a list**: a FHIR `CodeableConcept` is satisfied by `text` alone.

This is not a degraded path. Of 13,738 health events recorded in the response to Cyclone Idai, 56.5% had no more specific description than "other". An implementer who reads `1..1` as a mandatory picker has built something that fights the majority of patients.

The same applies to `BumblebeeAllergy.code` — the patient may know "penicillin" or only "a rash from an injection" — and to `BumblebeeMedicationTaken.medication[x]`, where "a white tablet for blood pressure" is worth more in the record than nothing.

### 3. A stored value has to be readable without us

Offline, on someone else's system, years later, with no lookup table to hand.

`BumblebeeTriageAssessment` requires all three of `valueCodeableConcept.coding.system`, `.code` and `.display`. A bare "1" is not a triage category: the same numeral runs in opposite directions across published documentation of the same scale. The label is what survives being moved, exported, or read by someone who was not there.

The same reasoning is why a chosen diagnosis code is stored rather than derived on read, and why `Coding.userSelected` marks the one coding the clinician actually picked.

### 4. Point samples, not inferred periods

Triage is one `Observation` per assessment, never overwritten. **"Red from 14:05 to 14:40"** asserts a state nobody checked at 14:20 — it records an inference. **"Assessed red at 14:05, assessed green at 14:40"** records what happened. Two timestamped points also give the rate of change directly, and a patient who went green to red is a different patient from one who arrived red.

The general form: **record what happened, and mark what was inferred.**

### 5. Where a threshold is contested, store the measurement

`BumblebeeMUAC` is millimetres, `1..1`, and never a malnourished yes/no. One long-cited definition says under 110 mm, current guidance says 115 mm, and screening evidence argues for higher still. Store the measurement; let the deployment set the line.

### 6. Absence of a record is not a record of absence

`BumblebeeAllergyAsked` exists only for this. An empty allergy list means either "asked, nothing found" or "nobody asked". Conflating them is how a patient gets given something that hurts them.

### 7. Time is required wherever the series is the point

`effectiveDateTime` is `1..1` on the triage assessment, pain, vital signs, mid-upper arm circumference, fluid balance and the allergy question, and `effective[x]` is `1..1` on a medicine given. One reading is not monitoring. The standards that require these require them **repeatedly**, and a single value with no time satisfies none of them.

`Encounter.period.start` is `1..1` for a related reason: arrival time against the time of death is what distinguishes a patient who was dead when they arrived from one who died while we had them — a comparison, rather than two flags somebody has to keep consistent.

### 8. Value lists are deployment data. This guide ships almost none.

The triage system, the formulary, the procedure list, the languages and the locations are configuration, versioned and editable in the field by a team lead, because a disaster cannot wait for a release.

So `BumblebeeTriageAssessment` binds no categories at all — the team brings its own system, and the profile requires only that whatever it brings says which system it is. `medication[x]` is a concept from the deployment's own formulary: the team cannot give what it did not bring, so the list is bounded before deployment, and free text stays possible for anything given from outside the kit.

The four value sets this guide does define are on [the terminology page](terminology.md), with the reason each one is ours.

### 9. Bindings are extensible unless the meaning depends on being closed

`bodySite` is bound to the body-region value set as **extensible**: the list is what a clinician can point at on a diagram, and a site it does not cover is still worth recording.

`BumblebeeNotifiableDisease.verificationStatus` is **required**, constrained to three of FHIR's six values, because outbreak alerting is written in exactly those terms — one suspected case is an alert, one confirmed case is an outbreak — and a fourth value would have no meaning in that rule.

### A note on the deployment tag

`DeploymentTag` is an `Identifier`-valued extension whose context is `Resource`, so it may appear on anything, and it is `1..1` on the visit. Its one job is to make purging a deployment a single verifiable operation. It is not a reference to an organisation and it does not say who looked after the patient — that is `Encounter.serviceProvider`, which points at [the team](StructureDefinition-bumblebee-organization.md) and reaches their contact details.

