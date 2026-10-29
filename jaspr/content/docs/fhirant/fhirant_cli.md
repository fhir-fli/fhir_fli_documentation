---
id: fhirant_cli
title: FHIR ANT CLI
---

FHIR ANT also runs as a standalone command-line server on any platform Dart supports (Linux, macOS, Windows). This is useful for development, CI/CD, and server deployments.

## Running

```bash
cd packages/fhirant_server
dart run bin/server.dart
```

The store is encrypted, and the server refuses to start without a key (see Environment Variables below). For a throwaway database, pass `--allow-public-key`, or `--dev-mode`, which implies it.

The CLI opens the store on its own isolate, so a long write (a large transaction Bundle, a restore) does not stop the server answering other requests.

## Options

| Flag | Default | Description |
|---|---|---|
| `--port`, `-p` | `8080` | Server port |
| `--db-path` | `data/db` | Directory for the database (`fhirant.db`), the generated JWT secret, the bootstrap token and bulk export files |
| `--config`, `-c` | — | YAML config file whose keys are these option names; the command line overrides it, and an unknown key is an error |
| `--https` | `false` | Enable HTTPS |
| `--cert-path` | — | HTTPS certificate file |
| `--key-path` | — | HTTPS private key file |
| `--dev-mode` | `false` | Disable authentication (testing only). Implies `--allow-public-key` |
| `--allow-public-key` | `false` | Open the store under the publicly known default key when `FHIRANT_ENCRYPTION_KEY` is unset (throwaway databases only), with authentication still on |
| `--spec-path` | `/app/fhir_spec` | Directory of FHIR spec NDJSON files loaded on first start |
| `--base-url` | — | The URL clients reach this server by, so a search can tell an absolute reference to this server from one to another server |
| `--audit-retention-days` | unset | Days AuditEvents are kept before the hourly sweep removes them. Unset: none are removed |
| `--clamd-host` | unset | Host of a ClamAV `clamd` daemon. Set, every file a client sends is scanned before it is stored; a match is refused (422), and so is a file clamd cannot answer for (503). `$restore` is not scanned yet. Unset: nothing is scanned |
| `--clamd-port` | `3310` | clamd's TCP port |
| `--clamd-timeout-seconds` | `130` | How long one scan may take before the file is refused |
| `--help`, `-h` | — | Show usage |

## Environment Variables

| Variable | Description |
|---|---|
| `FHIRANT_ENCRYPTION_KEY` | Database encryption key. Unset, the server refuses to start unless `--allow-public-key` or `--dev-mode` is given. Set but empty, it always refuses: an empty key is no encryption |
| `FHIRANT_JWT_SECRET` | JWT signing secret. Unset, a strong secret is generated once and kept at `<db-path>/.jwt_secret`; set it when several instances must share one |
| `FHIRANT_ADMIN_USERNAME`, `FHIRANT_ADMIN_PASSWORD` | Create the first administrator at start. Ignored once an administrator exists. Only one of the two set, or a username or password the server refuses, stops the server |

## The First Administrator

With authentication on and no accounts, the server prints a one-time **bootstrap token** at start and writes it to `<db-path>/.bootstrap_token` (owner-readable). The first `POST /auth/register` must carry it in the `X-Bootstrap-Token` header (or a `bootstrap_token` body field), and becomes the administrator. To skip this, set `FHIRANT_ADMIN_USERNAME` and `FHIRANT_ADMIN_PASSWORD` and restart. See [Getting Started](docs/fhirant/fhirant_getting_started) for the requests.

In dev mode registration is refused.

## Examples

```bash
# Dev mode (no auth, throwaway key) on port 3000 with a custom DB path
dart run bin/server.dart --dev-mode --port 3000 --db-path /tmp/fhirant

# Authentication on, with your own key and the first admin from the environment
FHIRANT_ENCRYPTION_KEY='a-long-random-secret' \
FHIRANT_ADMIN_USERNAME=admin FHIRANT_ADMIN_PASSWORD='a-long-passphrase' \
  dart run bin/server.dart

# HTTPS with certificates
FHIRANT_ENCRYPTION_KEY='a-long-random-secret' \
  dart run bin/server.dart --https --cert-path cert.pem --key-path key.pem

# Scan uploaded files with a local clamd
FHIRANT_ENCRYPTION_KEY='a-long-random-secret' \
  dart run bin/server.dart --clamd-host localhost
```

## Docker

The repository root has a Dockerfile. The image runs the compiled server on port 8080 with its database in `/data`:

```bash
docker build -t fhirant .
docker run -p 8080:8080 -v fhirant-data:/data \
  -e FHIRANT_ENCRYPTION_KEY=a-long-random-secret \
  -e FHIRANT_JWT_SECRET=another-long-random-secret \
  fhirant
```

`docker-compose.yml` runs the same server beside a ClamAV `clamd` container (`clamav/clamav:1.5.4`) with `--clamd-host clamav`. It requires both secrets to be set:

```bash
FHIRANT_ENCRYPTION_KEY=... FHIRANT_JWT_SECRET=... docker compose up
```

## Testing

```bash
# Run all server tests
cd packages/fhirant_server && dart test

# From the repository root: smoke test against a running server
dart run tools/smoke_test.dart http://localhost:8080

# Smoke test including the authentication tests
dart run tools/smoke_test.dart http://localhost:8080 --auth
```
