---
id: installation
title: Installation
---

# Installation

This guide walks through installing and configuring `fhir_r4_auth` in your Flutter project.

## Requirements

- **Flutter**: >= 3.10.0
- **Dart**: >= 3.0.0
- **Platforms**: iOS, Android, Web, macOS, Windows, Linux

## Add to Your Project

### 1. Update pubspec.yaml

Add the dependencies to your `pubspec.yaml`:

```yaml
dependencies:
  fhir_r4_auth: ^0.4.0
  fhir_r4: ^0.4.4
```

For R5 or R6, use `fhir_r5_auth`/`fhir_r6_auth` and `fhir_r5`/`fhir_r6` instead.

### 2. Install Packages

```bash
flutter pub get
```

## Platform Configuration

Different platforms require specific setup for OAuth authentication to work properly.

### iOS Configuration

Add the following to `ios/Runner/Info.plist`:

```xml
<key>CFBundleURLTypes</key>
<array>
  <dict>
    <key>CFBundleURLSchemes</key>
    <array>
      <string>com.yourcompany.yourapp</string>
    </array>
  </dict>
</array>
```

Replace `com.yourcompany.yourapp` with your app's bundle ID or custom scheme.

### Android Configuration

In `android/app/build.gradle.kts`, add the redirect scheme:

```kotlin
android {
    defaultConfig {
        manifestPlaceholders["appAuthRedirectScheme"] = "com.yourcompany.yourapp"
    }
}
```

**Important:** URI schemes cannot contain underscores per RFC 3986. Use hyphens instead (e.g., `com.example.my-app`).

If you use `flutter_web_auth_2` alongside `flutter_appauth` (transitive dependency), add `tools:node="remove"` to prevent `RedirectUriReceiverActivity` from intercepting redirects:

```xml
<activity
    android:name="net.openid.appauth.RedirectUriReceiverActivity"
    tools:node="remove" />
```

### Web Configuration

Create a file `web/callback.html`:

```html
<!DOCTYPE html>
<html>
<head><meta charset="utf-8"><title>Auth Callback</title></head>
<body>
<script>
  const url = window.location.href;
  window.localStorage.setItem('flutter-web-auth-2', url);
  if (window.opener) {
    window.opener.postMessage({'flutter-web-auth-2': url}, '*');
  }
  window.close();
</script>
</body>
</html>
```

### Desktop (Linux/Windows)

Install required system dependencies:

```bash
# Linux
sudo apt-get install -y libwebkit2gtk-4.1-dev libsecret-1-dev
```

Desktop platforms use `flutter_web_auth_2` which starts a temporary HTTP server on the callback port.

## Verify Installation

Create a simple test to verify everything is installed correctly:

```dart
import 'package:fhir_r4_auth/fhir_r4_auth.dart';
import 'package:fhir_r4/fhir_r4.dart';

void main() {
  final config = SmartConfig(
    clientId: 'test',
    fhirBaseUrl: 'https://example.com'.toFhirUri,
    redirectUri: Uri.parse('com.test://callback'),
    scopes: ['patient/*.read'],
  );

  print('fhir_r4_auth is installed correctly!');
  print('Config: ${config.clientId}');
}
```

## Next Steps

1. **[Choose your launch type](/docs/auth/standalone-launch)** - Standalone or EHR
2. **[Overview and API reference](/docs/auth)** - Full feature overview
