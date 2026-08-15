# Body region (code system) - Bumblebee — a clinical record for emergency medical teams v0.1.0

## CodeSystem: Body region (code system) 

 
Where on the body something is. This exists so a clinician can TAP A DIAGRAM instead of typing - required for documenting unexplained injuries in children, and used the same way by the one field-hospital system with a published evaluation. Every code is somewhere a person can point at. 

This Code system is referenced in the definition of the following value sets:

* [Body region](ValueSet-body-region-vs.md)

-------

 [Description of the above table(s)](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#terminology). 



## Resource Content

```json
{
  "resourceType" : "CodeSystem",
  "id" : "body-region-cs",
  "url" : "http://fhir-fli.dev/bumblebee/CodeSystem/body-region-cs",
  "version" : "0.1.0",
  "name" : "BodyRegionCS",
  "title" : "Body region",
  "status" : "draft",
  "date" : "2026-08-14T17:06:47-04:00",
  "publisher" : "fhir-fli",
  "description" : "Where on the body something is. This exists so a clinician can TAP A DIAGRAM instead of typing - required for documenting unexplained injuries in children, and used the same way by the one field-hospital system with a published evaluation. Every code is somewhere a person can point at.",
  "caseSensitive" : true,
  "content" : "complete",
  "count" : 25,
  "concept" : [{
    "code" : "head-spine",
    "display" : "Head and spine",
    "definition" : "Head, face, neck and the vertebral column - one continuous structure, and the one whose injuries most often leave permanent damage.",
    "concept" : [{
      "code" : "head",
      "display" : "Head"
    },
    {
      "code" : "face",
      "display" : "Face"
    },
    {
      "code" : "neck",
      "display" : "Neck"
    },
    {
      "code" : "spine",
      "display" : "Spine"
    }]
  },
  {
    "code" : "torso",
    "display" : "Torso",
    "concept" : [{
      "code" : "chest",
      "display" : "Chest"
    },
    {
      "code" : "abdomen",
      "display" : "Abdomen"
    },
    {
      "code" : "back",
      "display" : "Back",
      "definition" : "The surface of the back. The vertebral column itself is spine."
    },
    {
      "code" : "pelvis",
      "display" : "Pelvis"
    }]
  },
  {
    "code" : "extremity",
    "display" : "Limb",
    "definition" : "Use when the limb is known and the part is not - a patient still on a stretcher, or a dressing not yet down.",
    "concept" : [{
      "code" : "upper-arm-l",
      "display" : "Left upper arm"
    },
    {
      "code" : "upper-arm-r",
      "display" : "Right upper arm"
    },
    {
      "code" : "forearm-l",
      "display" : "Left forearm"
    },
    {
      "code" : "forearm-r",
      "display" : "Right forearm"
    },
    {
      "code" : "hand-l",
      "display" : "Left hand"
    },
    {
      "code" : "hand-r",
      "display" : "Right hand"
    },
    {
      "code" : "thigh-l",
      "display" : "Left thigh"
    },
    {
      "code" : "thigh-r",
      "display" : "Right thigh"
    },
    {
      "code" : "lower-leg-l",
      "display" : "Left lower leg"
    },
    {
      "code" : "lower-leg-r",
      "display" : "Right lower leg"
    },
    {
      "code" : "foot-l",
      "display" : "Left foot"
    },
    {
      "code" : "foot-r",
      "display" : "Right foot"
    }]
  },
  {
    "code" : "perineum",
    "display" : "Perineum"
  },
  {
    "code" : "generalised",
    "display" : "Generalised",
    "definition" : "All over, or no single place - a rash, a burn across regions."
  }]
}

```
