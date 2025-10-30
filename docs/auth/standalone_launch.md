---
id: standalone-launch
title: Standalone Launch
---

# Standalone Launch

Standalone launch is used when your app launches independently (not embedded in an EHR) and needs to authenticate a user to access their health data.

## When to Use Standalone Launch

Use standalone launch for:
- **Patient-facing mobile apps** - Apps patients download and use independently
- **Personal health record apps** - Apps that manage personal health information
- **Consumer health apps** - Fitness, wellness, or health tracking applications
- **Research apps** - Apps for clinical studies or data collection

## How It Works

```
┌─────────────┐                    ┌──────────────┐                    ┌─────────────┐
│   Your App  │                    │ FHIR Server  │                    │    User     │
└──────┬──────┘                    └──────┬───────┘                    └──────┬──────┘
       │                                  │                                   │
       │  1. Get server capabilities     │                                   │
       ├─────────────────────────────────>│                                   │
       │                                  │                                   │
       │  2. Redirect to auth URL         │                                   │
       ├──────────────────────────────────┼──────────────────────────────────>│
       │                                  │                                   │
       │                                  │  3. User logs in & authorizes     │
       │                                  │<──────────────────────────────────┤
       │                                  │                                   │
       │  4. Redirect back with auth code │                                   │
       │<─────────────────────────────────┼───────────────────────────────────┤
       │                                  │                                   │
       │  5. Exchange code for tokens     │                                   │
       ├─────────────────────────────────>│                                   │
       │                                  │                                   │
       │  6. Access token & refresh token │                                   │
       │<─────────────────────────────────┤                                   │
       │                                  │                                   │
       │  7. Make FHIR requests           │                                   │
       ├─────────────────────────────────>│                                   │
       │                                  │                                   │
```

## Basic Implementation

### Step 1: Create the Client

```dart
import 'package:fhir_r4_auth/fhir_r4_auth.dart';

final client = SmartFhirClient(
  config: SmartConfig(
    // Your registered client ID
    clientId: 'your-app-client-id',
    
    // FHIR server base URL
    fhirBaseUrl: 'https://fhir.epic.com/interconnect-fhir-oauth/api/FHIR/R4'.toFhirUri,
    
    // Your app's redirect URI (must be registered)
    redirectUri: Uri.parse('com.yourcompany.yourapp://callback'),
    
    // Scopes you're requesting
    scopes: [
      'patient/*.read',           // Read all patient resources
      'launch/patient',           // Patient context
      'offline_access',           // Refresh token
    ],
    
    // Launch type (standalone is default)
    launchType: LaunchType.standalone,
    
    // Enable PKCE (recommended, enabled by default)
    enablePkce: true,
    
    // Request OpenID Connect (recommended)
    enableOpenId: true,
  ),
);
```

### Step 2: Authenticate

```dart
try {
  await client.authenticate();
  print('Successfully authenticated!');
  
  // Client is now ready to make FHIR requests
} on AuthenticationException catch (e) {
  print('Authentication failed: ${e.message}');
  // Handle error
} on NetworkException catch (e) {
  print('Network error: ${e.message}');
  // Handle network issues
}
```

### Step 3: Make FHIR Requests

Once authenticated, use the client to make FHIR requests:

```dart
// Read a resource
final patient = await client.read(
  resourceType: 'Patient',
  id: 'patient-id',
);

// Search for resources
final observations = await client.search(
  resourceType: 'Observation',
  parameters: {
    'patient': 'patient-id',
    'category': 'vital-signs',
    '_count': '10',
  },
);

// Create a resource
final newObservation = Observation(/* ... */);
final created = await client.create(
  resource: newObservation,
);

// Update a resource
patient.name?.first?.text = FhirString('Updated Name');
final updated = await client.update(
  resource: patient,
);
```

## Complete Example

Here's a complete Flutter app with standalone launch:

```dart
import 'package:flutter/material.dart';
import 'package:fhir_r4_auth/fhir_r4_auth.dart';
import 'package:fhir_r4/fhir_r4.dart';

void main() {
  runApp(MyHealthApp());
}

class MyHealthApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Health App',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SmartFhirClient? _client;
  Patient? _patient;
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _initializeClient();
  }

  void _initializeClient() {
    _client = SmartFhirClient(
      config: SmartConfig(
        clientId: 'your-client-id',
        fhirBaseUrl: 'https://fhir.epic.com/interconnect-fhir-oauth/api/FHIR/R4'.toFhirUri,
        redirectUri: Uri.parse('com.yourcompany.yourapp://callback'),
        scopes: ['patient/*.read', 'launch/patient', 'offline_access'],
      ),
    );
  }

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      await _client!.authenticate();
      
      // Get patient ID from token response
      final patientId = _client!.patientId;
      
      if (patientId != null) {
        // Fetch patient data
        final patient = await _client!.read(
          resourceType: 'Patient',
          id: patientId,
        ) as Patient;
        
        setState(() {
          _patient = patient;
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _logout() async {
    await _client?.logout();
    setState(() {
      _patient = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Health App'),
        actions: _patient != null
            ? [
                IconButton(
                  icon: Icon(Icons.logout),
                  onPressed: _logout,
                ),
              ]
            : null,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error, size: 64, color: Colors.red),
            SizedBox(height: 16),
            Text('Error: $_error'),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _login,
              child: Text('Try Again'),
            ),
          ],
        ),
      );
    }

    if (_patient == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.medical_services, size: 64),
            SizedBox(height: 16),
            Text('Welcome to My Health App'),
            SizedBox(height: 8),
            Text('Connect to your health records'),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: _login,
              child: Text('Connect Health Records'),
            ),
          ],
        ),
      );
    }

    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        Card(
          child: ListTile(
            leading: Icon(Icons.person),
            title: Text(_patient!.name?.first?.text?.value ?? 'Unknown'),
            subtitle: Text('Patient ID: ${_patient!.id}'),
          ),
        ),
        // Add more patient information here
      ],
    );
  }

  @override
  void dispose() {
    _client?.close();
    super.dispose();
  }
}
```

## Configuration Options

### Scopes

Scopes control what data your app can access:

```dart
scopes: [
  // Patient resources
  'patient/Patient.read',         // Read patient demographics
  'patient/Observation.read',     // Read observations
  'patient/Condition.read',       // Read conditions
  'patient/MedicationRequest.read', // Read medications
  'patient/*.read',               // Read all patient resources
  
  // Launch context
  'launch/patient',               // Get patient context
  
  // Special scopes
  'offline_access',               // Request refresh token
  'openid',                       // OpenID Connect
  'fhirUser',                     // Get user identity
],
```

[Learn more about scopes →](https://www.hl7.org/fhir/smart-app-launch/scopes-and-launch-context.html)

### Custom Parameters

Add custom parameters to the authorization request:

```dart
config: SmartConfig(
  // ... other config
  customParameters: {
    'aud': 'https://fhir.epic.com',
    'custom_param': 'value',
  },
),
```

## Session Management

Add session management to handle timeouts:

```dart
final client = SmartFhirClient(
  config: config,
  sessionManager: SessionManager(
    idleTimeout: Duration(minutes: 15),
    absoluteTimeout: Duration(hours: 8),
  ),
);

// Listen for timeout warnings
client.onSessionTimeoutWarning?.listen((remaining) {
  print('Session expires in ${remaining.inMinutes} minutes');
  // Show warning to user
});

// Listen for session expiry
client.onSessionTimeout?.listen((reason) {
  print('Session ended: $reason');
  // Redirect to login
});

// Record activity to prevent idle timeout
await client.recordActivity();
```

## Error Handling

Handle common error scenarios:

```dart
try {
  await client.authenticate();
} on AuthenticationException catch (e) {
  // User cancelled or auth failed
  if (e.message.contains('cancelled')) {
    print('User cancelled authentication');
  } else {
    print('Authentication error: ${e.message}');
  }
} on ConfigurationException catch (e) {
  // Configuration problem
  print('Configuration error: ${e.message}');
  print('Check field: ${e.configurationField}');
} on NetworkException catch (e) {
  // Network problem
  print('Network error: ${e.statusCode}: ${e.message}');
} catch (e) {
  // Other errors
  print('Unexpected error: $e');
}
```

## Testing

Test standalone launch in your app:

1. **Use a sandbox** - Start with [SMART Health IT Sandbox](servers/smart-sandbox)
2. **Register your app** - Get a client ID and register your redirect URI
3. **Test authentication flow** - Verify the full OAuth flow works
4. **Test token refresh** - Ensure tokens refresh automatically
5. **Test logout** - Verify tokens are revoked on logout

## Next Steps

- **[Platform Setup](platform/ios)** - Configure iOS, Android, Web
- **[Token Management](token-management)** - Handle refresh and revocation
- **[Session Management](session-management)** - Implement timeouts
- **[Server Integration](servers/epic)** - Connect to specific servers

## Troubleshooting

See the [Troubleshooting Guide](troubleshooting) for common issues with standalone launch.