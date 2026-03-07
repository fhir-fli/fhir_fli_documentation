---
id: fhirant_security
title: Security & Auth
---

# Security & Authentication

FHIR ANT includes a full authentication and authorization system. In **Dev Mode** (the default for testing), authentication is bypassed. When Dev Mode is off, all non-public endpoints require a valid JWT token.

## Dev Mode

When enabled, all requests are accepted without authentication. A synthetic admin user is injected into every request so that audit trails and scope enforcement still function internally.

**Dev Mode is for testing only.** A warning banner appears in the app when it's active.

## Authentication Flow

### Registration & Login

```bash
# Register a new user (first user becomes admin)
curl -X POST http://server:8080/auth/register \
  -H "Content-Type: application/json" \
  -d '{"username":"admin","password":"mysecurepassword"}'

# Login
curl -X POST http://server:8080/auth/login \
  -H "Content-Type: application/json" \
  -d '{"username":"admin","password":"mysecurepassword"}'
# Returns: {"token": "eyJ...", "refresh_token": "eyJ...", ...}
```

### Using Tokens

```bash
# Use the access token for authenticated requests
curl -H "Authorization: Bearer eyJ..." http://server:8080/Patient
```

### Token Refresh

```bash
curl -X POST http://server:8080/auth/token \
  -H "Content-Type: application/json" \
  -d '{"grant_type":"refresh_token","refresh_token":"eyJ..."}'
```

### OAuth 2.0 Authorization Code Flow (PKCE)

FHIR ANT supports the full OAuth 2.0 authorization code flow with PKCE, suitable for SMART on FHIR applications:

1. `GET /auth/authorize` — Authorization endpoint
2. `POST /auth/authorize` — Submit authorization (JSON or form-encoded)
3. `POST /auth/token` — Exchange code for tokens (with `code_verifier`)

### Token Revocation (RFC 7009)

```bash
# Revoke a token
curl -X POST http://server:8080/auth/revoke \
  -H "Content-Type: application/json" \
  -d '{"token":"eyJ..."}'

# Logout (revokes access token from Authorization header)
curl -X POST http://server:8080/auth/logout \
  -H "Authorization: Bearer eyJ..."
```

## SMART on FHIR Scopes

FHIR ANT enforces SMART v2 scope syntax: `context/resourceType.permissions`

| Context | Example | Description |
|---|---|---|
| `user` | `user/Patient.rs` | User-level read+search on Patient |
| `patient` | `patient/Observation.cruds` | Patient-level full access |
| `system` | `system/*.*` | System-level full access (admin) |

**Permissions:** `c` (create), `r` (read), `u` (update), `d` (delete), `s` (search)

### Default Scopes by Role

| Role | Default Scopes |
|---|---|
| `admin` | `system/*.*` |
| `clinician` | `user/*.*` |
| `readonly` | `user/*.rs` |

## Password Policy

Follows NIST 800-63B guidelines:
- Minimum 12 characters, maximum 128
- No complexity rules (length > complexity)
- Blocked common passwords (e.g., "password123456")
- Case-insensitive blocklist matching

## Account Lockout

- Account locks after 5 failed login attempts
- Auto-unlock after 15 minutes
- Admin can manually unlock via `POST /admin/unlock/<userId>`
- Returns HTTP 423 (Locked) when account is locked

## Database Encryption

The SQLite database is encrypted with SQLCipher. The encryption key is generated on first launch and stored in the device's secure keystore (Android Keystore / iOS Keychain). Data at rest is always encrypted.

## Audit Trail

All requests are logged with timestamp, method, path, status code, duration, client IP, and authenticated user (if present).
