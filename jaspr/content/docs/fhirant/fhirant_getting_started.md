---
id: fhirant_getting_started
title: Getting Started
---

## Getting Started

This guide walks you through your first session with FHIR ANT — from installation to making authenticated API calls.

### Install

Download FHIR ANT from the [Google Play Store](https://play.google.com/store/apps/details?id=com.fhirfli.fhirant). It also runs as a Linux desktop app or a standalone CLI server (see [CLI Usage](fhirant_cli)).

### First Launch

When you open the app for the first time, you'll see a three-page onboarding:

1. **Welcome** — what FHIR ANT is
2. **How It Works** — features overview
3. **Sample Data** — optionally load a set of realistic clinical data (MIMIC-IV subset) to explore with

You can always load or clear sample data later. Tap **Get Started** to reach the dashboard.

### The Dashboard

The dashboard has four sections:

- **Server Control** — start/stop the server, toggle Dev Mode, set the port
- **Network Info** — your device's IP address and a QR code other devices can scan to connect
- **Resource Counts** — how many FHIR resources are stored, by type
- **Request Log** — live feed of incoming HTTP requests

### Starting the Server

Tap **Start** on the Server Control card. The server binds to all network interfaces on the configured port (default 8080). The URL will look something like:

```
http://192.168.1.42:8080
```

Any device on the same Wi-Fi network can reach this URL.

#### Dev Mode vs Authenticated Mode

By default, the server starts in **Dev Mode** — authentication is disabled and all requests are accepted. This is useful for quick testing.

To require authentication, toggle Dev Mode **off** before starting the server. When Dev Mode is off, all non-public endpoints require a valid JWT token.

### Using Dev Mode

With Dev Mode on, you can immediately start making requests:

```bash
# Server capabilities
curl http://192.168.1.42:8080/metadata

# Search for all patients
curl http://192.168.1.42:8080/Patient

# Create a patient
curl -X POST http://192.168.1.42:8080/Patient \
  -H "Content-Type: application/fhir+json" \
  -d '{"resourceType":"Patient","name":[{"family":"Smith","given":["John"]}]}'
```

No tokens or credentials needed — every request is treated as an admin.

### Setting Up Authentication

When you're ready to use auth, stop the server, toggle Dev Mode off, and start it again.

#### Step 1: Check Server Status

The `/auth/status` endpoint is public and tells you whether any users exist:

```bash
curl http://192.168.1.42:8080/auth/status
```

```json
{"firstUser": true}
```

`"firstUser": true` means no users have been created yet.

#### Step 2: Create the Admin Account

When no users exist, anyone can register — this is the bootstrap mechanism. The first user is **automatically promoted to admin** regardless of what role you request:

```bash
curl -X POST http://192.168.1.42:8080/auth/register \
  -H "Content-Type: application/json" \
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

Registration returns a JWT immediately — you're logged in.

<Info>
**Password Requirements**

Passwords must be 12-128 characters. There are no complexity rules (no required uppercase, numbers, or symbols), but common passwords like `password123456` are blocked. This follows [NIST 800-63B](https://pages.nist.gov/800-63-3/sp800-63b.html) guidelines — length matters more than complexity.
</Info>

#### Step 3: Make Authenticated Requests

Use the `token` from registration or login in the `Authorization` header:

```bash
TOKEN="eyJ..."

# Search patients
curl -H "Authorization: Bearer $TOKEN" \
  http://192.168.1.42:8080/Patient

# Create a resource
curl -X POST http://192.168.1.42:8080/Observation \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/fhir+json" \
  -d '{
    "resourceType": "Observation",
    "status": "final",
    "code": {"text": "Heart rate"},
    "valueQuantity": {"value": 72, "unit": "bpm"}
  }'
```

#### Step 4: Register Additional Users

Once the admin account exists, only admins can create new users. Use the admin token and optionally specify a role:

```bash
# Create a clinician (default role)
curl -X POST http://192.168.1.42:8080/auth/register \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"username": "drjones", "password": "anothersecurepassword"}'

# Create a read-only user
curl -X POST http://192.168.1.42:8080/auth/register \
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
curl -X POST http://192.168.1.42:8080/auth/register \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "username": "labtech",
    "password": "labsecurepassword",
    "role": "clinician",
    "scopes": ["user/Observation.cruds", "user/DiagnosticReport.cruds", "user/Patient.rs"]
  }'
```

#### Step 5: Logging In

Other users log in with their credentials:

```bash
curl -X POST http://192.168.1.42:8080/auth/login \
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

#### Step 6: Refreshing Tokens

Access tokens expire after 8 hours. Use the refresh token (valid for 7 days) to get a new one:

```bash
curl -X POST http://192.168.1.42:8080/auth/token \
  -H "Content-Type: application/json" \
  -d '{"grant_type": "refresh_token", "refresh_token": "eyJ..."}'
```

#### Step 7: Logging Out

Revoke your current token:

```bash
curl -X POST http://192.168.1.42:8080/auth/logout \
  -H "Authorization: Bearer $TOKEN"
```

Or revoke a specific token:

```bash
curl -X POST http://192.168.1.42:8080/auth/revoke \
  -H "Content-Type: application/json" \
  -d '{"token": "eyJ..."}'
```

### Common Workflows

#### Browse Resources in the App

Tap on any resource type in the Resource Counts card to open the resource browser. You can view resources as JSON or YAML, and tap on FHIR references (like `Patient/123`) to navigate to the referenced resource.

#### Search with Parameters

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

#### Backup and Restore

Export all data as a FHIR Bundle:

```bash
curl -X POST "$BASE/\$backup" -H "Authorization: Bearer $TOKEN" > backup.json
```

Restore from a backup:

```bash
curl -X POST "$BASE/\$restore" \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/fhir+json" \
  -d @backup.json
```

### Connecting from a FHIR Client

FHIR ANT is a standard FHIR R4 server. Any FHIR client library can connect to it. For example, with the [fhir_r4_at_rest](../at_rest/fhir_r4_at_rest) Dart package:

```dart
final request = FhirSearchRequest(
  base: Uri.parse('http://192.168.1.42:8080'),
  type: R4ResourceType.Patient,
  parameters: FhirSearchParams(params: [
    SearchString(FhirSearchParamDefinition.familyParam, ['Smith']),
  ]),
);
final response = await request.request();
```

### Troubleshooting

**App shows a loading spinner that never finishes**
Try clearing the app cache in Android Settings > Apps > FHIR ANT > Clear Cache, then relaunch.

**Can't connect from another device**
Make sure both devices are on the same Wi-Fi network. Some networks (especially guest networks) isolate devices from each other.

**"Account is locked" error**
After 5 failed login attempts, the account locks for 15 minutes. Wait for it to expire, or have an admin unlock it:

```bash
curl -X POST "$BASE/admin/unlock/2" -H "Authorization: Bearer $ADMIN_TOKEN"
```

**Token expired**
Access tokens last 8 hours. Use the refresh token endpoint to get a new one (see Step 6 above). Refresh tokens last 7 days.

### Next Steps

- [Capabilities](fhirant_capabilities) — full feature matrix
- [API Reference](fhirant_api_reference) — every endpoint
- [Security & Auth](fhirant_security) — OAuth 2.0, SMART scopes, password policy
- [CLI Usage](fhirant_cli) — run the server from the command line
