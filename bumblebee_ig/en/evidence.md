# Evidence basis - Bumblebee — a clinical record for emergency medical teams v0.1.0

## Evidence basis

### The evidence basis

The profiles in this guide are not derived from first principles. They rest on a graded source library, `EVIDENCE.md` in the project's design record, which exists so that nothing is looked up twice and nothing is re-derived. This page says what that library contains and which parts of it decided which profile. It does not restate the evidence — the library is the citation.

### How the sources are graded

| | |
| :--- | :--- |
| **STRONG** | controlled or quantified, replicated |
| **MODERATE** | a single good study, a consensus standard, or a validated framework |
| **WEAK** | observational, qualitative, or a stated preference |
| **ANECDOTAL** | vendor or opinion |
| **NEGATIVE** | evidence that something does**not**work |
| **UNVERIFIED** | a claim that could not be sourced |

**UNVERIFIED is used, and it is used on our own claims.** One figure that three reviewers repeated back to us could not be found on searching for it, and it is recorded as not to be cited rather than quietly kept.

### The numbers that govern the clinical surface

From the response to Cyclone Idai in Mozambique, 2019 — 13 teams over 110 days, 18,468 consultations, 13,738 health events **[STRONG — primary, WHO-funded, ethically approved]**:

| | |
| :--- | :--- |
| Health events with no more specific description than "other" | **56.5%** |
| Health events unrelated to the disaster | **84.7%**, rising 68.7% → 94.5% over the response |
| Major head/spine, torso and extremity injury, together | **0.5%**— 66 of 13,738 |
| Minor injury · acute watery diarrhoea · malaria · acute respiratory infection | 9.8% · 9.4% · 6.6% · 6.0% |

A second, independent deployment gives the same conclusion from the opposite side of the world: roughly 48% of **consultations** fell into the residual category, and 74.5% were discharged with no follow-up arranged.

**What follows for these profiles.** The record has to be excellent at ordinary illness seen once in a tent. Text-only diagnosis is the expected case, not a degraded one. What the patient was told to watch for is, for three of every four people, the only safety net they leave with — which is why it is a profile of its own rather than a paragraph in a document.

### Which evidence decided what

| | | |
| :--- | :--- | :--- |
| Triage recorded, never computed | START under-triage 57% against SALT 26%; paediatric accuracy 56–59% across four systems | §E |
| Offline operation as the normal state | Whole-database synchronisation inside an encounter produced documented clinical chaos; event-delta synchronisation fixed it; the fully-offline site had no synchronisation problems at all | §C.2, §D |
| Identity as a UUID, duplicates tolerated | Unidentified-patient practice, and a deployed system's duplicate-record problem from name transliteration | §F |
| Bounded choice rather than typing | Drop-downs eliminated handwriting-related prescription errors; users of the closest comparable system asked, above everything else, for less interaction depth | §G, §C.1 |
| …and never hard-blocking the clinician | Relaxed validation on selected items measured a 1.60% error rate that strict validation would have hidden. You cannot measure an error rate you have made impossible to express | §W.7 |
| AVPU rather than the Glasgow Coma Scale | Four steps instead of thirteen, and it survives brief training better | §R.4 |
| Arm circumference stored in millimetres | The threshold is contested across guidance and screening evidence | §M.3, §R.3 |
| The patient's copy is mandatory but never depended on | Physician adherence, not patient possession, was the binding constraint in the study that looked hardest | §M.7, §I |
| A separate compartment for records that could endanger someone | The interagency standard requires it; 43% of audited healthcare mobile applications had insecure local storage and 95% failed at least one mobile-security check | §M.5, §S.3 |
| Structured referral content | Standardised referral templates improve completeness and reduce inappropriate referrals | §S.4 |
| The end of a visit is a specified act | Discharge of every child must include follow-up instructions, the signs that mean return urgently, and a vaccination check | §AM |
| Body diagram marking | Required by the standards for documenting unexplained injuries in children, and used the same way by the one field-hospital system with a published evaluation | §C.1, §AA |

### Two standing rules that shaped how this guide was written

**Novelty is a cost.** Where evidence exists, follow it. A design element with no external support has to earn its place, because it also gives up external reviewer familiarity and the chance that someone else already found the failure mode.

**Before writing "no precedent", search adjacent domains and name what was searched.** This rule exists because the project's record on novelty claims is 0 for 3: a list of seven design elements called unprecedented turned out to have evidence for all seven; a security pattern turned out to be standard; and an encounter layer that US Core, AU Core and the base specification all document was described as having nothing to build on. The tell is that **if the thing is a routine act of clinical care — a visit, an admission, a referral, a prescription — it has been modelled**, and reading element definitions is what you do after reading the published profiles, never instead.

Both rules are enforced mechanically on this repository's markdown, which is why the pages here name their searches.

### What the library says is missing

`EVIDENCE.md` keeps its own list of gaps, and two of them bear on these profiles:

* **The controlled comparison does not exist.** A controlled comparison of a field record against paper — documentation time, data completeness, error rate — is the study this project would most like to run and could not find. The authors of the closest comparable system recommended exactly it and did not do it.
* **Numbers we could not source are marked, not dropped.** Where a claim was repeated to us and could not be verified, it is recorded as unverified and is not used to justify anything here.

