---
id: serialization
title: Serialization/Deserialization
---
# Serialization and Deserialization in FHIR-FLI

Serialization and deserialization are core functionalities in the FHIR-FLI libraries that enable conversion between FHIR resources (represented as Dart objects) and various data formats (mostly JSON, but [John](https://github.com/FireJuun) likes YAML). This page explains how these processes work in FHIR-FLI and how to use them effectively in your Flutter applications.

## Concepts

### Serialization

Serialization is the process of converting a Dart object instance into a format that can be easily stored or transmitted, such as JSON (note, FHIR also supports XML and Turtle, we do not. We do support YAML, which is just a superset of JSON anyway). In FHIR-FLI, this means converting a FHIR resource object (like `Patient`, `Observation`, or `Account`) into a JSON string.

### Deserialization

Deserialization is the reverse process - converting data from JSON format back into Dart objects that your application can work with directly.

## Working with JSON

JSON (JavaScript Object Notation) is the primary data interchange format for FHIR resources. FHIR-FLI provides robust support for JSON serialization and deserialization.

### Serializing to JSON

Every FHIR resource class in FHIR-FLI implements a `toJson()` method that converts the object to a Map representation, which can then be converted to a JSON string. So if we take our patient example: 

```dart
final patient = Patient(
    id: FhirString('123'),
    name: [
      HumanName(
        family: 'Doe'.toFhirString,
        given: ['John'.toFhirString],
      ),
    ],
    birthDate: '1990-01-01'.toFhirDate,
  );

print(patient.toJson());
```

```bash
$ {resourceType: Patient, id: 123, name: [{family: Doe, given: [John]}], birthDate: 1990-01-01}
```

 Which is correct. And while there are some occasions where it may be useful to see that, you're usually going to be working with the Dart class OR you're going to need to change it into a JSON String representation, which is how JSON is actually transferred. So if we instead do this:

 ```dart
 print(jsonEncode(patient.toJson()));
 ```

 ```bash
 $ {"resourceType":"Patient","id":"123","name":[{"family":"Doe","given":["John"]}],"birthDate":"1990-01-01"}
 ```

And that's what you would actually transmit via a POST request for instance. You do a lot of that in FHIR, and I found it cumbersome to have to do two steps. So in addition to a ```toJson()``` method, all FHIR classes have a ```toJsonString()``` method, that does both parts. 

### Serializing to YAML

I'm not going to talk about this alot, the idea is very much the same as the above, except that it works for YAML strings. Most FHIR servers will not accept YAML strings, but we have found it useful at times when you want a prettier or cleaner way to display FHIR data. 

```dart
print(patient.toYaml());
```
```yaml
resourceType: Patient
id: '123'
name:
  - family: Doe
    given:
      - John
birthDate: "1990-01-01"
```

### Deserializing from JSON

This is the reverse process as above. You will typically use this when you're accepting data from an outside source (a database, a server, etc.). While all classes have this function, you typically need to know what class it is. The library is not smart enough to let you take a random Map and turn it into FHIR, you have to provide it with a bit of instruction. 

```dart
final name = {
    'family': 'Doe',
    'given': ['Jane']
}

final humanName = HumanName.fromJson(name);
```

The one exception is if its a Resource. Since a FHIR Resource is the basic building block of the specification, Resources are treated slightly differently. If you know that something is a Resource, even if you don't know what kind, we can still work with that. 

```dart
final resource1 = {
  "resourceType": "Patient",
  "name": [
    {
      "family": "Doe",
      "given": ["Jane"]
    }
  ],
};

final resource2 = {
  "resourceType": "Observation",
  "status": "final",
  "code": {
    "text": "Blood Pressure"
  },
  "valueQuantity": {
    "value": 120,
    "unit": "mmHg"
  }
};


final unknownResource1 = Resource.fromJson(resource1);
final unknownResource2 = Resource.fromJson(resource2);

print(unknownResource1 is Patient); // true
print(unknownResource2 is Observation); // true
```

This is based on the resourceType field, so that does need to be present (which if it's from a server or db it should be). But if for some reason you're writing your own maps and don't include the resourceType field, it won't work. 

#### fromJsonString Constructor

Similarly to the fromJson constructor we talked about above, there's also a convenience constructor ```fromJsonString``` for all classes. What this means is that if you have a string from a GET request, you can pass it directly to the constructor, you don't have to convert it into a map first. You're welcome.