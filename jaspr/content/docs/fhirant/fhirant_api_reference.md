---
id: fhirant_api_reference
title: FHIR ANT API Reference
---

Every route the FHIR ANT server registers, grouped by purpose. With authentication on, everything outside the public endpoints needs a token.

## Public Endpoints

These need no token even with authentication on. Everything under `/auth/` is reachable without one; `/auth/password` itself requires the caller's token.

| Method | Path | Description |
|---|---|---|
| `GET` | `/` | Welcome page (with a query string it is the system search, which requires a token) |
| `GET` | `/health` | Health check: status, uptime, version, database connectivity |
| `GET` | `/metadata` | FHIR CapabilityStatement |
| `GET` | `/.well-known/smart-configuration` | SMART discovery |
| `GET` | `/favicon.ico` | Favicon |

## Authentication Endpoints

| Method | Path | Description |
|---|---|---|
| `GET` | `/auth/status` | Whether any account exists (`firstUser`) and whether the first registration needs the bootstrap token (`bootstrapTokenRequired`) |
| `POST` | `/auth/register` | Register a user (the first one with the bootstrap token, later ones by an admin; refused while authentication is off) |
| `POST` | `/auth/login` | Login, returns a JWT and a refresh token |
| `POST` | `/auth/token` | Token refresh / authorization code exchange |
| `POST` | `/auth/revoke` | Revoke a token (RFC 7009) |
| `POST` | `/auth/logout` | Logout (revoke current token) |
| `GET` | `/auth/authorize` | OAuth authorization (show form) |
| `POST` | `/auth/authorize` | OAuth authorization (submit, form or JSON) |
| `POST` | `/auth/password` | Change your own password (`current_password`, `new_password`) |

## Admin Endpoints

All require the admin role.

| Method | Path | Description |
|---|---|---|
| `POST` | `/admin/unlock/<userId>` | Unlock a locked account |
| `GET` | `/admin/users` | List accounts, without their secrets |
| `POST` | `/admin/users/<userId>/password` | Set an account's password (`new_password`) |
| `POST` | `/admin/users/<userId>/deactivate` | Deactivate an account |
| `POST` | `/admin/users/<userId>/activate` | Reactivate an account |
| `PUT` | `/admin/users/<userId>/role` | Change an account's role (`role`) |
| `PUT` | `/admin/users/<userId>/scopes` | Set an account's SMART scopes (`scopes`, or null for the role's defaults) |

A change to an account's password, role, scopes or activation ends every token issued to it before the change. The last active administrator cannot be deactivated or demoted.

## Resource CRUD

| Method | Path | Description |
|---|---|---|
| `POST` | `/<type>` | Create resource (`If-None-Exist` for conditional create) |
| `GET` | `/<type>/<id>` | Read resource |
| `PUT` | `/<type>/<id>` | Update resource, or create it with that id (`If-Match` for a version-aware update) |
| `PUT` | `/<type>?<criteria>` | Conditional update |
| `PATCH` | `/<type>/<id>` | JSON Patch resource |
| `DELETE` | `/<type>/<id>` | Delete resource |
| `DELETE` | `/<type>?<criteria>` | Conditional delete |

## Search

| Method | Path | Description |
|---|---|---|
| `GET` | `/<type>` | Search by type |
| `POST` | `/<type>/_search` | POST-based search |
| `GET` | `/?<params>` | System-level search |
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
| `POST` | `/$cql` | Evaluate CQL |
| `POST` | `/Library/<id>/$evaluate` | Evaluate a stored CQL Library |
| `POST` | `/Library/$evaluate` | Evaluate a Library by canonical URL or inline |
| `POST` | `/$immds-forecast` | Immunization forecast, CDC CDSi logic |
| `POST` | `/$immds-forecast-who` | Immunization forecast, WHO EPI logic |
| `GET` | `/Composition/<id>/$document` | Generate document |
| `GET` | `/<type>/<id>/$meta` | Get resource meta |
| `POST` | `/<type>/<id>/$meta-add` | Add meta tags |
| `POST` | `/<type>/<id>/$meta-delete` | Remove meta tags |
| `POST` | `/$reindex` | Rebuild the search index (asynchronous) |
| `GET` | `/$reindex-status` | Poll the reindex job |
| `POST` | `/$backup` | Export all data, encrypted under a passphrase |
| `POST` | `/$restore` | Import a backup |

## Terminology

| Method | Path | Description |
|---|---|---|
| `GET/POST` | `/CodeSystem/<id>/$validate-code` | Validate code |
| `GET/POST` | `/CodeSystem/$validate-code` | Validate code (type-level) |
| `GET/POST` | `/ValueSet/<id>/$validate-code` | Validate code in ValueSet |
| `GET/POST` | `/ValueSet/$validate-code` | Validate code (type-level) |
| `GET/POST` | `/CodeSystem/<id>/$lookup` | Code lookup |
| `GET/POST` | `/CodeSystem/$lookup` | Code lookup (type-level) |
| `GET/POST` | `/CodeSystem/<id>/$subsumes` | Subsumption test |
| `GET/POST` | `/CodeSystem/$subsumes` | Subsumption test (type-level) |
| `GET/POST` | `/ValueSet/<id>/$expand` | Expand ValueSet |
| `GET/POST` | `/ValueSet/$expand` | Expand (type-level) |
| `GET/POST` | `/ConceptMap/<id>/$translate` | Translate a code |
| `GET/POST` | `/ConceptMap/$translate` | Translate (type-level) |
| `GET/POST` | `/NamingSystem/$preferred-id` | Preferred identifier |

## Subscriptions

| Method | Path | Description |
|---|---|---|
| `GET` | `/ws` | Websocket channel: connect, send `bind <id>`, receive notifications |

## Bulk Data Export

| Method | Path | Description |
|---|---|---|
| `GET` | `/$export` | System-level export |
| `GET` | `/Patient/$export` | Patient-level export |
| `GET` | `/Group/<id>/$export` | Group-level export |
| `GET` | `/$export-poll-status/<id>` | Poll export job |
| `DELETE` | `/$export-poll-status/<id>` | Cancel export job |
| `GET` | `/$export-file/<id>/<file>` | Download export file |
