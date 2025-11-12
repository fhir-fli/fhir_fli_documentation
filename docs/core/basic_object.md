---
id: basic_object
title: Basics of FHIR Classes
---

# FHIR Classes

These classes don't differ much from any other object oriented classes. If you want to create a patient for instance, you do it just like this:

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
```

And that's that. So a couple of things to mention. I liked freezed, but it doesn't play well with other code generators, and ends up producing a LOT of code. And while its very useful, I didn't think we needed all of it for this, so that's gone. I did still keep most of the important parts of freezed. All classes are immutable. They all have ```copyWith``` functions. There are also some new functions, like ```getChildByName``` and ```fromJsonString``` which we'll discuss in more depth in [Class Structure](class_structure).

Another thing you'll notice, is that there are getters on all the primitive values. This is because FHIR puts requirements on what is considered a Url or a Date, or a DateTime and it doesn't usually align with Dart's perspective. Again, much more in-depth discussion in [Primitive Types](primitive_types). But for now, know that there are getters for almost all of Dart's primitive types to convert them into FHIR primitive types. So you can do ```FhirString('123')``` like we did above for ```id```, OR you can just do ```.toFhirString``` like we did for the names.