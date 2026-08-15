# Terminology and extensions - Bumblebee — a clinical record for emergency medical teams v0.1.0

## Terminology and extensions

### Terminology and extensions

Three code systems, four value sets, eight extensions. Each one has to justify being ours rather than somebody else's.

### Why any of these are ours

**Body regions are ours on size alone.** The body map needs a few dozen regions against SNOMED CT's tens of thousands, and shipping a few dozen offline is simpler than shipping a terminology server to a tent.

**That is a size argument, not a licensing one**, and the distinction matters because an earlier version of this reasoning ended "…and a licence", which was wrong and has been removed. SNOMED CT Affiliate Licences are free in member countries, free in the 49 World Bank low-income economies, and available on humanitarian grounds elsewhere. The genuinely unclear case is a middle-income non-member territory, where a fee may apply — a conversation to have with SNOMED International rather than a wall. The project's position is recorded as taken under uncertainty: we proceed as though storing identifiers and descriptions in patient records needs no licence, and we are explicitly unsure. The remedy, if that is wrong, is paperwork rather than a redesign, which is the whole reason deferring it is reasonable.

**What we deliberately did not define:** case classification for notifiable conditions. FHIR's own `Condition.verificationStatus` already carries that axis, and the notifiable profile constrains it to three of the six values rather than minting a parallel vocabulary.

### Body region — and why it is hierarchical

[`BodyRegionCS`](CodeSystem-body-region-cs.md) · [`BodyRegionVS`](ValueSet-body-region-vs.md)

This exists so a clinician can **tap a diagram** instead of typing. Every code is somewhere a person can point at.

```
head-spine → head · face · neck · spine
torso      → chest · abdomen · back · pelvis
extremity  → the twelve left/right limb parts
perineum · generalised

```

**The hierarchy is the whole design: a clinician taps at the precision they actually have.** A patient face-down on a stretcher gets **limb** or **torso**; the same patient ten minutes later gets **left forearm**. Neither is a degraded version of the other — they are what was known at the time, and forcing the finer one invents certainty that was not there. Anything that needs to add regions together walks the tree, rather than finding a bucket sitting in the picking list.

**It replaced a flat list, and the correction is worth recording** because the first reason given for changing it was wrong. The flat list had "head or spine" sitting as a sibling of "left forearm", and it was removed on the grounds that head and spine are opposite ends of the body. They are not: the head sits on top of the spine, the cervical spine **is** the neck, and they are one continuous structure. That is precisely why grouping them is anatomically sound — it is the neuraxis, and it is the grouping whose injuries most often leave permanent damage. What actually survived of the objection is that the list was **flat**: a code meaning "head OR spine" cannot answer **where is it** when it is offered alongside a code that can. That is an argument for a parent, not for a deletion.

`head-spine` is therefore a parent code and a legitimate answer in its own right.

### Relation to the disaster

[`DisasterRelationCS`](CodeSystem-disaster-relation-cs.md) · [`DisasterRelationVS`](ValueSet-disaster-relation-vs.md) · [`DisasterRelation`](StructureDefinition-disaster-relation.md)

Four codes: `directly` · `indirectly` · `not-related` · `unknown`.

**`unknown` is the default and it is a complete, permanent answer.** Nothing about the patient's care changes with this value — a clinician treating acute watery diarrhoea does not need to know whether a damaged water system caused it, because the treatment is identical either way — and two field clinicians shown the same case agree about 0.59 of the time. It is an obligation the team owes upward, it is never asked during a consultation, and nothing downstream may treat it as precise.

It sits on the `Condition` rather than the visit because cause is true of a problem: one visit can hold a crush injury and long-standing diabetes, and a visit-level answer destroys that at the only point where it cannot be recovered.

### Treatment level

[`TreatmentLevelCS`](CodeSystem-treatment-level-cs.md) · [`TreatmentLevelVS`](ValueSet-treatment-level-vs.md) · [`TreatmentLevel`](StructureDefinition-treatment-level.md)

`major` · `moderate` · `minor`. Mostly a statement about **where this patient can be looked after**: major needs general anaesthesia or hospitalisation and therefore a Type 2 or Type 3 team; minor is first aid and a light dressing, within what a Type 1 mobile team can do. It is the judgement that decides whether the patient stays or travels, and it applies to a `Condition` and to a `Procedure`.

### Suspected, probable, confirmed

[`NotifiableVerificationVS`](ValueSet-notifiable-verification-vs.md)

Three of FHIR's six verification statuses, matching the surveillance vocabulary: `unconfirmed` = suspected (meets the clinical case definition) · `provisional` = probable (the definition plus supporting evidence, or a link to a confirmed case) · `confirmed` = laboratory confirmed.

### The extensions

Six of them exist because FHIR has no home for the concept. Three of the six were independently arrived at by Faisal and Nakayama (**JMIR Med Inform** 2024;12:e59651), which is mild evidence that the set is close to minimal.

| | | |
| :--- | :--- | :--- |
| [Estimated age](StructureDefinition-estimated-age.md) | `Patient` | FHIR has`birthDate`and nothing else. Age decides the dose, the screening band, and how a presentation reads, and an estimate is often all anyone has |
| [Relation to the disaster](StructureDefinition-disaster-relation.md) | `Condition` | Above |
| [Treatment level](StructureDefinition-treatment-level.md) | `Condition`,`Procedure` | Above |
| [Administrative division](StructureDefinition-admin-division.md) | `Location` | `Location`has no element for an administrative hierarchy, and in a displacement setting the village is often the only part anyone can name |
| [Anticipated date of departure](StructureDefinition-departure-date.md) | `Organization` | The handover to local health authorities has to be coordinated at least seven days before the team shuts down |
| [Deployment](StructureDefinition-deployment-tag.md) | `Resource` | Makes purging one deployment a single verifiable operation |
| [Exposure history](StructureDefinition-exposure-history.md) | `Condition` | Where the person is thought to have been exposed. Asked for by the surveillance standards for notifiable conditions, and by nothing else |
| [Mass casualty mode](StructureDefinition-mass-casualty-mode.md) | `Encounter` | Whether this visit was triaged under mass-casualty rules rather than ordinary ones, which changes how the triage value is read back |

