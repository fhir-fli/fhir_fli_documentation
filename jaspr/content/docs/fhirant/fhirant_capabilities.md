---
id: fhirant_capabilities
title: Capabilities
---

## Capabilities

FHIR ANT implements a broad set of the FHIR R4 specification. Here's what's supported.

### FHIR REST API

#### CRUD Operations
| Operation | Method | Endpoint | Notes |
|---|---|---|---|
| Create | `POST` | `/<type>` | Auto-generates ID if not provided |
| Read | `GET` | `/<type>/<id>` | |
| Update | `PUT` | `/<type>/<id>` | Auto-versions with timestamp |
| Patch | `PATCH` | `/<type>/<id>` | JSON Patch (RFC 6902) |
| Delete | `DELETE` | `/<type>/<id>` | |
| Conditional Create | `POST` | `/<type>` | Via `If-None-Exist` header |
| Conditional Update | `PUT` | `/<type>/<id>` | Via `If-Match` header |
| Conditional Delete | `DELETE` | `/<type>` | Via query parameters |

#### Search
| Feature | Details |
|---|---|
| GET search | `GET /<type>?param=value` |
| POST search | `POST /<type>/_search` |
| System search | `POST /_search` (requires `_type`) |
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

#### History
| Endpoint | Description |
|---|---|
| `GET /<type>/<id>/_history` | Instance history |
| `GET /<type>/<id>/_history/<vid>` | Version read |
| `GET /<type>/_history` | Type history |
| `GET /_history` | System history |
| `_since` / `_at` parameters | Filter by date |

#### Bundles
- **Transaction** bundles — atomic, all-or-nothing with `urn:uuid` resolution
- **Batch** bundles — independent operations
- Full `urn:uuid` cross-reference resolution within transactions

#### Compartments
| Compartment | `$everything` | Compartment Search |
|---|---|---|
| Patient | Yes | Yes |
| Encounter | Yes | Yes |
| Practitioner | Yes | Yes |
| RelatedPerson | Yes | Yes |
| Device | Yes | Yes |

### Operations

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
| `$backup` | `POST /$backup` | Export all data as FHIR Bundle |
| `$restore` | `POST /$restore` | Import data from FHIR Bundle |

### Terminology

| Operation | Endpoint |
|---|---|
| `$validate-code` | `GET/POST /CodeSystem/<id>/$validate-code` |
| `$validate-code` | `GET/POST /ValueSet/<id>/$validate-code` |
| `$lookup` | `GET/POST /CodeSystem/<id>/$lookup` |
| `$expand` | `GET/POST /ValueSet/<id>/$expand` |

Instance-level and type-level variants are both supported.

### Bulk Data Export

| Endpoint | Description |
|---|---|
| `GET /$export` | System-level export |
| `GET /Patient/$export` | Patient-level export |
| `GET /Group/<id>/$export` | Group-level export |
| `GET /$export-poll-status/<id>` | Poll export status |
| `DELETE /$export-poll-status/<id>` | Cancel export |
| `GET /$export-file/<id>/<file>` | Download NDJSON file |

Supports `_type`, `_since`, `_typeFilter`, and `_outputFormat` parameters.

### Content Negotiation

- `Accept: application/fhir+json` (default)
- `_format` parameter
- `_pretty=true` for formatted output
- `Prefer: return=minimal`, `return=representation`, `return=OperationOutcome`, `respond-async`
- `If-Modified-Since`, `If-None-Match`, `If-Match` headers

### Metadata

- `GET /metadata` — Full CapabilityStatement with all supported resources, search parameters, operations, and security information
- `GET /.well-known/smart-configuration` — SMART on FHIR discovery document
- `GET /health` — Server health check (status, uptime, database connectivity)
