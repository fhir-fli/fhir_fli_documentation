---
id: fhirant_api_reference
title: API Reference
---

# API Reference

Complete list of all endpoints available on the FHIR ANT server.

## Public Endpoints

These endpoints do not require authentication even when Dev Mode is off.

| Method | Path | Description |
|---|---|---|
| `GET` | `/` | Server info |
| `GET` | `/health` | Health check |
| `GET` | `/metadata` | FHIR CapabilityStatement |
| `GET` | `/.well-known/smart-configuration` | SMART discovery |
| `GET` | `/favicon.ico` | Favicon |

## Authentication Endpoints

| Method | Path | Description |
|---|---|---|
| `POST` | `/auth/register` | Register new user |
| `POST` | `/auth/login` | Login, returns JWT |
| `POST` | `/auth/token` | Token refresh / code exchange |
| `POST` | `/auth/revoke` | Revoke a token (RFC 7009) |
| `POST` | `/auth/logout` | Logout (revoke current token) |
| `GET` | `/auth/authorize` | OAuth authorization (show form) |
| `POST` | `/auth/authorize` | OAuth authorization (submit) |

## Admin Endpoints

| Method | Path | Description |
|---|---|---|
| `POST` | `/admin/unlock/<userId>` | Unlock locked account |

## Resource CRUD

| Method | Path | Description |
|---|---|---|
| `POST` | `/<type>` | Create resource |
| `GET` | `/<type>/<id>` | Read resource |
| `PUT` | `/<type>/<id>` | Update resource |
| `PATCH` | `/<type>/<id>` | JSON Patch resource |
| `DELETE` | `/<type>/<id>` | Delete resource |
| `DELETE` | `/<type>` | Conditional delete |

## Search

| Method | Path | Description |
|---|---|---|
| `GET` | `/<type>` | Search by type |
| `POST` | `/<type>/_search` | POST-based search |
| `POST` | `/_search` | System-level search (requires `_type`) |

## History

| Method | Path | Description |
|---|---|---|
| `GET` | `/<type>/<id>/_history/<vid>` | Version read |
| `GET` | `/<type>/<id>/_history` | Instance history |
| `GET` | `/<type>/_history` | Type history |
| `GET` | `/_history` | System history |

## Bundles

| Method | Path | Description |
|---|---|---|
| `POST` | `/` | Transaction or batch Bundle |

## Compartments

| Method | Path | Description |
|---|---|---|
| `GET` | `/<type>/<id>/$everything` | Compartment everything |
| `GET` | `/<type>/<id>/<resourceType>` | Compartment search |

Supported compartment types: Patient, Encounter, Practitioner, RelatedPerson, Device.

## Operations

| Method | Path | Description |
|---|---|---|
| `ALL` | `/$validate` | Validate a resource |
| `ALL` | `/<type>/$validate` | Validate against type |
| `GET/POST` | `/$fhirpath` | Evaluate FHIRPath |
| `POST` | `/$transform` | FHIR Mapping Language |
| `GET` | `/Composition/<id>/$document` | Generate document |
| `GET` | `/<type>/<id>/$meta` | Get resource meta |
| `POST` | `/<type>/<id>/$meta-add` | Add meta tags |
| `POST` | `/<type>/<id>/$meta-delete` | Remove meta tags |
| `POST` | `/$backup` | Export all data |
| `POST` | `/$restore` | Import data |

## Terminology

| Method | Path | Description |
|---|---|---|
| `GET/POST` | `/CodeSystem/<id>/$validate-code` | Validate code |
| `GET/POST` | `/CodeSystem/$validate-code` | Validate code (type-level) |
| `GET/POST` | `/ValueSet/<id>/$validate-code` | Validate code in ValueSet |
| `GET/POST` | `/ValueSet/$validate-code` | Validate code (type-level) |
| `GET/POST` | `/CodeSystem/<id>/$lookup` | Code lookup |
| `GET/POST` | `/CodeSystem/$lookup` | Code lookup (type-level) |
| `GET/POST` | `/ValueSet/<id>/$expand` | Expand ValueSet |
| `GET/POST` | `/ValueSet/$expand` | Expand (type-level) |

## Bulk Data Export

| Method | Path | Description |
|---|---|---|
| `GET` | `/$export` | System-level export |
| `GET` | `/Patient/$export` | Patient-level export |
| `GET` | `/Group/<id>/$export` | Group-level export |
| `GET` | `/$export-poll-status/<id>` | Poll export job |
| `DELETE` | `/$export-poll-status/<id>` | Cancel export job |
| `GET` | `/$export-file/<id>/<file>` | Download export file |
