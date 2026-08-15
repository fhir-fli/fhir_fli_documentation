# What is not settled - Bumblebee — a clinical record for emergency medical teams v0.1.0

## What is not settled

### What is not settled

This guide is at version 0.1.0 and the profiles are **proposed**. This page is the list of things a reader should not take as decided, kept here rather than in a private file because an implementer needs to know which parts may move.

### Questions only a deployed team can answer

Each of these decides an element that is currently absent. They are written out in full, with our current position, in `STAKEHOLDER-QUESTIONS.md`.

**Does one team run more than one place at once?** We have assumed a deployment is one place. If a team runs a clinic and also sends a mobile team out, then **where** someone was seen is a real clinical fact and `Encounter.location` should hold it. If not, it is a field nobody needs. Three of the four guides compared mark it Must Support, which is why the absence is deliberate rather than overlooked.

**Does a patient leave with a number?** A card, a slip, a wristband — and is the number for the person or for that day's visit? This decides `Encounter.identifier`, and it matters because the failure mode on a return visit is a silent second record for the same person.

**Should the record say "first visit" or "follow-up"?** This decides `Encounter.type`. It sits behind a prior question: is somebody who was triaged and then seen by a clinician one visit or two?

**Does a team keep a list of the people it is still looking after between visits?** That, and only that, would justify an `EpisodeOfCare` — the wound to be seen again in three days, the person started on two weeks of blood-pressure treatment. The profile that used to be here was dropped precisely because grouping a deployment's visits is not that.

### Left blank on purpose

**Who pronounced a death is not modelled.** It is plainly a real clinical fact, and we have no source telling us how a deployed team records it or who is permitted to. Certification is a legal act whose holder varies by jurisdiction, and a visiting team may hold no such authority. What a team can produce is a clinical statement — who confirmed the death, when, and the circumstances — and we will not build something shaped like a certificate that is not one. The `Patient` profile carries the fact and the time and stops there.

**Whether the family has been informed after a death is not modelled either.** **"Nobody knows where her mother is"** is a real state that persists for days, has to be visible to the next person, and is what safe and dignified burial arrangements depend on. It is a known gap rather than a decision.

### Known gaps in the profile set

* **No examples.** A profile with no instance is how you ship something nobody can satisfy, and the examples in a guide are validated against its profiles during the build — which turns **is this data the right shape?** from a judgement into a build step. This is the next piece of work.
* **Five profiles named in the plan and not written**: `PractitionerRole`, an anaesthesia record, `CarePlan`, `Device` / `DeviceUseStatement`, and a protection flag.
* **Sensitivity labels are not carried.** The labelling standard for records that could endanger a patient is chosen; the profiles do not yet apply it.
* ****Needed and unavailable** is not recordable as an outcome.** A team that cannot provide something a patient needs has nowhere to say so.

### Decisions taken under uncertainty

**The SNOMED CT licence position.** We proceed as though storing identifiers and descriptions in patient records requires no licence, and we are **explicitly unsure**. Nobody has confirmed it. It is recorded so that a later reader does not mistake it for something established. The remedy, if it is wrong, is an Affiliate Licence — free in member countries, free in the 49 World Bank low-income economies, available on humanitarian grounds elsewhere — so the failure mode is paperwork rather than a redesign. That asymmetry is the reason deferring is reasonable; if the remedy were architectural the decision would be wrong.

**Whether ICPC-2 is adopted at all.** It suits the undifferentiated half of the caseload, which is the majority of the work, and it appears nowhere in the project's documents before mid-2026. Its licence is free for non-commercial use, with fees negotiable otherwise.

### The status of everything else

Entries in the decision log carry a status of `PROPOSED`, `ACCEPTED`, `REVERSED` or `SUPERSEDED`, and a **reversal condition** — what would have to be true for the decision to be wrong. A decision with no stated reversal condition is not a decision, it is a habit. Several of the entries behind this guide are marked as taken provisionally for a partner to confirm, and the [design rationale](rationale.md) page says which.

