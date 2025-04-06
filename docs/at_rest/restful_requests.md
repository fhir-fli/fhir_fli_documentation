---
id: restful_requests
title: Requests
---

# RESTful Requests

The `fhir_r4_at_rest` library provides a streamlined way to construct RESTful API calls for FHIR operations. Instead of dealing with the complexities of building URLs, handling HTTP methods, and managing headers, this library offers a type-safe approach through a collection of request classes.

## Basic Concepts

All request classes in the library inherit from the abstract `FhirRequest` class, which provides common functionality:

- Base URL management
- HTTP headers configuration
- URI construction
- Response handling

## Common Request Structure

All request classes share a similar construction pattern:

```dart
final request = FhirSomeRequest(
  base: Uri.parse('http://hapi.fhir.org/baseR4'), // Base FHIR server URL
  resourceType: 'Patient',                        // The FHIR resource type
  id: '12345',                                   // Resource ID (when applicable)
  headers: {'Authorization': 'Bearer token123'},  // Custom HTTP headers
  parameters: RestfulParameters()                 // Optional request parameters
    .requestPretty()
    .add('_count', '10'),
);

// Execute the request
final response = await request.sendRequest();
```

## Request Types

The library supports all standard FHIR RESTful operations:

### 1. Read Request

Retrieves a specific resource by its ID.

```dart
final request = FhirReadRequest(
  base: Uri.parse('http://hapi.fhir.org/baseR4'),
  resourceType: 'Patient',
  id: '12345',
  headers: {'Authorization': 'Bearer token123'},
);

final response = await request.sendRequest();
// GET http://hapi.fhir.org/baseR4/Patient/12345?_format=json
```

### 2. VRead Request

Retrieves a specific version of a resource.

```dart
final request = FhirVReadRequest(
  base: Uri.parse('http://hapi.fhir.org/baseR4'),
  resourceType: 'Patient',
  id: '12345',
  vid: '2',  // Version ID
  headers: {'Authorization': 'Bearer token123'},
);

final response = await request.sendRequest();
// GET http://hapi.fhir.org/baseR4/Patient/12345/_history/2?_format=json
```

### 3. Update Request

Updates an existing resource.

```dart
final request = FhirUpdateRequest(
  base: Uri.parse('http://hapi.fhir.org/baseR4'),
  resourceType: 'Patient',
  id: '12345',
  resource: {
    'resourceType': 'Patient',
    'id': '12345',
    'name': [
      {
        'given': ['John'],
        'family': 'Doe',
      },
    ],
  },
  headers: {'Authorization': 'Bearer token123'},
);

final response = await request.sendRequest();
// PUT http://hapi.fhir.org/baseR4/Patient/12345?_format=json
```

### 4. Patch Request

Applies a partial update to a resource using JSON Patch.

```dart
final patchBody = PatchBody()
  ..addOperation(
    PatchOps.replace,
    '/name/0/family',
    value: 'Smith',
  );

final request = FhirPatchRequest(
  base: Uri.parse('http://hapi.fhir.org/baseR4'),
  resourceType: 'Patient',
  id: '12345',
  patchBody: patchBody,
  headers: {'Authorization': 'Bearer token123'},
);

final response = await request.sendRequest();
// PATCH http://hapi.fhir.org/baseR4/Patient/12345?_format=json
```

### 5. Delete Request

Deletes a resource by its ID.

```dart
final request = FhirDeleteRequest(
  base: Uri.parse('http://hapi.fhir.org/baseR4'),
  resourceType: 'Patient',
  id: '12345',
  headers: {'Authorization': 'Bearer token123'},
);

final response = await request.sendRequest();
// DELETE http://hapi.fhir.org/baseR4/Patient/12345?_format=json
```

### 6. Create Request

Creates a new resource.

```dart
final request = FhirCreateRequest(
  base: Uri.parse('http://hapi.fhir.org/baseR4'),
  resourceType: 'Patient',
  resource: {
    'resourceType': 'Patient',
    'name': [
      {
        'given': ['John'],
        'family': 'Doe',
      },
    ],
  },
  headers: {'Authorization': 'Bearer token123'},
);

final response = await request.sendRequest();
// POST http://hapi.fhir.org/baseR4/Patient?_format=json
```

### 7. History Request

Retrieves the history of changes to a specific resource.

```dart
final request = FhirHistoryRequest(
  base: Uri.parse('http://hapi.fhir.org/baseR4'),
  resourceType: 'Patient',
  id: '12345',
  headers: {'Authorization': 'Bearer token123'},
);

final response = await request.sendRequest();
// GET http://hapi.fhir.org/baseR4/Patient/12345/_history?_format=json
```

### 8. History All Request

Retrieves the history of changes to all resources.

```dart
final request = FhirHistoryAllRequest(
  base: Uri.parse('http://hapi.fhir.org/baseR4'),
  headers: {'Authorization': 'Bearer token123'},
);

final response = await request.sendRequest();
// GET http://hapi.fhir.org/baseR4/_history?_format=json
```

### 9. Capabilities Request

Retrieves the server's capability statement.

```dart
final request = FhirCapabilitiesRequest(
  base: Uri.parse('http://hapi.fhir.org/baseR4'),
  mode: Mode.normative,  // Optional: full, normative, or terminology
  headers: {'Authorization': 'Bearer token123'},
);

final response = await request.sendRequest();
// GET http://hapi.fhir.org/baseR4/metadata?mode=normative&_format=json
```

### 10. Transaction Request

Submits a bundle of operations to be processed as a single transaction.

```dart
final bundle = Bundle(
  type: BundleType.transaction,
  entry: [
    BundleEntry(
      request: BundleRequest(
        method: HTTPVerb.POST,
        url: FhirUri('Patient'),
      ),
      resource: Patient(
        name: [
          HumanName(
            family: FhirString('Doe'),
            given: [FhirString('John')],
          ),
        ],
      ),
    ),
  ],
);

final request = FhirTransactionRequest(
  base: Uri.parse('http://hapi.fhir.org/baseR4'),
  bundle: bundle.toJson(),
  headers: {'Authorization': 'Bearer token123'},
);

final response = await request.sendRequest();
// POST http://hapi.fhir.org/baseR4?_format=json
```

### 11. Batch Request

Similar to Transaction but allows operations to be processed independently.

```dart
final bundle = Bundle(
  type: BundleType.batch,
  entry: [
    BundleEntry(
      request: BundleRequest(
        method: HTTPVerb.GET,
        url: FhirUri('Patient/12345'),
      ),
    ),
    BundleEntry(
      request: BundleRequest(
        method: HTTPVerb.POST,
        url: FhirUri('Observation'),
      ),
      resource: Observation(
        status: ObservationStatus.final_,
        code: CodeableConcept(
          coding: [
            Coding(
              system: FhirUri('http://loinc.org'),
              code: FhirCode('12345-6'),
            ),
          ],
        ),
      ),
    ),
  ],
);

final request = FhirBatchRequest(
  base: Uri.parse('http://hapi.fhir.org/baseR4'),
  bundle: bundle.toJson(),
  headers: {'Authorization': 'Bearer token123'},
);

final response = await request.sendRequest();
// POST http://hapi.fhir.org/baseR4?_format=json
```

### 12. Operation Request

Invokes a named operation on the server, resource type, or resource instance.

```dart
// Server-level operation
final request = FhirOperationRequest(
  base: Uri.parse('http://hapi.fhir.org/baseR4'),
  operation: 'everything',
  parameters: RestfulParameters()
    .add('start', '2020-01-01')
    .add('end', '2020-12-31'),
  headers: {'Authorization': 'Bearer token123'},
);

// Resource type operation
final typeRequest = FhirOperationRequest(
  base: Uri.parse('http://hapi.fhir.org/baseR4'),
  resourceType: 'Patient',
  operation: 'everything',
  headers: {'Authorization': 'Bearer token123'},
);

// Resource instance operation
final instanceRequest = FhirOperationRequest(
  base: Uri.parse('http://hapi.fhir.org/baseR4'),
  resourceType: 'Patient',
  id: '12345',
  operation: 'everything',
  headers: {'Authorization': 'Bearer token123'},
);

final response = await request.sendRequest();
// GET http://hapi.fhir.org/baseR4/$everything?start=2020-01-01&end=2020-12-31&_format=json
// GET http://hapi.fhir.org/baseR4/Patient/$everything?_format=json
// GET http://hapi.fhir.org/baseR4/Patient/12345/$everything?_format=json
```

## [Request Parameters](docs/at_rest/restful_parameters)

All request classes support optional parameters through the `RestfulParameters` class:

```dart
final parameters = RestfulParameters()
  .requestPretty()                     // Pretty-print the response
  .requestSummary(Summary.true_)       // Request summary data only
  .add('_count', '10')                 // Limit results to 10 items
  .add('_since', '2020-01-01');        // Only include resources modified after this date
  
final request = FhirReadRequest(
  base: Uri.parse('http://hapi.fhir.org/baseR4'),
  resourceType: 'Patient',
  id: '12345',
  parameters: parameters,
);
```

## Working with HTTP Client

By default, the library uses `http.Client()` to make requests. You can provide your own client for custom behavior:

```dart
final customClient = http.Client();

final request = FhirReadRequest(
  base: Uri.parse('http://hapi.fhir.org/baseR4'),
  resourceType: 'Patient',
  id: '12345',
  client: customClient,
);
```

## Handling Responses

The `sendRequest()` method returns a standard `http.Response` object:

```dart
final request = FhirReadRequest(
  base: Uri.parse('http://hapi.fhir.org/baseR4'),
  resourceType: 'Patient',
  id: '12345',
);

try {
  final response = await request.sendRequest();
  
  if (response.statusCode == 200) {
    // Parse the response body
    final patient = Patient.fromJson(
      jsonDecode(response.body),
    );
    // Use the patient resource
  } else {
    // Handle error responses
    print('Error: ${response.statusCode} - ${response.body}');
  }
} catch (e) {
  // Handle network or other exceptions
  print('Exception: $e');
}
```

## Conclusion

The `fhir_r4_at_rest` library simplifies interactions with FHIR servers by providing typed classes for each RESTful operation. This approach improves code readability and reduces the likelihood of errors when constructing FHIR API requests.