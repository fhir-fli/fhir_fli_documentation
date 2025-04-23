---
id: fhir_r4_bulk
title: Bulk Data
---

# FHIR Bulk Operations

The `fhir_r4_bulk` library provides tools for working with FHIR bulk data operations, including import, export, and NDJSON file handling. This library is particularly useful for working with large datasets in FHIR, supporting the standard FHIR bulk operations ([$export](https://hl7.org/fhir/uv/bulkdata/export.html) and [$import](https://hl7.org/fhir/uv/bulkdata/import/index.html)).

## Installation

```yaml
dependencies:
  fhir_r4_bulk: ^0.4.0
  fhir_r4: ^0.4.2
```

## Key Features

- Convert between FHIR resources and NDJSON format
- Handle compressed files (zip, tar.gz, gzip)
- Execute FHIR Bulk Data Export operations ($export)
- Execute FHIR Bulk Data Import operations ($import)

## NDJSON Operations

NDJSON (Newline Delimited JSON) is the standard format for FHIR bulk data. The `FhirBulk` class provides utilities for converting between FHIR resources and NDJSON:

```dart
import 'package:fhir_r4/fhir_r4.dart';
import 'package:fhir_r4_bulk/fhir_r4_bulk.dart';

// Convert resources to NDJSON
final resources = <Resource>[patient1, patient2, observation1];
final ndjsonString = FhirBulk.toNdJson(resources);

// Convert NDJSON to resources
final parsedResources = FhirBulk.fromNdJson(ndjsonString);
```

### Working with Files

The library supports reading and writing NDJSON files:

```dart
// Read NDJSON from a file
final resources = await FhirBulk.fromFile('/path/to/patients.ndjson');

// Read from compressed files
final resourcesFromZip = await FhirBulk.fromCompressedFile('/path/to/data.zip');
final resourcesFromGz = await FhirBulk.fromCompressedFile('/path/to/data.gz');
final resourcesFromTarGz = await FhirBulk.fromCompressedFile('/path/to/data.tar.gz');
```

### Creating Compressed Files

You can also create compressed NDJSON files:

```dart
// Create a map of resource type -> NDJSON content
final ndJsonMap = {
  'Patient': FhirBulk.toNdJson(patients),
  'Observation': FhirBulk.toNdJson(observations),
};

// Create a ZIP file
final zipBytes = await FhirBulk.toZipFile(ndJsonMap);

// Create a GZIP file
final gzipBytes = FhirBulk.toGZipFile(ndJsonMap);

// Create a TAR.GZ file
final tarGzBytes = await FhirBulk.toTarGzFile(ndJsonMap);

// Write to a file
await File('export.zip').writeAsBytes(zipBytes!);
```

## Bulk Export

The FHIR Bulk Data Export operation (`$export`) allows you to retrieve large amounts of data from a FHIR server. The library supports three types of export:

1. **System-level export** - Export data for all patients
2. **Group-level export** - Export data for patients in a specific group
3. **Patient-level export** - Export data for all patients

```dart
import 'package:fhir_r4/fhir_r4.dart';
import 'package:fhir_r4_bulk/fhir_r4_bulk.dart';

// System-level export
final systemRequest = BulkRequestSystem(
  base: Uri.parse('https://example.com/fhir'),
  since: FhirDateTime('2023-01-01'),
  types: [
    WhichResource(R4ResourceType.Patient),
    WhichResource(R4ResourceType.Observation),
  ],
  headers: {'Authorization': 'Bearer token'},
);

// Group-level export
final groupRequest = BulkRequestGroup(
  base: Uri.parse('https://example.com/fhir'),
  id: FhirId('diabetes-group'),
  types: [
    WhichResource(R4ResourceType.Patient),
    WhichResource(R4ResourceType.Observation),
  ],
);

// Patient-level export
final patientRequest = BulkRequestPatient(
  base: Uri.parse('https://example.com/fhir'),
  types: [
    WhichResource(R4ResourceType.Observation),
    WhichResource(R4ResourceType.MedicationRequest),
  ],
);

// Execute the request (choose one)
final resources = await systemRequest.request();
```

### Export Options

The export operation supports several options:

```dart
// Advanced options
final request = BulkRequestSystem(
  base: Uri.parse('https://example.com/fhir'),
  // Only include resources updated since this date
  since: FhirDateTime('2023-01-01'),
  // Specific resource types to include
  types: [WhichResource(R4ResourceType.Patient)],
  // Additional filters (server-dependent)
  typeFilters: ['Patient?gender=female'],
  // Change output format (default is NDJSON)
  outputFormat: 'application/fhir+ndjson',
  // Use HTTP POST instead of GET (newer servers)
  useHttpPost: true,
  // Add authorization or other headers
  headers: {'Authorization': 'Bearer token'},
);
```

### Handling Results

The result is a list of FHIR resources:

```dart
final resources = await request.request();

// Check for errors (OperationOutcome)
for (final resource in resources) {
  if (resource is OperationOutcome) {
    print('Error: ${resource.issue?.first.diagnostics?.value}');
  }
}

// Process resources by type
final patients = resources.whereType<Patient>();
final observations = resources.whereType<Observation>();

print('Exported ${patients.length} patients');
print('Exported ${observations.length} observations');
```

## Bulk Import

The FHIR Bulk Data Import operation (`$import`) allows you to load large amounts of data into a FHIR server:

```dart
import 'package:fhir_r4/fhir_r4.dart';
import 'package:fhir_r4_bulk/fhir_r4_bulk.dart';

// Define the NDJSON files to import
final importFiles = [
  ImportFile(
    resourceType: R4ResourceType.Patient,
    url: Uri.parse('https://example.com/patients.ndjson'),
  ),
  ImportFile(
    resourceType: R4ResourceType.Observation,
    url: Uri.parse('https://example.com/observations.ndjson'),
  ),
];

// Create the import request
final importRequest = BulkImportRequest(
  base: Uri.parse('https://example.com/fhir'),
  files: importFiles,
  // Optional source information
  inputSource: 'https://source-system.org',
  // If the NDJSON files require authentication
  credentialHttpBasic: 'username:password',
  // Control the batch size
  maxBatchResourceCount: 1000,
  // Add authorization or other headers
  headers: {'Authorization': 'Bearer token'},
);

// Execute the import
final outcome = await importRequest.importData();

// Check the outcome
if (outcome.issue != null && outcome.issue!.isNotEmpty) {
  // The operation outcome typically contains a job ID in the diagnostics
  final jobId = outcome.issue!.first.diagnostics?.value;
  print('Import job started with ID: $jobId');
}
```

The server typically responds with an `OperationOutcome` containing a job ID that you can use to poll for status.

## Performance Considerations

- Bulk operations are designed for large datasets
- The NDJSON processing is memory-efficient, handling resources one at a time
- For very large files, consider streaming approaches when possible
- The library automatically handles paginated responses from servers

## Error Handling

Both import and export operations return FHIR `OperationOutcome` resources in case of errors:

```dart
final resources = await bulkRequest.request();

// Check for errors
for (final resource in resources) {
  if (resource is OperationOutcome) {
    for (final issue in resource.issue ?? []) {
      print('Error: ${issue.severity?.value} - ${issue.diagnostics?.value}');
    }
  }
}
```

## Conclusion

The `fhir_r4_bulk` library provides comprehensive support for FHIR bulk data operations, making it easier to work with large FHIR datasets in Dart and Flutter applications. Whether you're extracting data from a server or loading data into one, this library provides the tools you need to work efficiently with FHIR bulk data.