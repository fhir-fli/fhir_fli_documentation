# What the record holds - Bumblebee — a clinical record for emergency medical teams v0.1.0

## What the record holds

### What the record holds

The [artifact index](artifacts.md) lists everything alphabetically. This page lists the same profiles in the order a visit happens, because that is the order they were written in and the order they make sense in.

Every profile constrains a base FHIR R4 resource. Nothing here is a new resource, and nothing here is a new base type.

### The person

| | | |
| :--- | :--- | :--- |
| [Patient](StructureDefinition-bumblebee-patient.md) | `Patient` | A person we are treating. The record's own key is a UUID generated on the device at registration and never changed; everything a human says out loud — a deployment number, an alias, a wristband — is an identifier rather than a key |
| [Accompanying person](StructureDefinition-bumblebee-related-person.md) | `RelatedPerson` | A parent, guardian or caregiver with the patient. It makes an unaccompanied minor a query — a child with no accompanying person — rather than a flag somebody has to remember to set |

`Patient` carries the [estimated age](StructureDefinition-estimated-age.md) extension, because a date of birth is frequently unobtainable and age is what decides the dose and the screening band.

### The visit

| | | |
| :--- | :--- | :--- |
| [Visit](StructureDefinition-bumblebee-encounter.md) | `Encounter` | One contact, from walking up to walking away. Someone seen twice in a day has two of these |
| [Triage assessment](StructureDefinition-bumblebee-triage-assessment.md) | `Observation` | One triage decision, at one moment, by one person. A patient waiting to be seen is re-assessed and gets another one; nothing is overwritten |

### What is wrong with them

| | | |
| :--- | :--- | :--- |
| [Diagnosis made at this visit](StructureDefinition-bumblebee-diagnosis.md) | `Condition` | What was wrong today.`category = encounter-diagnosis` |
| [Standing problem](StructureDefinition-bumblebee-problem.md) | `Condition` | Something already true of this patient before they walked in.`category = problem-list-item` |
| [Notifiable disease](StructureDefinition-bumblebee-notifiable-disease.md) | `Condition` | A diagnosis under outbreak surveillance, carrying suspected / probable / confirmed, because the alerting rules are written in those terms |
| [Complication](StructureDefinition-bumblebee-complication.md) | `AdverseEvent` | Something that went wrong. The clinical problem itself is a diagnosis; this points at it and marks it as an adverse event |

A diagnosis and a standing problem are kept apart because they are different clinical facts: the standing list is what this person lives with, today's diagnosis is what we are treating.

### What was measured and observed

| | | |
| :--- | :--- | :--- |
| [Vital signs](StructureDefinition-bumblebee-vital-signs.md) | `Observation` | Pulse, blood pressure, respiratory rate, temperature, oxygen saturation, weight, and level of consciousness by AVPU |
| [Pain](StructureDefinition-bumblebee-pain-score.md) | `Observation` | How much pain the patient is in, with the time required, because the obligation is repeated assessment |
| [Finding, marked on a body diagram](StructureDefinition-bumblebee-body-site-finding.md) | `Observation` | Something seen or felt, bound to a place on the body. The clinician taps where rather than describing where |
| [Mid-upper arm circumference](StructureDefinition-bumblebee-muac.md) | `Observation` | Millimetres, never a yes/no — the threshold is contested and belongs to the deployment |
| [Burn surface area](StructureDefinition-bumblebee-tbsa.md) | `Observation` | Percentage of the body burned. Decides where the patient is treated and drives fluid resuscitation |
| [Fluid balance](StructureDefinition-bumblebee-fluid-balance.md) | `Observation` | Fluid in and out, with the time |
| [Pregnant or not](StructureDefinition-bumblebee-pregnancy-status.md) | `Observation` | A state with a beginning and an end, so an observation and not a field on the person |
| [This patient is getting worse](StructureDefinition-bumblebee-deterioration-flag.md) | `Flag` | A clinician's judgement that a patient is deteriorating. Recorded, never computed |

### Medicines

| | | |
| :--- | :--- | :--- |
| [Medicine given](StructureDefinition-bumblebee-medication-given.md) | `MedicationAdministration` | A drug that actually went into this patient, at a time, by someone — not a prescription |
| [Medicine they took away](StructureDefinition-bumblebee-medication-take-home.md) | `MedicationDispense` | What was counted out and handed over, with`daysSupply`, which is what tells a clinician three weeks later whether the patient ran out |
| [Medicine they already take](StructureDefinition-bumblebee-medication-taken.md) | `MedicationStatement` | What they were on before they met us, as far as anyone knows. Often the patient is the only source |
| [Allergy](StructureDefinition-bumblebee-allergy.md) | `AllergyIntolerance` | Something that will hurt this patient if we give it to them |
| [Whether we asked about allergies](StructureDefinition-bumblebee-allergy-asked.md) | `Observation` | That the question was asked, and what came back — including "nothing known" and "could not ask" |
| [Vaccine given](StructureDefinition-bumblebee-immunization.md) | `Immunization` | What was given, or what the patient says they have had. Not a schedule the team manages |

Administration and dispense are separate profiles because they answer different questions. What went into the patient answers **what have we already given them?** at three in the morning. What went into a paper bag has not gone into anybody yet, and four of its five days happen in a shelter with nobody watching.

Asking about allergies is recorded separately from the answer because an empty allergy list means either "asked, nothing found" or "nobody asked", and those are different facts.

### What was done

| | | |
| :--- | :--- | :--- |
| [Something done to the patient](StructureDefinition-bumblebee-procedure.md) | `Procedure` | A procedure, carrying whether it was major or minor, and the date it was performed |

### The end of the visit

| | | |
| :--- | :--- | :--- |
| [Come back — when, and for what](StructureDefinition-bumblebee-follow-up.md) | `ServiceRequest` | A planned return to us: a date, and the reason to come on it |
| [What we told them to watch for](StructureDefinition-bumblebee-return-advice.md) | `Communication` | The signs that mean come back immediately, and the record that somebody was actually told them |
| [Referral — what we are asking for](StructureDefinition-bumblebee-referral.md) | `ServiceRequest` | The clinical ask: what this patient needs, why, and from whom |
| [Handover — who has the patient now](StructureDefinition-bumblebee-handover.md) | `Task` | Who is responsible while a referral is in progress. Responsibility moves only at`completed` |
| [What travels with the patient](StructureDefinition-bumblebee-transfer-document.md) | `Composition` | Condition, current treatment, the intention to transfer, and the mode and timeline |
| [The copy the patient keeps](StructureDefinition-bumblebee-patient-summary.md) | `Composition` | Shaped like an International Patient Summary, because that standard exists for a clinician who has never met this person reading it cold |

A follow-up is separate from a referral because nothing is handed over: the patient stays ours and no handover has to be closed.

Return advice is a `Communication` rather than a section of the patient's document because the document is content, while this records that the advice was actually given, to whom, and how — and the recipient is often not the patient. A two-year-old is not the recipient of the advice; the person holding her is.

### Permission, the team and the site

| | | |
| :--- | :--- | :--- |
| [Permission for one specific thing](StructureDefinition-bumblebee-consent.md) | `Consent` | Recorded per act, never once per patient |
| [The team](StructureDefinition-bumblebee-organization.md) | `Organization` | The emergency medical team itself and its type, with contact details and an address, so whoever reads this record later can find whoever wrote it |
| [Where the team is working](StructureDefinition-bumblebee-location.md) | `Location` | The site, with a state / city / village hierarchy and a geographic position, because a team is often in a field with no address |

### What is not here

* **`EpisodeOfCare`.** A profile grouping a patient's visits within one deployment was written and then deleted. The reasoning is on the [design rationale](rationale.md) page and is kept as a comment in the FSH so it is not derived again.
* **Five profiles named in the project plan and not yet written**: `PractitionerRole`, an anaesthesia record, `CarePlan`, `Device` / `DeviceUseStatement`, and a protection flag.
* **Three gaps found by working through the review questions**: **needed and unavailable** as an outcome; whether the family has been informed after a death; and sensitivity labels on protection records — the labelling standard is chosen and the profiles do not carry it yet.
* **Examples.** None.

