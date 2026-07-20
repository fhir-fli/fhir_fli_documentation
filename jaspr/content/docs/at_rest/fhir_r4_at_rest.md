---
id: fhir_r4_at_rest
title: At Rest Package
---

## FHIR R4 At Rest

The package for interacting with FHIR servers. It handles request construction and response parsing, while authentication is handled by passing authenticated HTTP clients (for example, from the `fhir_r4_auth` package).

### Installation

```yaml
dependencies:
  fhir_r4_at_rest: ^0.7.0
  fhir_r4: ^0.7.0

  # Optional: for authenticated requests
  fhir_r4_auth: ^0.7.0
```