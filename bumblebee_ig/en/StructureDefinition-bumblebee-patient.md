# Patient - Bumblebee — a clinical record for emergency medical teams v0.1.0

## Resource Profile: Patient 

 
A person we are treating. Identity in a disaster is unreliable — names are spelled several ways, people cannot always give one, and some arrive unconscious. So the record's own key is a UUID generated on the device at the moment of registration and never changed, and everything a human says out loud is an identifier rather than a key. 

**Usages:**

* This Profile is not used by any profiles in this Specification

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/fhir.fhir-fli.bumblebee|current/StructureDefinition/StructureDefinition-bumblebee-patient.json)

### Formal Views of Profile Content

 [Description Differentials, Snapshots, and other representations](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](../StructureDefinition-bumblebee-patient.csv), [Excel](../StructureDefinition-bumblebee-patient.xlsx), [Schematron](../StructureDefinition-bumblebee-patient.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "bumblebee-patient",
  "url" : "http://fhir-fli.dev/bumblebee/StructureDefinition/bumblebee-patient",
  "version" : "0.1.0",
  "name" : "BumblebeePatient",
  "title" : "Patient",
  "status" : "draft",
  "date" : "2026-08-14T17:06:47-04:00",
  "publisher" : "fhir-fli",
  "description" : "A person we are treating. Identity in a disaster is unreliable — names are spelled several ways, people cannot always give one, and some arrive unconscious. So the record's own key is a UUID generated on the device at the moment of registration and never changed, and everything a human says out loud is an identifier rather than a key.",
  "fhirVersion" : "4.0.1",
  "mapping" : [{
    "identity" : "rim",
    "uri" : "http://hl7.org/v3",
    "name" : "RIM Mapping"
  },
  {
    "identity" : "cda",
    "uri" : "http://hl7.org/v3/cda",
    "name" : "CDA (R2)"
  },
  {
    "identity" : "w5",
    "uri" : "http://hl7.org/fhir/fivews",
    "name" : "FiveWs Pattern Mapping"
  },
  {
    "identity" : "v2",
    "uri" : "http://hl7.org/v2",
    "name" : "HL7 v2 Mapping"
  },
  {
    "identity" : "loinc",
    "uri" : "http://loinc.org",
    "name" : "LOINC code for the element"
  }],
  "kind" : "resource",
  "abstract" : false,
  "type" : "Patient",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/Patient",
  "derivation" : "constraint",
  "differential" : {
    "element" : [{
      "id" : "Patient",
      "path" : "Patient"
    },
    {
      "id" : "Patient.extension",
      "path" : "Patient.extension",
      "slicing" : {
        "discriminator" : [{
          "type" : "value",
          "path" : "url"
        }],
        "ordered" : false,
        "rules" : "open"
      }
    },
    {
      "id" : "Patient.extension:estimatedAge",
      "path" : "Patient.extension",
      "sliceName" : "estimatedAge",
      "short" : "Age when date of birth is unknown",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "Extension",
        "profile" : ["http://fhir-fli.dev/bumblebee/StructureDefinition/estimated-age"]
      }],
      "mustSupport" : true
    },
    {
      "id" : "Patient.identifier",
      "path" : "Patient.identifier",
      "slicing" : {
        "discriminator" : [{
          "type" : "value",
          "path" : "system"
        }],
        "rules" : "open"
      },
      "short" : "Human-facing identifiers. None of these is the key.",
      "min" : 1,
      "mustSupport" : true
    },
    {
      "id" : "Patient.identifier:mrn",
      "path" : "Patient.identifier",
      "sliceName" : "mrn",
      "short" : "Deployment number, said out loud in a tent",
      "definition" : "Human-sayable and collision-safe offline: deployment prefix, device prefix, counter. For example D3-B7-0142.",
      "min" : 0,
      "max" : "1",
      "mustSupport" : true
    },
    {
      "id" : "Patient.identifier:mrn.system",
      "path" : "Patient.identifier.system",
      "min" : 1,
      "patternUri" : "http://fhir-fli.dev/bumblebee/mrn"
    },
    {
      "id" : "Patient.identifier:alias",
      "path" : "Patient.identifier",
      "sliceName" : "alias",
      "short" : "Name given to a patient who cannot give one",
      "definition" : "From a per-deployment convention. Numeric-only aliases and reused supply numbers are known to cause misidentification, so the default is a phonetic word plus the deployment code.",
      "min" : 0,
      "max" : "1",
      "mustSupport" : true
    },
    {
      "id" : "Patient.identifier:alias.system",
      "path" : "Patient.identifier.system",
      "min" : 1,
      "patternUri" : "http://fhir-fli.dev/bumblebee/alias"
    },
    {
      "id" : "Patient.identifier:wristband",
      "path" : "Patient.identifier",
      "sliceName" : "wristband",
      "short" : "Barcode or QR on a wristband, encoding the record's UUID",
      "min" : 0,
      "max" : "1"
    },
    {
      "id" : "Patient.identifier:wristband.system",
      "path" : "Patient.identifier.system",
      "min" : 1,
      "patternUri" : "http://fhir-fli.dev/bumblebee/wristband"
    },
    {
      "id" : "Patient.gender",
      "path" : "Patient.gender",
      "short" : "Sex. Pregnancy is NOT here: it is a state with a beginning and an end, not an attribute of a person, and it belongs in an observation with a date on it.",
      "mustSupport" : true
    },
    {
      "id" : "Patient.birthDate",
      "path" : "Patient.birthDate",
      "short" : "Often unobtainable. Use the estimated age extension instead.",
      "mustSupport" : true
    },
    {
      "id" : "Patient.deceased[x]",
      "path" : "Patient.deceased[x]",
      "short" : "Dead, and when. Prefer deceasedDateTime over deceasedBoolean: a bare 'true' cannot say whether they arrived dead.",
      "mustSupport" : true
    },
    {
      "id" : "Patient.photo",
      "path" : "Patient.photo",
      "short" : "Identification photograph. All embedded metadata is stripped at capture.",
      "definition" : "Phone cameras write GPS coordinates into the image. An unstripped photograph is a location fix copied to every device on the team, which endangers everyone at that location rather than one patient.",
      "mustSupport" : true
    },
    {
      "id" : "Patient.link",
      "path" : "Patient.link",
      "short" : "Merge. Reversible and audited; both the alias and the real name stay visible afterwards.",
      "mustSupport" : true
    }]
  }
}

```
