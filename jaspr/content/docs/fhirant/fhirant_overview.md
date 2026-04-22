---
id: fhirant_overview
title: Overview
---

## FHIR ANT

**Fast Healthcare Interoperability Resources — Agile Networking Tool**

FHIR ANT is a complete FHIR R4 server that runs on your Android phone. It's built with Dart using the [fhir_r4](../core/fhir_r4) package and designed for mobile-first deployments, testing, and low-resource healthcare settings.

### What It Does

FHIR ANT turns your phone into a fully functional FHIR server. Other devices on the same network can connect to it using standard FHIR REST APIs — just like they would with any cloud-hosted FHIR server.

**Use cases:**
- **Testing & development** — Spin up a FHIR server instantly without cloud infrastructure
- **Demonstrations** — Show FHIR workflows at conferences, meetings, or training sessions
- **Low-resource settings** — Provide FHIR capabilities where internet connectivity is limited or unavailable
- **Education** — Learn FHIR by interacting with a real server on your own device
- **Personal health data** — Store your own health records locally with full privacy

### Architecture

FHIR ANT is a monorepo with four packages:

```
fhirant/
└── packages/
    ├── fhirant/               # Flutter mobile app (Android)
    ├── fhirant_server/        # HTTP server (Shelf-based)
    ├── fhirant_db/            # Database (Drift/SQLite + SQLCipher)
    └── fhirant_logging/       # JSON logging service
```

- **fhirant_server** handles routing, middleware, and all FHIR operations
- **fhirant_db** extends [fhir_r4_db](../fhir_r4_db) with server-specific tables (users, export jobs, authorization codes, revoked tokens)
- The server is pure Dart — it can also run as a CLI process on any platform
- The database is encrypted with SQLCipher; the encryption key is stored in the device's secure keystore

### Quick Start

1. Install the app on your Android device
2. On first launch, walk through the onboarding screens
3. Optionally load sample clinical data (MIMIC-IV subset)
4. Tap **Start** to launch the server
5. Note the URL shown on the Network Info card (e.g., `http://192.168.1.42:8080`)
6. From any device on the same network, try:

```bash
# Get the server's capabilities
curl http://192.168.1.42:8080/metadata

# Search for patients
curl http://192.168.1.42:8080/Patient

# Create a patient
curl -X POST http://192.168.1.42:8080/Patient \
  -H "Content-Type: application/fhir+json" \
  -d '{"resourceType":"Patient","name":[{"family":"Smith","given":["John"]}]}'
```

### Dev Mode

By default, the app starts in **Dev Mode** — authentication is disabled, and all requests are accepted. This is ideal for testing and exploration. Toggle it off in the server control card to require JWT authentication.
