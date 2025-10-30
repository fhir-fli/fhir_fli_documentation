---
id: fhir_r4_auth
title: FHIR R4 Auth
slug: /auth
---

# FHIR R4 Auth <img src="/fhir_fli_documentation/img/fhir-fli-logo.png" alt="FHIR-FLI Logo" style={{width: "150px", verticalAlign: "middle"}} />

Production-ready SMART on FHIR authentication and authorization for Flutter applications.

## What is FHIR R4 Auth?

`fhir_r4_auth` is a comprehensive authentication library that implements the complete [SMART App Launch Framework](http://hl7.org/fhir/smart-app-launch/) specification. It provides everything needed to build secure, compliant FHIR applications that integrate with Electronic Health Record (EHR) systems.

## Key Features

- ✅ **Complete SMART Implementation** - Supports all launch types (standalone, EHR, backend services)
- ✅ **Enterprise Security** - PKCE, secure token storage, JWT validation, audit logging
- ✅ **Multi-Platform** - Works on iOS, Android, Web, macOS, Windows, and Linux
- ✅ **Developer Friendly** - Type-safe API, comprehensive error handling, extensive examples
- ✅ **Battle-Tested** - 386+ tests, works with Epic, Cerner, and other major EHR systems

## Quick Start

### Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  fhir_r4_auth: ^0.4.0
  fhir_r4: ^0.4.2
```

### Basic Example

```dart
import 'package:fhir_r4_auth/fhir_r4_auth.dart';

// Configure your client
final client = SmartFhirClient(
  config: SmartConfig(
    clientId: 'your-client-id',
    fhirBaseUrl: 'https://fhir.example.com/r4'.toFhirUri,
    redirectUri: Uri.parse('com.yourapp://callback'),
    scopes: ['patient/*.read', 'launch/patient'],
  ),
);

// Authenticate
await client.authenticate();

// Make FHIR requests
final patient = await client.read(
  resourceType: 'Patient',
  id: 'patient-123',
);
```

## Launch Types

### Standalone Launch
Your app launches independently and asks the user to authorize access.

**Use when:** Building patient-facing mobile apps, personal health record apps.

[Learn more →](standalone-launch)

### EHR Launch
Your app is embedded within an EHR system and launched from the provider's workflow.

**Use when:** Building clinician-facing apps, clinical decision support tools.

[Learn more →](ehr-launch)

### Backend Services
Server-to-server authentication using client credentials and JWT assertions.

**Use when:** Building analytics platforms, data pipelines, bulk data exports.

[Learn more →](backend-services)

## Core Concepts

### Security

- **PKCE** (Proof Key for Code Exchange) - Enabled by default
- **Secure Token Storage** - Platform-specific secure storage
- **JWT Validation** - Full validation of ID tokens
- **Audit Logging** - Complete audit trail
- **Session Management** - Idle and absolute timeouts

[Security guide →](security)

### Token Management

- Automatic token refresh before expiry
- Token revocation support
- Token introspection (when supported by server)
- Secure encrypted storage

[Token management guide →](token-management)

## Platform Support

Configure authentication for your target platform:

- [iOS Setup](platform/ios) - Keychain configuration
- [Android Setup](platform/android) - KeyStore and deep linking
- [Web Setup](platform/web) - Redirect handling
- [Desktop Setup](platform/desktop) - macOS, Windows, Linux

## Server Integration

Tested and working with major FHIR servers:

- [Epic](servers/epic) - Epic EHR integration
- [Cerner/Oracle Health](servers/cerner) - Cerner integration
- [SMART Health IT Sandbox](servers/smart-sandbox) - Testing environment
- [Google Cloud Healthcare](servers/google-healthcare) - GCP integration

## What's New in fhir_r4_auth?

Migrating from the older `fhir_auth` package? Here's what's improved:

| Feature | Old fhir_auth | New fhir_r4_auth |
|---------|---------------|------------------|
| **SMART Spec** | Partial | Complete ✅ |
| **Security** | Basic | Enterprise-grade ✅ |
| **Platform Support** | Mobile + Web | All platforms ✅ |
| **Session Management** | None | Full support ✅ |
| **Token Revocation** | No | Yes ✅ |
| **Token Introspection** | No | Yes ✅ |
| **Audit Logging** | No | Yes ✅ |
| **Type Safety** | Partial | Complete ✅ |
| **Tests** | ~50 | 386+ ✅ |

[Migration guide →](migration)

## Next Steps

1. **[Install the library](installation)** - Add to your project
2. **[Choose your launch type](standalone-launch)** - Standalone, EHR, or Backend
3. **[Platform setup](platform/ios)** - Configure your target platform
4. **[Server integration](servers/epic)** - Connect to your FHIR server

## Resources

- [GitHub Repository](https://github.com/fhirfli/fhir_r4_auth)
- [API Documentation](https://pub.dev/documentation/fhir_r4_auth/latest/)
- [Report Issues](https://github.com/fhirfli/fhir_r4_auth/issues)
- [Discussions](https://github.com/fhirfli/fhir_r4_auth/discussions)