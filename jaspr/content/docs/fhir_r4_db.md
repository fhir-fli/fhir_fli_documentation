---
id: fhir_r4_db
title: Database Package
---

## FHIR R4 Database

The `fhir_r4_db` library provides a local database solution for storing and managing FHIR resources in Dart and Flutter applications. Built on [Drift](https://drift.simonbinder.eu/) (SQLite), it offers type-safe CRUD operations, FHIR search parameter indexing, resource versioning, sync tracking, and optional encryption via SQLCipher.

### Installation

```yaml
dependencies:
  fhir_r4_db: ^0.6.0
  fhir_r4: ^0.6.1
  drift: ^2.33.0
  sqlite3: ^3.1.5
```

`sqlite3` 3.x loads its native SQLite library through Dart build hooks, so no separate platform-specific SQLite opener package is required. See [Encrypted Database](#encrypted-database) below for how the same mechanism provides SQLCipher-compatible encryption.

### Key Features

- **SQLite-backed**: Persistent, file-based storage with excellent performance, plus in-memory mode for tests
- **Search parameter indexing**: Automatic indexing of FHIR search parameters into typed search tables (string, token, reference, date, number, quantity, URI, composite, special)
- **FHIR search**: Query by search parameters, including `_id`, `_lastUpdated`, `_tag`, `_profile`, `_security`, `_source`, `:missing`, chained references, and `_has` reverse chaining
- **Version tracking**: Automatic versioning of resources with full history; deletes are recorded as tombstone history entries
- **Sync support**: Track resources that need syncing to a remote server
- **Canonical resource cache**: Store and retrieve canonical resources (ValueSet, StructureDefinition, etc.) by URL
- **Optional encryption**: SQLCipher (AES-256) with a PBKDF2-HMAC-SHA256 derived key
- **Cross-platform**: Works on all platforms supported by Drift (Android, iOS, macOS, Windows, Linux, Web)

### Architecture

The database uses Drift's DAO (Data Access Object) pattern:

- **`FhirDb`** — The Drift database class. You create it by passing a `QueryExecutor` (e.g., `NativeDatabase`).
- **`FhirDao`** — The DAO that provides all FHIR operations (CRUD, search, history, sync, canonical resources, general storage), accessed via `db.fhirDao`.

#### Initialization

```dart
import 'dart:io';
import 'package:drift/native.dart';
import 'package:fhir_r4/fhir_r4.dart';
// Hide Resource: fhir_r4_db also exports a Drift row class named `Resource`.
import 'package:fhir_r4_db/fhir_r4_db.dart' hide Resource;

// Create a database with a file-based SQLite backend
final db = FhirDb(NativeDatabase(File('fhir.db')));

// Access the DAO for all operations
final dao = db.fhirDao;

// For tests, use an in-memory database
final testDb = FhirDb(NativeDatabase.memory());
final testDao = testDb.fhirDao;
```

#### Encrypted Database

Encryption is provided by SQLCipher. First, tell the `sqlite3` build hooks to compile the SQLCipher-compatible [SQLite3MultipleCiphers](https://utelle.github.io/SQLite3MultipleCiphers/) library instead of plain SQLite by declaring this in **your app's** `pubspec.yaml`:

```yaml
hooks:
  user_defines:
    sqlite3:
      source: sqlite3mc
```

Then derive a key from a password with `deriveDbKey` (PBKDF2-HMAC-SHA256, 100,000 iterations) and enable encryption at construction time with `cipherSetup`, which applies the SQLCipher-compatibility PRAGMAs (`PRAGMA cipher = 'sqlcipher'; PRAGMA legacy = 4; PRAGMA key = ...;`) in the `NativeDatabase` setup callback:

```dart
import 'dart:io';
import 'package:drift/native.dart';
import 'package:fhir_r4_db/fhir_r4_db.dart' hide Resource;

const dir = '/path/to/db';
final hexKey = await deriveDbKey(password: 'secure-password', dbPath: dir);

final db = FhirDb(
  NativeDatabase(
    File('$dir/fhir.sqlite'),
    setup: cipherSetup(hexKey),
  ),
);
```

`deriveDbKey` returns `null` (and `cipherSetup(null)` is a no-op) when no password is supplied, so the same code path works with and without encryption.

### Basic Operations

#### Saving Resources

```dart
import 'package:fhir_r4/fhir_r4.dart';

// Save a single resource
final patient = Patient(
  name: [
    HumanName(
      family: 'Doe'.toFhirString,
      given: ['John'.toFhirString],
    ),
  ],
);

// saveResource() assigns an ID if none exists and updates meta
// (versionId, lastUpdated)
final savedPatient = await dao.saveResource(patient);

// Save multiple resources in a batch (more efficient)
final resources = [patient1, observation1, condition1];
final success = await dao.saveResources(resources);
```

#### Reading Resources

```dart
// Retrieve a resource by type and ID
final patient = await dao.getResource(
  R4ResourceType.Patient,
  '12345',
);

// Check if a resource exists
final exists = await dao.exists(
  R4ResourceType.Patient,
  '12345',
);

// Get all resources of a type (most recent first)
final allPatients = await dao.getResourcesByType(
  R4ResourceType.Patient,
);

// Paginated retrieval
final page = await dao.getResourcesWithPagination(
  resourceType: R4ResourceType.Patient,
  count: 20,
  offset: 0,
);

// Count resources of a type
final count = await dao.getResourceCount(R4ResourceType.Patient);

// List all resource types in the database
final types = await dao.getResourceTypes();
```

#### Searching Resources

Saved resources are indexed into typed search tables, so you can query by FHIR search parameters. Each parameter maps to a *list* of values:

```dart
// Search patients by name
final patients = await dao.search(
  resourceType: R4ResourceType.Patient,
  searchParameters: {
    'name': ['Doe'],
  },
);

// Search with multiple parameters
final observations = await dao.search(
  resourceType: R4ResourceType.Observation,
  searchParameters: {
    'patient': ['Patient/12345'],
    'code': ['http://loinc.org|85354-9'],
    'date': ['ge2024-01-01'],
  },
);

// Count search results
final resultCount = await dao.searchCount(
  resourceType: R4ResourceType.Observation,
  searchParameters: {
    'patient': ['Patient/12345'],
  },
);
```

`search` also accepts optional `count`, `offset`, and `sort` arguments for paging and ordering results.

`_has` reverse chaining is supported via `HasParameter`:

```dart
// Patients referenced by an Observation whose code is 1234-5
final has = HasParameter.parse('_has:Observation:patient:code', '1234-5');
final patients = await dao.search(
  resourceType: R4ResourceType.Patient,
  hasParameters: [has!],
);
```

Supported search parameter types:
- **String** (`name`, `address`, etc.) — case-insensitive prefix matching
- **Token** (`code`, `identifier`, etc.) — system|code matching
- **Reference** (`patient`, `subject`, etc.) — reference resolution, including chained references
- **Date** (`date`, `birthdate`, etc.) — date range comparisons (eq, ne, gt, lt, ge, le, sa, eb, ap)
- **Number** (`length`, etc.) — numeric comparisons
- **Quantity** (`value-quantity`, etc.) — quantity with unit matching
- **URI** (`url`, etc.) — URI matching
- **Composite** — combined parameter searches
- **Special** (`_id`, `_lastUpdated`, `_tag`, `_profile`, `_security`, `_source`, `:missing`, `_has`) — special FHIR parameters

#### Deleting Resources

```dart
// Delete a resource by type and ID.
// Writes a tombstone history entry, then removes the current row.
final deleted = await dao.deleteResource(
  R4ResourceType.Patient,
  '12345',
);
```

### Advanced Features

#### Resource Versioning and History

The database automatically manages resource versions on each save:

```dart
// Save creates version 1
final v1 = await dao.saveResource(patient);
print(v1.meta?.versionId); // "1"

// Saving again increments the version
final updated = v1.copyWith(active: FhirBoolean(true));
final v2 = await dao.saveResource(updated);
print(v2.meta?.versionId); // "2"

// Retrieve version history (most recent first)
final history = await dao.getResourceHistory(
  R4ResourceType.Patient,
  '12345',
);
```

Use timestamp-based versioning instead of incrementing integers:

```dart
dao.versionIdAsTime = true;
```

#### Sync Support

Track resources that need syncing to a remote server:

```dart
// Enable sync tracking
dao.storeForSync = true;

// Save resources — they'll be queued for sync automatically
await dao.saveResource(patient);

// Retrieve resources pending sync
final pendingSync = await dao.getSync();

// Clear the sync queue after successful upload
await dao.clearSync();

// Or observe the sync queue reactively
final subscription = dao.watchSync().listen((resources) {
  // handle changes
});
```

#### Canonical Resource Cache

Store canonical resources (ValueSet, StructureDefinition, etc.) indexed by URL:

```dart
// Save a canonical resource (keyed by its url)
await dao.saveCanonicalResource(valueSet);

// Retrieve by URL
final vs = await dao.getCanonicalResource(
  'http://example.org/fhir/ValueSet/my-codes',
);

// Check if a canonical key exists
final hasIt = await dao.containsCanonicalKey(
  'http://example.org/fhir/ValueSet/my-codes',
);

// List all canonical keys
final keys = await dao.listCanonicalKeys();

// Get all canonical resources of a given type
final valueSets =
    await dao.getAllCanonicalByType<ValueSet>(R4ResourceType.ValueSet);
```

#### General Storage

Store arbitrary (non-FHIR) data in the database. Values are stored as strings, so serialize structured data yourself:

```dart
import 'dart:convert';

// Save arbitrary data (returns an integer key)
final key = await dao.saveGeneral(value: jsonEncode({'name': 'Test'}));

// Read by key
final data = await dao.readGeneral(key);

// Get all general storage rows
final allEntries = await dao.getAllGeneral();

// Delete by key
await dao.deleteFromGeneral(key);

// Clear all general storage
await dao.clearGeneral();
```

### Example

A complete example using the database in a Dart application:

```dart
import 'dart:io';
import 'package:drift/native.dart';
import 'package:fhir_r4/fhir_r4.dart';
import 'package:fhir_r4_db/fhir_r4_db.dart' hide Resource;

Future<void> main() async {
  // Create the database
  final db = FhirDb(NativeDatabase(File('example.db')));
  final dao = db.fhirDao;

  // Save a patient
  final patient = Patient(
    name: [
      HumanName(
        family: 'Doe'.toFhirString,
        given: ['John'.toFhirString],
      ),
    ],
    birthDate: '1970-01-01'.toFhirDate,
  );
  final saved = await dao.saveResource(patient);
  print('Saved patient: ${saved.id}');

  // Search for patients
  final results = await dao.search(
    resourceType: R4ResourceType.Patient,
    searchParameters: {
      'name': ['Doe'],
    },
  );
  print('Found ${results.length} patients');

  // Get history
  final history = await dao.getResourceHistory(
    R4ResourceType.Patient,
    saved.id!.valueString!,
  );
  print('${history.length} versions');

  // Clean up
  await db.close();
}
```

#### Performance

The SQLite backend provides excellent performance. On a test machine (AMD Ryzen 7 PRO, 64 GB RAM, Linux), loading the [MIMIC-IV Clinical Database Demo on FHIR](https://physionet.org/content/mimic-iv-fhir-demo/2.0/) (876 MB, ~899,000 resources) takes about 4 minutes, and searching for individual resources completes in under 10ms.
