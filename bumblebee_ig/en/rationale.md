# Design rationale - Bumblebee — a clinical record for emergency medical teams v0.1.0

## Design rationale

### Design rationale

Every profile in this guide comes from a decision that was written down before the FSH was. This page carries the decisions that shaped a profile, in the form they were recorded: what was decided, why, what was rejected, and where it came from.

The full log is `DECISIONS.md` in the project's design record — 26 entries, of which the ones below are those a reader of these profiles needs. Everything is **proposed** until the project's first gate passes; several entries are marked as taken provisionally for a partner to confirm, and say so.

The evidence each of these rests on is graded in `EVIDENCE.md` and summarised on [the evidence page](evidence.md).

### ADR-004 — Identity is a UUID; everything a human says is an identifier

Shapes [Patient](StructureDefinition-bumblebee-patient.md).

**Decided.** Every resource is created with a client-generated UUID that never changes. Human-facing identifiers — a deployment number said out loud in a tent, an alias for someone who cannot give a name, a wristband barcode — are attributes, not keys. Merge is a first-class reversible audited operation.

**Why.** Identity in a disaster is unreliable: names are spelled several ways, people cannot always give one, and some arrive unconscious. ID-translation tables are where offline systems lose data.

**Rejected.** Server-assigned identifiers with a local mapping table.

**In the profile.** `identifier` is `1..*` and sliced into `mrn`, `alias` and `wristband`, each with its own system, and the profile says outright that none of these is the key. The alias slice records that numeric-only aliases and reused supply numbers are known to cause misidentification, so the default convention is a phonetic word plus the deployment code.

### ADR-006 — Record triage; never compute it

Shapes [Triage assessment](StructureDefinition-bumblebee-triage-assessment.md) and [This patient is getting worse](StructureDefinition-bumblebee-deterioration-flag.md).

**Decided.** The triage system is per-deployment configuration; the category is a human input; the software may display the chosen algorithm's own criteria as labelled reference text and may not compute a category.

**Why.** No triage algorithm is universally superior — START under-triage 57% against SALT 26%, and paediatric accuracy 56–59% across four systems — and the WHO handbook records that **"each EMT has adopted a triage system"**, so there is no common one to compute against. Computing a time-critical category also changes the product's regulatory class.

**Rejected.** Shipping one triage algorithm. Computing an acuity score.

**In the profiles.** The triage assessment binds no categories and requires the value to name its own system, code and label. The deterioration flag is set by a clinician: recording that judgement is in scope, predicting it is not.

### ADR-009 — Deployment configuration is data, changeable in the field

Shapes the bindings across the whole guide.

**Decided.** The triage system, formulary, procedure lists, languages, locations and roles are deployment-profile data — versioned, exportable, importable, and editable offline by a team lead.

**Why.** A disaster cannot wait for a release. Configurable lists were a stated strength of the one field-hospital system with a published evaluation, and were reused mission to mission.

**Rejected.** Hard-coded lists with a release cycle. A cloud-hosted configuration service, which would break offline operation.

### ADR-013 — The patient's copy is mandatory, and nothing may depend on it

Shapes [The copy the patient keeps](StructureDefinition-bumblebee-patient-summary.md).

**Decided.** Build the patient's document, shaped like an International Patient Summary — and let no part of the design depend on a patient carrying or presenting it. The primary continuity path is provider to provider.

**Why, in two halves.** The evidence for patient-held records in mobile populations is thin, and the study that looked hardest found the binding constraint was **physician adherence**: the record was useful when used, and external doctors often did not use it. Building the continuity story on an artefact the receiving clinician may ignore would be designing on a hope. But WHO's core standard requires confidential patient records **"with a copy available to the patient"**, so the copy is not optional and not a judgement call. Obligation and dependency are different questions.

**Rejected.** The patient-held record as the headline continuity mechanism.

### ADR-014 — A defined end-of-deployment handoff

Shapes [The team](StructureDefinition-bumblebee-organization.md) and the [anticipated date of departure](StructureDefinition-departure-date.md).

**Decided.** A documented handoff of the clinical record and the deployment configuration to the local health system, in FHIR R4 natively.

**Why.** An emergency medical team leaves; the patients stay. WHO's core standard requires reporting to the relevant local health authorities **"regularly and prior to departure"**, and the published reviews find that what happens to a record after the encounter varies wildly, hindering follow-up by local teams.

**Rejected.** Treating export as a convenience feature for a later phase.

**In the profiles.** The team is an `Organization` carrying `telecom` and `address`, not only a name, because the record is read months later by someone who was not there and has to be able to find whoever wrote it. The departure date is an extension on that organisation, because the handover must be coordinated at least seven days before shutdown.

### Decision 19 — Consent is per act, and the conversation is at registration

Shapes [Permission for one specific thing](StructureDefinition-bumblebee-consent.md).

**Decided.** Treating someone, and writing down that we treated them, does not rest on their permission — it rests on the same basis as the treatment. But they must be told, and be able to object, and that conversation happens at registration rather than in the consultation. Permission **is** required, and recorded separately, for: sharing or referring · recording sexual violence · a procedure or anaesthetic · transfer to another facility · a photograph.

**Why.** The ICRC handbook argues that permission only counts if the person could realistically say no, and someone injured, frightened and dependent on you for treatment has **"no genuine choice but to accept whatever… is involved in accepting the aid offered."** Asking them to sign anyway is paperwork that looks like protection. But guidance on documenting sexual violence, and the emergency medical team standards, each require real consent for particular acts — and in the patient's own language.

**Rejected.** **Ask permission for everything** — where someone cannot realistically refuse, consent is a fiction, and producing it spends the clinician's time. **Ask permission for nothing on the grounds that they need care** — that would put teams outside the rules they are inspected against.

**In the profile.** `category` is `1..*` and says which act this consent covers. There is no single form at the door, because a person agreeing to be treated has not thereby agreed to have their assault recorded.

**Source.** ICRC **Handbook on Data Protection in Humanitarian Action**, 3rd ed., §§2.10, 3.2.4, 3.3 · the interagency gender-based-violence information standard · WHO **Ethical and safety recommendations for researching, documenting and monitoring sexual violence in emergencies**, 2007, §§3.4, 5 · WHO **Classification and Minimum Standards for Emergency Medical Teams**, 2021, standards 68–70.

### Decision 20 — Several codings on one concept, and only one of them is theirs

Shapes [Diagnosis](StructureDefinition-bumblebee-diagnosis.md).

**Decided.** Store several codings in one `CodeableConcept`; mark exactly one with `Coding.userSelected = true` — the one the clinician picked; derive the rest only where the map is unambiguous, and store nothing derived where it is not. The clinician never chooses a coding system: there is one list, the deployment's, and the codes sit behind the items.

**Why.** A record must be readable without us — offline, on someone else's system, years later. Maps also get revised: a stored coding says what was meant at the time, while a crosswalk applied later says what today's map thinks was meant. And the classifications answer different halves of the caseload: ICPC-2 suits the undifferentiated primary care that dominates it, while trauma, surgery and notifiable disease need ICD-10 or SNOMED precision that is clinically necessary **and available** — the surgeon knows which femur.

**Rejected.** **Store one code and map everything on read** — the record stops being self-describing, which is the property most needed offline. **Store all three silently** — with one-to-many maps that asserts codes the clinician never chose, which is a fabricated clinical claim rather than a rounding error. **Pick one classification** — ICD-10 describes the undifferentiated caseload badly, and ICPC-2 alone would not serve notifiable-disease surveillance, which is ICD-10 throughout.

**Still open.** Whether ICPC-2 is adopted at all.

### Decision 21 — The one field no patient's care depends on

Shapes the [relation to the disaster](StructureDefinition-disaster-relation.md) extension.

Every extension in this guide was audited against a single question: **does a clinician or a patient need this?** Five passed outright. This one failed, and it stayed anyway — with the audit finding converted into a performance requirement.

**Decided.** It stays on the clinical surface, and "implemented properly" is now the binding constraint: one tap on a control already on screen · never blocking · `unknown` a complete and permanent answer · not repeated per problem when a visit's problems share a cause · and measured, so that if it costs more than a second or two the implementation is wrong rather than the field.

**Why.** The objection was never that the field is wrong — it is a real obligation and somebody has to answer it. The objection was cost, and Grey priced it: **"that's an acceptable extra step, because it should take minimal time if implemented properly."**

**Rejected.** Capturing it on the visit rather than the problem — one visit can hold a crush injury and long-standing diabetes.

**What the audit still stands behind.** It is not a clinical question, so it may never be required, never gate anything, and never be the reason another field exists.

### Decision 22 — EpisodeOfCare was written, and then deleted

Shapes [Visit](StructureDefinition-bumblebee-encounter.md), and explains an absence.

**Decided.** `BumblebeeEpisode`, which grouped a patient's visits within one deployment, is dropped. What we wanted from it — **what happened last time about **this**** — is a `Condition` threaded across visits plus `Encounter.reasonReference` pointing at the problem the patient is here about.

**Why.** The specification states the boundary in one line: **"Encounter is continuous but Episodes are discontinuous care."** An `EpisodeOfCare` is defined by **responsibility that persists between contacts** — **"the managing organization assumes a level of responsibility for the patient during this time"** — and it carries a status machine and **"can exist without any activities"**, because its job is to answer **is this patient still on our books, and for what?** Grouping a deployment's visits is neither of those. It is administrative, and the deployment tag already carries it on every resource.

**Rejected.** **Keep it per deployment** — an administrative grouping we already have twice over. **Re-point it per problem** — a real use of the resource, but it buys a status machine and a caseload list that nothing in the design needs yet.

**Reopen it if** a team has to hold a list of the people it is still responsible for between visits. That is a question about how a team works, and it is on [the open questions page](open.md).

**How this was settled matters more than the answer.** The first version of this decision was derived from element definitions, as though a clinic visit had never been modelled. It has been, repeatedly and in published guides, and the sweep that followed — recorded in `ENCOUNTER-IG-SWEEP.md` — found both the rule above and a second grouping mechanism that had never been considered, `Encounter.partOf`, which is what OpenMRS maps its own **Visit** to.

**Source.** `hl7.org/fhir/R4/episodeofcare.html` · `hl7.org/fhir/R4/encounter.html` · `hl7.org/fhir/R4/administration-module.html`.

### Decision 23 — Other guides are evidence, not a target

Shapes how the whole guide was written. It has [a page of its own](relationship.md).

**Decided, in Grey's words:** **"we don't HAVE to conform to other IGs, it's just nice when we can and when it makes sense."** Alignment is free value where it costs nothing. Where a published guide and a patient in a tent disagree, the patient wins and we write down that we differed and why.

**Rejected.** **Conform to a national core** — it would import national regulatory terminology and a payer model into a product with no billing, for a population it was not written for. **Conform to nothing and derive from the base specification** — that is exactly what produced Decision 22's first, wrong answer.

### Decisions taken inside the profiles

Not every choice needed an entry in the log. These were made while walking through a consultation, and each is recorded as a comment in the FSH beside the profile it produced.

**Triage is an `Observation`, not an element on the visit.** A `Condition` is something the patient **has**; a triage category is a judgement the team makes about how soon to see them, so it does not belong beside "open fracture" in the problem list. **Rejected:** `Encounter.priority`, which exists in R4 and is single-valued — and FHIR gave `Encounter` a `statusHistory` and a `classHistory` and deliberately no `priorityHistory`, so a re-assessment would overwrite the first.

**A medicine given is a `MedicationAdministration`, not a request.** In a field clinic the person deciding and the person handing over the tablets are usually the same person in the same tent. A prescription addressed to a pharmacy that is not there records an intention nobody will act on. A team with a real pharmacy queue can write requests as well; the record depends on this one.

**A medicine taken away is a `MedicationDispense`.** A five-day course in a paper bag has not gone into anybody: nothing has happened yet, and four of those five days happen in a shelter with nobody watching. The questions at a return visit — what did we give her, how much, when did she start, has she run out — are `medication[x]`, `quantity`, `whenHandedOver` and `daysSupply`, and they cannot be answered from an administration record.

**Coming back is not a referral.** **"Go home and come back Thursday for the dressing"** and **"go home, we are finished"** are the same discharge disposition, because a disposition is a category of location. The part that matters clinically is a date and a reason. **Rejected:** `Appointment`, which presumes a slot in a schedule, and there is no schedule — there is a tent and a day. **Also rejected:** folding it into the referral, which is the same resource, because the difference that matters is whether responsibility moves. It does not, and asking someone to come back must not open a handover that somebody then has to close.

**Return advice is a `Communication`.** WHO treats it as a documented act rather than a courtesy: discharge of every child must include the signs that mean return urgently, chosen for that child's problem. **Rejected:** a section of the patient's document, because the document is content, and what this records is that somebody was actually told — often the person holding the child rather than the patient.

**Sources.** WHO **Pocket Book of Hospital Care for Children**, 2nd ed. 2013, §§12.1 and 12.8 · WHO **Classification and Minimum Standards for Emergency Medical Teams**, 2021, §5.1.4 · `EVIDENCE.md` §AM.

