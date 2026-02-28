---
id: fhir_r4_auth
title: FHIR R4 Auth
slug: /auth
---

# FHIR R4 Auth

Production-ready SMART on FHIR authentication and authorization for Flutter applications.

## What is FHIR R4 Auth?

`fhir_r4_auth` is a comprehensive authentication library that implements the [SMART App Launch Framework](http://hl7.org/fhir/smart-app-launch/) specification. It provides everything needed to build secure, compliant FHIR applications that integrate with Electronic Health Record (EHR) systems.

Also available as `fhir_r5_auth` and `fhir_r6_auth` for FHIR R5 and R6 with identical APIs.

## Key Features

- **Complete SMART Implementation** - Supports standalone launch and EHR launch types
- **Enterprise Security** - PKCE, secure token storage, JWT validation, audit logging
- **Multi-Platform** - Works on iOS, Android, Web, macOS, Windows, and Linux
- **Developer Friendly** - Type-safe API, comprehensive error handling
- **Session Management** - Idle and absolute timeouts, token refresh

## Quick Start

### Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  fhir_r4_auth: ^0.4.0
  fhir_r4: ^0.4.4
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
```

## Launch Types

### Standalone Launch
Your app launches independently and asks the user to authorize access.

**Use when:** Building patient-facing mobile apps, personal health record apps.

[Learn more →](auth/standalone-launch)

### EHR Launch
Your app is embedded within an EHR system and launched from the provider's workflow.

**Use when:** Building clinician-facing apps, clinical decision support tools.

## Core Concepts

### Security

- **PKCE** (Proof Key for Code Exchange) - Enabled by default (can be disabled for servers that don't support it)
- **Secure Token Storage** - Platform-specific secure storage
- **JWT Validation** - Full validation of ID tokens
- **Audit Logging** - Complete audit trail
- **Session Management** - Idle and absolute timeouts

### Token Management

- Automatic token refresh before expiry
- Token revocation support
- Token introspection (when supported by server)
- Secure encrypted storage

## Platform Notes

### Web
Create a `web/callback.html` that stores the redirect URL in localStorage and posts it via `window.postMessage`:

```html
<!DOCTYPE html>
<html><body><script>
  const url = window.location.href;
  window.localStorage.setItem('flutter-web-auth-2', url);
  window.opener.postMessage({'flutter-web-auth-2': url}, '*');
  window.close();
</script></body></html>
```

### Android
Add `manifestPlaceholders["appAuthRedirectScheme"]` in `android/app/build.gradle.kts`. URI schemes cannot have underscores (RFC 3986) - use hyphens instead.

### Desktop (Linux/Windows)
`flutter_web_auth_2` starts a temporary HTTP server on the callback port. Set `callbackUrlScheme` to the full origin (e.g., `http://localhost:8080`).

## Epic Integration Notes

When integrating with Epic's FHIR sandbox:

- **Disable PKCE** (`enablePkce: false`) - Epic sandbox rejects `code_challenge`/`code_challenge_method`
- **Disable OpenID** (`enableOpenId: false`) - Epic rejects the `nonce` parameter
- **EHR launch scopes:** Use `['launch']` only - wider scopes may cause OAuth errors

## Next Steps

1. **[Install the library](auth/installation)** - Add to your project
2. **[Standalone launch guide](auth/standalone-launch)** - Step-by-step standalone launch

## Resources

- [GitHub Repository](https://github.com/fhir-fli/fhir_r4)
- [SMART App Launch Specification](http://hl7.org/fhir/smart-app-launch/)
