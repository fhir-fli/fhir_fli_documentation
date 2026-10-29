---
id: fhirant_capabilities
title: FHIR ANT Capabilities
---

FHIR ANT implements a broad set of the FHIR R4 specification, as R4B (4.3.0). Here's what's supported. The server's own CapabilityStatement (`GET /metadata`) is the full list.

## FHIR REST API

### CRUD Operations
| Operation | Method | Endpoint | Notes |
|---|---|---|---|
| Create | `POST` | `/<type>` | Auto-generates ID if not provided |
| Read | `GET` | `/<type>/<id>` | |
| Update | `PUT` | `/<type>/<id>` | Auto-versions with timestamp; creates the resource if the id is new |
| Patch | `PATCH` | `/<type>/<id>` | JSON Patch (RFC 6902); FHIRPath Patch is refused (415) |
| Delete | `DELETE` | `/<type>/<id>` | |
| Conditional Create | `POST` | `/<type>` | Via `If-None-Exist` header |
| Version-aware Update | `PUT` | `/<type>/<id>` | Via `If-Match` header (412 on a version mismatch) |
| Conditional Update | `PUT` | `/<type>?<criteria>` | Via search criteria |
| Conditional Delete | `DELETE` | `/<type>` | Via query parameters |

### Search
| Feature | Details |
|---|---|
| GET search | `GET /<type>?param=value` |
| POST search | `POST /<type>/_search` |
| System search | `GET /?<params>`, `POST /_search` (requires `_type`) |
| String params | Starts-with matching |
| Token params | `system\|code`, `:text`, `:in`, `:not-in`, `:of-type` modifiers |
| Reference params | Direct and chained (`.`), reverse chaining (`_has`) |
| Date params | `eq`, `ne`, `lt`, `gt`, `le`, `ge`, `sa`, `eb`, `ap` prefixes |
| Number params | Numeric prefixes |
| Quantity params | Value, system, code |
| URI params | `:above`, `:below` modifiers |
| Composite params | Multiple components |
| `_include` | Forward includes with `:iterate` and wildcard (`*`) |
| `_revinclude` | Reverse includes with `:iterate` and wildcard (`*`) |
| `_sort` | Single and multi-field sorting |
| `_count` / `_offset` | Pagination |
| `_total` | `none`, `estimate`, `accurate` |
| `_summary` | `true`, `false`, `text`, `data`, `count` |
| `_elements` | Return only specified fields (adds SUBSETTED tag) |
| `_filter` | Filter expressions |
| `_contained` | `false` only (contained resources are not indexed) |
| `Prefer: handling=strict` | Unknown parameters are reported instead of ignored |

### History
| Endpoint | Description |
|---|---|
| `GET /<type>/<id>/_history` | Instance history |
| `GET /<type>/<id>/_history/<vid>` | Version read |
| `GET /<type>/_history` | Type history |
| `GET /_history` | System history |
| `_since` / `_at` parameters | Filter by date |

### Bundles
- **Transaction** bundles — atomic, all-or-nothing with `urn:uuid` resolution. Entries are processed in the order the spec sets (DELETE, then POST, then PUT/PATCH, then GET), and two entries naming the same resource fail the transaction
- **Batch** bundles — independent operations
- Full `urn:uuid` cross-reference resolution within transactions, and conditional references (`Patient?identifier=...`)
- A transaction's plain creates are written to the store together, up to 100 at a time; a create that reads first (a conditional create, a conditional reference) still sees every write before it

### Compartments
| Compartment | `$everything` | Compartment Search |
|---|---|---|
| Patient | Yes | Yes |
| Encounter | Yes | Yes |
| Practitioner | Yes | Yes |
| RelatedPerson | Yes | Yes |
| Device | Yes | Yes |

## Operations

| Operation | Endpoint | Description |
|---|---|---|
| `$validate` | `POST /$validate`, `POST /<type>/$validate` | Resource validation |
| `$everything` | `GET /<type>/<id>/$everything` | Patient/compartment everything |
| `$document` | `GET /Composition/<id>/$document` | Generate document Bundle |
| `$meta` | `GET /<type>/<id>/$meta` | Get resource metadata |
| `$meta-add` | `POST /<type>/<id>/$meta-add` | Add metadata |
| `$meta-delete` | `POST /<type>/<id>/$meta-delete` | Remove metadata |
| `$fhirpath` | `GET/POST /$fhirpath` | Evaluate FHIRPath expressions |
| `$transform` | `POST /$transform` | FHIR Mapping Language transforms |
| `$cql` | `POST /$cql` | Evaluate CQL |
| `$evaluate` | `POST /Library/<id>/$evaluate`, `POST /Library/$evaluate` | Evaluate a CQL Library (stored, by canonical URL, or inline) |
| `$immds-forecast` | `POST /$immds-forecast` | Immunization forecast, CDC CDSi logic |
| `$immds-forecast-who` | `POST /$immds-forecast-who` | Immunization forecast, WHO EPI logic |
| `$reindex` | `POST /$reindex`, `GET /$reindex-status` | Rebuild the search index after a SearchParameter is added (asynchronous) |
| `$backup` | `POST /$backup` | Export all data, encrypted under a passphrase you supply (an encrypted SQLite file, or with `format=bundle` an encrypted Bundle) |
| `$restore` | `POST /$restore` | Import an encrypted backup or a plain FHIR Bundle |

## Terminology

| Operation | Endpoint |
|---|---|
| `$validate-code` | `GET/POST /CodeSystem/<id>/$validate-code` |
| `$validate-code` | `GET/POST /ValueSet/<id>/$validate-code` |
| `$lookup` | `GET/POST /CodeSystem/<id>/$lookup` |
| `$expand` | `GET/POST /ValueSet/<id>/$expand` |
| `$subsumes` | `GET/POST /CodeSystem/<id>/$subsumes` |
| `$translate` | `GET/POST /ConceptMap/<id>/$translate` |
| `$preferred-id` | `GET/POST /NamingSystem/$preferred-id` |

Instance-level and type-level variants are both supported.

## Bulk Data Export

| Endpoint | Description |
|---|---|
| `GET /$export` | System-level export |
| `GET /Patient/$export` | Patient-level export |
| `GET /Group/<id>/$export` | Group-level export |
| `GET /$export-poll-status/<id>` | Poll export status |
| `DELETE /$export-poll-status/<id>` | Cancel export |
| `GET /$export-file/<id>/<file>` | Download NDJSON file |

Supports `_type`, `_since`, `_typeFilter`, and `_outputFormat` parameters. `_elements`, `patient` and `includeAssociatedData` are refused (400) unless the request sends `Prefer: handling=lenient`, which ignores them. Export files are encrypted at rest on the server.

## Subscriptions

R4 Subscriptions with the `rest-hook` and `websocket` channel types. Notifications are sent after the write commits. For a websocket subscription, connect to `GET /ws` and send `bind <id>`.

## File Scanning

With `--clamd-host` set (CLI and Docker), every file a client's resource carries is scanned by ClamAV before it is stored; a match is refused (422), and a file the scanner cannot answer for is refused (503). `$restore` is not scanned yet. The app has no scanner.

## Content Negotiation

- `Accept: application/fhir+json` (default). JSON only: XML is refused (406)
- `_format` parameter
- `_pretty=true` for formatted output
- `Prefer: return=minimal`, `return=representation`, `return=OperationOutcome`, `respond-async`
- `If-Modified-Since`, `If-None-Match`, `If-Match` headers

## Metadata

- `GET /metadata` — Full CapabilityStatement with all supported resources, search parameters, operations, and security information
- `GET /.well-known/smart-configuration` — SMART on FHIR discovery document
- `GET /health` — Server health check (status, uptime, version, database connectivity)
