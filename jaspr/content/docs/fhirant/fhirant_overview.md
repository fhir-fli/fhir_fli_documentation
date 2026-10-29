---
id: fhirant_overview
title: Overview
---

**Fast Healthcare Interoperability Resources — Agile Networking Tool**

FHIR ANT is a FHIR R4 server that runs on your Android phone. It speaks FHIR R4B (4.3.0), the version the [fhir_r4](docs/core/fhir_r4) package implements, and its CapabilityStatement says so. It is built with Dart and designed for mobile-first deployments, testing, and low-resource healthcare settings.

FHIR ANT is pre-release. There is no public download yet: Android builds go directly to testers (see [Getting Started](docs/fhirant/fhirant_getting_started)).

## What It Does

FHIR ANT turns your phone into a FHIR server. Other devices on the same network connect to it with the standard FHIR REST API, as they would to any hosted FHIR server.

**Use cases:**
- **Testing & development** — Spin up a FHIR server instantly without cloud infrastructure
- **Demonstrations** — Show FHIR workflows at conferences, meetings, or training sessions
- **Low-resource settings** — Provide FHIR capabilities where internet connectivity is limited or unavailable
- **Education** — Learn FHIR by interacting with a real server on your own device

## Architecture

FHIR ANT is a monorepo with five packages:

```
fhirant/
└── packages/
    ├── fhirant/                # Flutter mobile app (Android)
    ├── fhirant_server/         # HTTP server (Shelf-based)
    ├── fhirant_db/             # Database (Drift/SQLite, encrypted)
    ├── fhirant_logging/        # JSON logging service
    └── fhirant_secure_storage/ # Keys and the TLS identity in platform secure storage
```

- **fhirant_server** handles routing, middleware, and all FHIR operations
- **fhirant_db** extends `FhirDb` from [fhir_r4_db](docs/fhir_r4_db) with the server's own tables (users, OAuth clients, authorization codes, revoked tokens, export jobs, spec loads)
- The server is pure Dart — it also runs as a [CLI process](docs/fhirant/fhirant_cli) on any platform Dart supports
- The database is encrypted in the SQLCipher 4 format (AES-256) through SQLite3 Multiple Ciphers. In the app the key is generated on first launch and kept in the device's secure storage
- It is built on the FHIR-FLI packages from pub.dev: `fhir_r4`, `fhir_r4_bulk`, `fhir_r4_cql`, `fhir_r4_mapping`, `fhir_r4_path`, `fhir_r4_validation` (^0.14.0), `fhir_db` (^0.15.2), `fhir_node` (^0.6.1) and `cql` (^0.8.0)

## Quick Start

1. Install the app on your Android device
2. On first launch, walk through the onboarding screens
3. Optionally load sample clinical data (MIMIC-IV subset)
4. Tap **Start** to launch the server
5. Note the URL shown on the Network card (e.g., `https://192.168.1.42:8080`) and the certificate fingerprint under it
6. From any device on the same network, try:

```bash
# The app serves HTTPS with a self-signed certificate. -k skips the
# certificate check for a quick try; a real client should pin the
# SHA-256 fingerprint the Network card shows.

# Get the server's capabilities
curl -k https://192.168.1.42:8080/metadata

# Search for patients
curl -k https://192.168.1.42:8080/Patient

# Create a patient
curl -k -X POST https://192.168.1.42:8080/Patient \
  -H "Content-Type: application/fhir+json" \
  -d '{"resourceType":"Patient","name":[{"family":"Smith","given":["John"]}]}'
```

## Experimentation and Secure Modes

A fresh install starts in **Experimentation mode**: authentication is off and every request is accepted. It is for test data only, and the app shows a standing warning while it is on. With the server stopped, switch the **Authentication** setting on the server control card to **Secure** to require JWT authentication; if there is no administrator yet, the app asks you to create one first. The mode you choose is remembered.
