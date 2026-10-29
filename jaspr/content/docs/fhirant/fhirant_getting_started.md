---
id: fhirant_getting_started
title: FHIR ANT Getting Started
---

This guide walks you through your first session with FHIR ANT — from installation to making authenticated API calls.

## Install

FHIR ANT is pre-release and has no public download. Testers receive the Android build (Android 7.0 or newer) directly; [INSTALL.md](https://github.com/fhir-fli/fhirant/blob/main/INSTALL.md) in the repository explains installing it. The server also runs as a standalone CLI process (see [CLI Usage](docs/fhirant/fhirant_cli)).

## First Launch

When you open the app for the first time, you'll see a three-page onboarding:

1. **Welcome** — what FHIR ANT is
2. **How It Works** — starting the server, connecting from another device, Experimentation vs Secure mode, backup and restore
3. **Load Sample Data?** — optionally load a set of realistic clinical data (MIMIC-IV subset) to explore with

You can always load or clear sample data later. Tap **Get Started** to reach the dashboard.

## The Dashboard

The dashboard has five cards:

- **FHIR Server** — start/stop the server, set the port, choose Experimentation or Secure mode, keep it running in the background
- **Network** — the server's URL, its certificate fingerprint, and a QR code carrying both for other devices to scan
- **Resources** — how many FHIR resources are stored, by type
- **Backup** — export every record to a passphrase-protected file, or restore one
- **Request Log** — live feed of incoming HTTP requests

## Starting the Server

Tap **Start** on the FHIR Server card. The server binds to all network interfaces on the configured port (default 8080). The URL will look something like:

```
https://192.168.1.42:8080
```

Any device on the same Wi-Fi network can reach this URL. The app serves HTTPS only, with a self-signed certificate: a client should pin the SHA-256 fingerprint the Network card shows. The examples below use `curl -k`, which skips the certificate check, for a quick try only.

### Experimentation vs Secure Mode

A fresh install starts in **Experimentation mode** — authentication is disabled and all requests are accepted. It is for test data only.

To require authentication, stop the server and switch **Authentication** to **Secure**. When there is no administrator yet, the app asks you to create one. In Secure mode, all non-public endpoints require a valid JWT token.

## Using Experimentation Mode

With Experimentation mode on, you can immediately start making requests:

```bash
# Server capabilities
curl -k https://192.168.1.42:8080/metadata

# Search for all patients
curl -k https://192.168.1.42:8080/Patient

# Create a patient
curl -k -X POST https://192.168.1.42:8080/Patient \
  -H "Content-Type: application/fhir+json" \
  -d '{"resourceType":"Patient","name":[{"family":"Smith","given":["John"]}]}'
```

No tokens or credentials needed — every request is treated as an admin. Registering accounts is refused in this mode.

## Setting Up Authentication

When you're ready to use auth, stop the server, switch to Secure mode, and start it again.

### Step 1: Check Server Status

The `/auth/status` endpoint is public and tells you whether any users exist. On a fresh CLI server with authentication on:

```bash
curl http://localhost:8080/auth/status
```

```json
{"firstUser": true, "bootstrapTokenRequired": true}
```

`"firstUser": true` means no users have been created yet; `"bootstrapTokenRequired": true` means the first registration must carry the server's bootstrap token.

### Step 2: Create the Admin Account

**In the app**, you create the administrator in the dialog that appears when you switch to Secure mode; skip to Step 3 and log in with it.

**On the CLI**, either start the server with `FHIRANT_ADMIN_USERNAME` and `FHIRANT_ADMIN_PASSWORD` set, or register the first account with the one-time bootstrap token the server prints at start (it is also in `<db-path>/.bootstrap_token`). The first user is **automatically promoted to admin** regardless of what role you request:

```bash
curl -X POST http://localhost:8080/auth/register \
  -H "Content-Type: application/json" \
  -H "X-Bootstrap-Token: <token from the server log>" \
  -d '{"username": "admin", "password": "mysecurepassword"}'
```

```json
{
  "id": 1,
  "token": "eyJ...",
  "refresh_token": "eyJ...",
  "token_type": "Bearer",
  "username": "admin",
  "role": "admin",
  "scopes": ["system/*.*"]
}
```

Registration returns a JWT immediately — you're logged in. Without the token, the first registration is refused (403).

<Info>
**Password Requirements**

Passwords must be 12-128 characters. There are no complexity rules (no required uppercase, numbers, or symbols), but common passwords like `password123456` are blocked. This follows [NIST 800-63B](https://pages.nist.gov/800-63-3/sp800-63b.html) guidelines — length matters more than complexity.
</Info>

### Step 3: Make Authenticated Requests

Use the `token` from registration or login in the `Authorization` header (the examples from here use `$BASE` for your server's URL; add `-k` for the app's self-signed certificate):

```bash
TOKEN="eyJ..."

# Search patients
curl -H "Authorization: Bearer $TOKEN" \
  $BASE/Patient

# Create a resource
curl -X POST $BASE/Observation \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/fhir+json" \
  -d '{
    "resourceType": "Observation",
    "status": "final",
    "code": {"text": "Heart rate"},
    "valueQuantity": {"value": 72, "unit": "bpm"}
  }'
```

### Step 4: Register Additional Users

Once the admin account exists, only admins can create new users. Use the admin token and optionally specify a role:

```bash
# Create a clinician (default role)
curl -X POST $BASE/auth/register \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"username": "drjones", "password": "anothersecurepassword"}'

# Create a read-only user
curl -X POST $BASE/auth/register \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"username": "viewer", "password": "viewersecurepassword", "role": "readonly"}'
```

Available roles and their default SMART scopes:

| Role | Default Scopes | Can Do |
|---|---|---|
| `admin` | `system/*.*` | Everything, including registering users |
| `clinician` | `user/*.*` | Full CRUD on all resource types |
| `readonly` | `user/*.rs` | Read and search only |

You can also assign custom SMART scopes per user:

```bash
curl -X POST $BASE/auth/register \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "username": "labtech",
    "password": "labsecurepassword",
    "role": "clinician",
    "scopes": ["user/Observation.cruds", "user/DiagnosticReport.cruds", "user/Patient.rs"]
  }'
```

### Step 5: Logging In

Other users log in with their credentials:

```bash
curl -X POST $BASE/auth/login \
  -H "Content-Type: application/json" \
  -d '{"username": "drjones", "password": "anothersecurepassword"}'
```

```json
{
  "token": "eyJ...",
  "refresh_token": "eyJ...",
  "token_type": "Bearer",
  "username": "drjones",
  "role": "clinician",
  "scopes": ["user/*.*"]
}
```

### Step 6: Refreshing Tokens

Access tokens expire after 8 hours. Use the refresh token (valid for 7 days) to get a new one:

```bash
curl -X POST $BASE/auth/token \
  -H "Content-Type: application/json" \
  -d '{"grant_type": "refresh_token", "refresh_token": "eyJ..."}'
```

### Step 7: Logging Out

Revoke your current token:

```bash
curl -X POST $BASE/auth/logout \
  -H "Authorization: Bearer $TOKEN"
```

Or revoke a specific token:

```bash
curl -X POST $BASE/auth/revoke \
  -H "Content-Type: application/json" \
  -d '{"token": "eyJ..."}'
```

## Common Workflows

### Browse Resources in the App

Tap on any resource type in the Resource Counts card to open the resource browser. You can view resources as JSON or YAML, and tap on FHIR references (like `Patient/123`) to navigate to the referenced resource.

### Search with Parameters

FHIR ANT supports the full range of FHIR search parameters:

```bash
# Search by name
curl "$BASE/Patient?name=smith"

# Search by date range
curl "$BASE/Observation?date=gt2024-01-01&date=lt2024-12-31"

# Include referenced resources
curl "$BASE/Observation?patient=Patient/123&_include=Observation:patient"

# Chain through references
curl "$BASE/Observation?patient.name=smith"
```

### Backup and Restore

A backup is encrypted under a passphrase you choose. The passphrase is not stored and cannot be recovered. Export all data as an encrypted SQLite file:

```bash
curl -X POST "$BASE/\$backup" \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/fhir+json" \
  -d '{"resourceType":"Parameters","parameter":[{"name":"passphrase","valueString":"a long passphrase"}]}' \
  -o backup.sqlite
```

Restore it, sending the file as the body and the passphrase in a header:

```bash
curl -X POST "$BASE/\$restore" \
  -H "Authorization: Bearer $TOKEN" \
  -H "X-Backup-Passphrase: a long passphrase" \
  --data-binary @backup.sqlite
```

`$restore` also takes a plain FHIR Bundle (collection or transaction). The app's Backup card does both without curl.

## Connecting from a FHIR Client

FHIR ANT is a standard FHIR R4 (R4B) server. Any FHIR client library can connect to it; from the app, it must accept the app's self-signed certificate (pin its fingerprint). For example, with the [fhir_r4_at_rest](docs/at_rest/fhir_r4_at_rest) Dart package:

```dart
final request = FhirSearchRequest(
  base: Uri.parse('https://192.168.1.42:8080'),
  type: R4ResourceType.Patient,
  parameters: FhirSearchParams(params: [
    SearchString(FhirSearchParamDefinition.familyParam, ['Smith']),
  ]),
);
final response = await request.request();
```

## Troubleshooting

**App shows a loading spinner that never finishes**
Try clearing the app cache in Android Settings > Apps > FHIR ANT > Clear Cache, then relaunch.

**Can't connect from another device**
Make sure both devices are on the same Wi-Fi network. Some networks (especially guest networks) isolate devices from each other.

**Login keeps failing with the right password**
After 5 failed login attempts, the account locks for 15 minutes. A locked account gets the same "Invalid username or password" answer as a wrong password. Wait for it to expire, or have an admin unlock it:

```bash
curl -X POST "$BASE/admin/unlock/2" -H "Authorization: Bearer $ADMIN_TOKEN"
```

**Token expired**
Access tokens last 8 hours. Use the refresh token endpoint to get a new one (see Step 6 above). Refresh tokens last 7 days.

## Next Steps

- [Capabilities](docs/fhirant/fhirant_capabilities) — full feature matrix
- [API Reference](docs/fhirant/fhirant_api_reference) — every endpoint
- [Security & Auth](docs/fhirant/fhirant_security) — OAuth 2.0, SMART scopes, password policy
- [CLI Usage](docs/fhirant/fhirant_cli) — run the server from the command line
