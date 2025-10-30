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
  fhir_r4: ^0.4.2
```

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

[Full iOS setup guide →](platform/ios)

### Android Configuration

Add to `android/app/src/main/AndroidManifest.xml` inside the `<application>` tag:

```xml
<activity
    android:name="com.linusu.flutter_web_auth_2.CallbackActivity"
    android:exported="true">
  <intent-filter android:label="flutter_web_auth_2">
    <action android:name="android.intent.action.VIEW" />
    <category android:name="android.intent.category.DEFAULT" />
    <category android:name="android.intent.category.BROWSABLE" />
    <data android:scheme="com.yourcompany.yourapp" />
  </intent-filter>
</activity>
```

Replace `com.yourcompany.yourapp` with your app's package name or custom scheme.

[Full Android setup guide →](platform/android)

### Web Configuration

Create a file `web/redirect.html`:

```html
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>Authentication Redirect</title>
</head>
<body>
<script>
  // Post the full redirect URL back to the opener window
  if (window.opener) {
    window.opener.postMessage(window.location.href, '*');
    window.close();
  }
</script>
</body>
</html>
```

Your redirect URI will be `https://your-domain.com/redirect.html`.

[Full Web setup guide →](platform/web)

### Desktop (macOS, Windows, Linux)

Desktop platforms use platform-specific secure storage and URL handlers.

[Full Desktop setup guide →](platform/desktop)

## Verify Installation

Create a simple test to verify everything is installed correctly:

```dart
import 'package:fhir_r4_auth/fhir_r4_auth.dart';
import 'package:fhir_r4/fhir_r4.dart';

void main() {
  // Test that imports work
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

Run with:
```bash
dart run
```

## Common Issues

### "Package not found"

If you see this error:
```
Because yourapp depends on fhir_r4_auth which doesn't exist, version solving failed.
```

Make sure you've run `flutter pub get` and that your `pubspec.yaml` is correctly formatted.

### "Unsupported platform"

`fhir_r4_auth` supports all Flutter platforms. If you see a platform error, ensure you're using:
- Flutter >= 3.10.0
- Dart >= 3.0.0

Run `flutter doctor` to check your installation.

### iOS Build Errors

If you encounter iOS build errors after installation:

1. Clean your build:
   ```bash
   cd ios
   pod cache clean --all
   rm -rf Pods
   rm Podfile.lock
   flutter clean
   flutter pub get
   cd ios
   pod install
   ```

2. Ensure you're targeting iOS 12.0 or higher in `ios/Podfile`:
   ```ruby
   platform :ios, '12.0'
   ```

### Android Build Errors

If you see errors about `compileSdkVersion` or `minSdkVersion`:

In `android/app/build.gradle`, ensure:
```gradle
android {
    compileSdkVersion 33
    
    defaultConfig {
        minSdkVersion 21
        targetSdkVersion 33
    }
}
```

## Next Steps

Now that you've installed the package:

1. **[Choose your launch type](standalone-launch)** - Standalone, EHR, or Backend Services
2. **[Configure your platform](platform/ios)** - Complete platform-specific setup
3. **[Set up your FHIR server](servers/epic)** - Configure server integration

## Need Help?

- Check the [Troubleshooting Guide](troubleshooting)
- Ask in [GitHub Discussions](https://github.com/fhirfli/fhir_r4_auth/discussions)
- Report bugs in [GitHub Issues](https://github.com/fhirfli/fhir_r4_auth/issues)