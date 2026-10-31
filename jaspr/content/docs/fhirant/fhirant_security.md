---
id: fhirant_security
title: Security & Authentication
---

FHIR ANT includes a full authentication and authorization system. With authentication off (**Experimentation mode** in the app, `--dev-mode` on the CLI), it is bypassed. With it on (**Secure mode** in the app, the CLI's default), all non-public endpoints require a valid JWT token.

## Experimentation Mode / Dev Mode

When enabled, all requests are accepted without authentication. A synthetic admin user is injected into every request so that audit trails and scope enforcement still function internally. Registration is refused, so nobody on the network can create the administrator that Secure mode will later trust; `$restore` brings in the FHIR records but none of the backup's accounts.

**It is for test data only.** A fresh app install starts in it while FHIR ANT is pre-release, and the app shows a warning banner whenever it is active.

## Authentication Flow

### Registration & Login

The first account is the administrator. In the app you create it when you switch to Secure mode. On the CLI, either set `FHIRANT_ADMIN_USERNAME` and `FHIRANT_ADMIN_PASSWORD`, or register with the one-time bootstrap token the server prints at start (also in `<db-path>/.bootstrap_token`). After that only an admin can register users.

```bash
# Register the first user, who becomes admin (CLI, no admin seeded)
curl -X POST http://server:8080/auth/register \
  -H "Content-Type: application/json" \
  -H "X-Bootstrap-Token: <token from the server log>" \
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

Only the `S256` code challenge method is accepted; `plain` is refused.

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

A `patient/` scope applies to an account linked to a Patient (registered with a `patient` reference); it confines that account to the patient's compartment.

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
- 30,407 common passwords of that length are blocked (e.g., "password123456"), matched case-insensitively
- Passwords are stored as argon2id hashes (19 MiB memory, 2 iterations, 1 lane); older PBKDF2 hashes still verify

## Account Management

An account can change its own password (`POST /auth/password`). An admin can list accounts, set a password, deactivate or reactivate an account, and change its role or scopes (`/admin/users/...`, see the [API Reference](docs/fhirant/fhirant_api_reference)). Each of these ends every token the account held before the change.

## Account Lockout

- Account locks after 5 failed login attempts
- Auto-unlock after 15 minutes
- Admin can manually unlock via `POST /admin/unlock/<userId>`
- A locked account gets the same answer as a wrong password (401, "Invalid username or password"), so a caller cannot tell a locked account from a bad guess

## Rate Limiting

Per client address, per minute: 600 requests in general (1,000 on the CLI in dev mode), and 10 on the credential endpoints (`/auth/login`, `/auth/authorize`, `/auth/token`, `/auth/register`).

## Transport

The app serves HTTPS only, with a self-signed certificate it generates and keeps in secure storage. There is no certificate authority to vouch for it, so clients pin its SHA-256 fingerprint, which the Network card shows and its QR code carries. The CLI serves HTTP unless started with `--https`.

## Database Encryption

The SQLite database is encrypted in the SQLCipher 4 format (AES-256) through SQLite3 Multiple Ciphers. In the app the encryption key is generated on first launch and kept in the device's secure storage (Android Keystore / iOS Keychain). On the CLI the key is `FHIRANT_ENCRYPTION_KEY`; the server refuses an empty key, and refuses the publicly known default unless told it is a throwaway database (`--allow-public-key`). Backups are encrypted under a passphrase you choose, which is not stored and cannot be recovered.

## Audit Trail

Every request except the welcome page, `/metadata`, `/favicon.ico`, `/health`, the SMART discovery document and a `POST /AuditEvent` is recorded as a FHIR AuditEvent, including requests the server refuses, with who made it when that is known. A Bundle leaves one AuditEvent per entry. On the CLI, `--audit-retention-days` sets how long they are kept; by default none are removed.
