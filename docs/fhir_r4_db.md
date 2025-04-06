---
id: fhir_r4_db
title: Database Package
---

# FHIR R4 Database

The package for local storage of FHIR resources. The `fhir_r4_db` library provides a lightweight, encrypted local database solution for storing and managing FHIR resources in Flutter applications. Built as a wrapper around `hive_ce`, this library offers a simple, type-safe API for common database operations with specific optimizations for FHIR data.

## Installation

```yaml
dependencies:
  fhir_r4_db: ^0.3.0
  fhir_r4: ^0.3.0
```

## Key Features

- **In-memory performance**: Lightning-fast operations with minimal setup
- **Always encrypted**: Data is secured by default with optional custom encryption
- **Cross-platform**: Works on all platforms supported by Flutter without special configurations
- **Version tracking**: Automatic versioning of resources with history support
- **Reactive updates**: Stream-based API for observing database changes
- **FHIR-optimized**: Special handling for FHIR resources and canonical references

### Initialization

```dart
import 'package:fhir_r4_db/fhir_r4_db.dart';

// Initialize the database without encryption
await FhirDb().init();

// Or with a custom path and encryption key
await FhirDb().init(
  path: 'path/to/db',
  pw: 'your-encryption-key'
);
```

## Basic Operations

### Saving Resources

```dart
// Save a single resource
final patient = Patient(
  name: [
    HumanName(
      family: 'Doe'.toFhirString,
      given: ['John'.toFhirString],
    ),
  ],
);

// The save method adds an ID if none exists and updates the meta fields
final savedPatient = await FhirDb().save(resource: patient);

// Save multiple resources
final resources = [patient, observation, condition];
await FhirDb().saveAll(resources: resources);
```

### Reading Resources

```dart
// Retrieve a resource by type and ID
final patient = await FhirDb().get(
  resourceType: R4ResourceType.Patient,
  id: '12345',
);

// Check if a resource exists
final exists = await FhirDb().exists(
  resourceType: R4ResourceType.Patient,
  id: '12345',
);
```

### Searching Resources

```dart
// Find resources by type and field value
final patients = await FhirDb().find(
  resourceType: R4ResourceType.Patient,
  field: ['name', 0, 'family'],
  value: 'Doe',
);

// Custom search with a finder function
final activePatients = await FhirDb().search(
  resourceType: R4ResourceType.Patient,
  finder: (resource) => resource['active'] == true,
);

// Get all resources of specified types
final allPatients = await FhirDb().getActiveResourcesOfType(
  resourceTypes: [R4ResourceType.Patient],
);

// Get all resources in the database
final allResources = await FhirDb().getAllActiveResources();
```

### Deleting Resources

```dart
// Delete a resource by type and ID
await FhirDb().delete(
  resourceType: R4ResourceType.Patient,
  id: '12345',
);

// Delete all resources of a type
await FhirDb().deleteSingleType(
  resourceType: R4ResourceType.Patient,
);

// Delete all resources in the database
await FhirDb().deleteAllResources();
```

## Advanced Features

### Resource Versioning and History

The database automatically manages resource versions when updating:

```dart
// Save a resource initially
final patient = await FhirDb().save(resource: patient);

// Update the resource
patient.active = FhirBoolean(true);
final updatedPatient = await FhirDb().save(resource: patient);

// The updated resource has an incremented versionId
print(updatedPatient.meta?.versionId); // Incremented version

// Previous versions are accessible in the history
```

You can configure version IDs to use timestamps instead of incremental numbers:

```dart
// Enable timestamp-based versioning
FhirDb().versionIdAsTime = true;
```

### Syncing Support

For applications requiring offline-first capabilities with later synchronization:

```dart
// Enable storing resources for sync
FhirDb().storeForSync = true;

// Later, retrieve resources that need syncing
final syncResources = await FhirDb().getSync();

// Clear the sync queue after successful server sync
await FhirDb().clearSync();
```

### Reactive Database Updates

Subscribe to resource changes using RxDart BehaviorSubjects:

```dart
// Get a subject that emits patient changes
final patientSubject = FhirDb().subject(
  resourceType: R4ResourceType.Patient,
  id: '12345',
);

// Listen for changes
patientSubject.listen((patient) {
  if (patient != null) {
    // Handle updated patient
  } else {
    // Handle patient deletion
  }
});
```

Subscribe to all sync events:

```dart
final syncSubject = FhirDb().listenSync();
syncSubject.listen((resource) {
  // Handle resource changes for sync
});
```

### Working with Canonical Resources

You can store Canonical Resources in their own Boxes just as you do with any other Resource. However, that stores them by ID, and often with Canonical resources, they are searched by URI. This is a single box that contains only different types of canonical resources, stored by URI (useful if you need a local Canonical Resource Cache):

```dart
// Save a canonical resource (e.g., a ValueSet)
await FhirDb().saveCanonicalResource(resource: valueSet);

// Retrieve a canonical resource by URL
final valueSet = await FhirDb().getCanonicalResource(
  url: 'http://example.org/fhir/ValueSet/my-codes',
);

// Get all canonical resources of a specific type
final allValueSets = await FhirDb().getAllCanonicalByType<ValueSet>(
  type: R4ResourceType.ValueSet,
);
```

### General Storage

For non-FHIR data:

```dart
// Save arbitrary objects
final key = await FhirDb().saveGeneral(object: {'name': 'Test'});

// Retrieve by key
final object = await FhirDb().readGeneral(key: key);

// Search general objects
final results = await FhirDb().searchGeneral(
  finder: (obj) => (obj as Map)['name'] == 'Test',
);

// Delete or clear general storage
await FhirDb().deleteFromGeneral(key: key);
await FhirDb().clearGeneral();
```

## Encryption

The database is encrypted by default, but you can provide your own encryption key:

```dart
// Initialize with encryption
await FhirDb().init(pw: 'secure-password');

// Update the encryption key
await FhirDb().updatePw(oldPw: 'old-password', newPw: 'new-password');
```

The library uses HMAC-SHA256 to derive secure encryption keys from passwords.

## Performance Considerations

While the in-memory database offers exceptional performance, be mindful of resource usage:

- The database keeps all data in memory, making it very fast
- Large datasets (e.g., 20GB of FHIR data) will work, but require sufficient RAM
- For mobile applications, consider data volume constraints
- Periodically close unused boxes for optimal memory management with large datasets

```dart
// Close specific resource type boxes
await FhirDb().closeResourceBoxes(types: [R4ResourceType.Patient]);

// Close specific boxes
await FhirDb().closeHistoryBox();
await FhirDb().closeGeneralBox();

// Close all boxes
await FhirDb().closeAllBoxes();
```

## Example

A complete example of using the database in a Flutter application:

```dart
import 'package:fhir_r4/fhir_r4.dart';
import 'package:fhir_r4_db/fhir_r4_db.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize the database
  await FhirDb().init(pw: 'secure-password');
  
  // Enable versioning and sync features
  FhirDb().versionIdAsTime = true;
  FhirDb().storeForSync = true;
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PatientListScreen(),
    );
  }
}

class PatientListScreen extends StatefulWidget {
  @override
  _PatientListScreenState createState() => _PatientListScreenState();
}

class _PatientListScreenState extends State<PatientListScreen> {
  List<Patient> patients = [];
  
  @override
  void initState() {
    super.initState();
    _loadPatients();
  }
  
  Future<void> _loadPatients() async {
    final resources = await FhirDb().getActiveResourcesOfType(
      resourceTypes: [R4ResourceType.Patient],
    );
    
    setState(() {
      patients = resources.map((r) => r as Patient).toList();
    });
  }
  
  Future<void> _addPatient() async {
    final patient = Patient(
      name: [
        HumanName(
          family: 'Doe'.toFhirString,
          given: ['John'.toFhirString],
        ),
      ],
      birthDate: FhirDate('1970-01-01'),
    );
    
    await FhirDb().save(resource: patient);
    _loadPatients();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Patient List')),
      body: ListView.builder(
        itemCount: patients.length,
        itemBuilder: (context, index) {
          final patient = patients[index];
          return ListTile(
            title: Text(patient.name?.first.family?.value ?? 'Unnamed'),
            subtitle: Text(patient.id?.value ?? ''),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                await FhirDb().delete(resource: patient);
                _loadPatients();
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addPatient,
        child: Icon(Icons.add),
      ),
    );
  }
}
```

This example demonstrates a basic patient management application using the FHIR database for local storage, with the ability to add and delete patients.

### Benchmarking

This is not true benchmarking, its purely to give an idea of what you can expect if you're using this. I'm running it on my computer, and I stored the OPEN FHIR data set [MIMIC-IV Clinical Database Demo on FHIR](https://physionet.org/content/mimic-iv-fhir-demo/2.0/). It contains 876.2 MB of data, or about ~900,000 FHIR resources. It took about 15 minutes to load all of that into the database (because there's no good bulk load option). 