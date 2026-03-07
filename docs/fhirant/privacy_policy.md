---
id: fhirant_privacy_policy
title: Privacy Policy
---

# FHIR ANT Privacy Policy

**Effective date:** March 7, 2026
**Last updated:** March 7, 2026

## Summary

FHIR ANT stores all data locally on your device. We do not collect, transmit, or have access to any of your data.

## What Data FHIR ANT Handles

FHIR ANT is a FHIR R4 server that runs entirely on your device. It may store:

- **FHIR resources** (Patient, Observation, Condition, etc.) that you or connected clients create
- **User accounts** (username and hashed password) for authentication
- **Server logs** (request timestamps, methods, paths, and client IP addresses)
- **Encryption keys** stored in your device's secure keystore (Android Keystore)

## Where Data Is Stored

All data is stored **locally on your device** in an encrypted SQLite database. The encryption key is generated on first launch and stored in the device's hardware-backed secure keystore.

## Data Transmission

FHIR ANT is a server — it **receives** requests from clients on your local network. It does not:

- Send data to any external servers
- Include analytics or telemetry
- Phone home or check for updates
- Transmit data over the internet (unless you explicitly expose it)

When the server is running, devices on the same network can connect to it via HTTP. **You control who has access** by managing your network and the server's authentication settings.

## Third-Party Services

FHIR ANT does not use any third-party services, SDKs, or analytics platforms.

## Data Retention

Data persists on your device until you:
- Delete individual resources through the FHIR API
- Uninstall the app (which removes all app data)
- Clear the app's data through Android settings

## Children's Privacy

FHIR ANT is a developer and healthcare professional tool. It is not directed at children under 13. We do not knowingly collect personal information from children.

## Security

- Database encrypted with SQLCipher (AES-256)
- Encryption key stored in Android Keystore
- Passwords hashed with bcrypt
- JWT-based authentication (when Dev Mode is off)
- Account lockout after failed login attempts

## Your Rights

Since all data is stored locally on your device, you have full control over it at all times. You can read, modify, export (via `$backup`), or delete any data through the FHIR API or by uninstalling the app.

## Open Source

FHIR ANT is open source. You can review the complete source code at [github.com/fhir-fli/fhir](https://github.com/fhir-fli/fhir).

## Contact

If you have questions about this privacy policy:
- GitHub: [github.com/fhir-fli](https://github.com/fhir-fli)
- Website: [fhirfli.dev](https://fhirfli.dev)

## Changes

We may update this privacy policy from time to time. Changes will be posted on this page with an updated "Last updated" date.
