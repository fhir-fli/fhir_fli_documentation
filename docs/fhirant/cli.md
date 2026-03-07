---
id: fhirant_cli
title: CLI Usage
---

# CLI Server

FHIR ANT can also run as a standalone command-line server on any platform that supports Dart (Linux, macOS, Windows). This is useful for development, CI/CD, and server deployments.

## Running

```bash
cd packages/fhirant_server
dart run bin/server.dart
```

## Options

| Flag | Default | Description |
|---|---|---|
| `--port`, `-p` | `8080` | Server port |
| `--db-path` | `data/db` | Database file path |
| `--sqlcipher-path` | (auto-detect) | Custom SQLCipher library path |
| `--config`, `-c` | — | YAML configuration file |
| `--https` | `false` | Enable HTTPS |
| `--cert-path` | — | HTTPS certificate file |
| `--key-path` | — | HTTPS private key file |
| `--dev-mode` | `false` | Disable authentication |
| `--help`, `-h` | — | Show usage |

## Environment Variables

| Variable | Description |
|---|---|
| `FHIRANT_ENCRYPTION_KEY` | Database encryption key |
| `FHIRANT_JWT_SECRET` | JWT signing secret |

## Examples

```bash
# Basic server on port 3000
dart run bin/server.dart --port 3000

# Dev mode (no auth) with custom DB path
dart run bin/server.dart --dev-mode --db-path /tmp/fhirant

# HTTPS with certificates
dart run bin/server.dart --https --cert-path cert.pem --key-path key.pem

# Production with encryption key
FHIRANT_ENCRYPTION_KEY=my-secret-key dart run bin/server.dart
```

## Docker

A Dockerfile is included for containerized deployments:

```bash
docker build -t fhirant .
docker run -p 8080:8080 -e FHIRANT_ENCRYPTION_KEY=my-key fhirant
```

## Testing

```bash
# Run all server tests
cd packages/fhirant_server && dart test

# Run smoke test against a running server
dart run tools/smoke_test.dart http://localhost:8080

# Run smoke test with auth testing
dart run tools/smoke_test.dart http://localhost:8080 --auth
```
