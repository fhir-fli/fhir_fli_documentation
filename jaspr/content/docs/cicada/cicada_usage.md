---
id: cicada_usage
title: Usage & API
---

## Usage & API

### Basic Forecasting

The primary entry point is `forecastFromParameters()`:

```dart
import 'package:cicada/cicada.dart';
import 'package:fhir_r4/fhir_r4.dart';

// Run a CDC forecast (default)
final Parameters result = forecastFromParameters(inputParameters);

// Run a WHO forecast
final Parameters whoResult = forecastFromParameters(
  inputParameters,
  mode: ForecastMode.who,
);
```

### Building Input Parameters

The input is a FHIR R4 `Parameters` resource. Each parameter has a `name` and either a `resource` or a value:

```dart
final input = Parameters(parameter: [
  // Assessment date (the date to evaluate against)
  ParametersParameter(name: FhirString('2024-06-15')),

  // Patient demographics
  ParametersParameter(
    name: FhirString('patient'),
    resource: Patient(
      birthDate: FhirDate('2024-01-15'),
      gender: PatientGender.male,
    ),
  ),

  // Past immunizations
  ParametersParameter(
    name: FhirString('immunization'),
    resource: Immunization(
      status: ImmunizationStatus.completed,
      vaccineCode: CodeableConcept(coding: [
        Coding(
          system: FhirUri('http://hl7.org/fhir/sid/cvx'),
          code: FhirCode('110'), // DTaP-HepB-IPV
        ),
      ]),
      occurrenceDateTime: FhirDateTime('2024-03-15'),
      patient: Reference(reference: FhirString('Patient/1')),
    ),
  ),

  // Clinical conditions (optional)
  ParametersParameter(
    name: FhirString('condition'),
    resource: Condition(
      code: CodeableConcept(coding: [
        Coding(
          system: FhirUri('http://snomed.info/sct'),
          code: FhirCode('370388006'), // Patient immunocompromised
        ),
      ]),
      subject: Reference(reference: FhirString('Patient/1')),
    ),
  ),
]);
```

#### Assessment Date

The assessment date is encoded as a parameter whose `name` is the date string (e.g., `"2024-06-15"`). This is the date against which all age calculations and interval checks are performed.

#### Supported Resource Types

| Resource | Parameter Name | Purpose |
|----------|---------------|---------|
| `Patient` | `patient` | Demographics (birth date, sex) |
| `Immunization` | `immunization` | Past vaccine doses (CVX code, date) |
| `Condition` | `condition` | Clinical conditions |
| `AllergyIntolerance` | `allergyIntolerance` | Allergies and contraindications |
| `Observation` | `observation` | Clinical observations |
| `Procedure` | `procedure` | Relevant procedures |
| `MedicationStatement` | `medicationStatement` | Medication history |
| `MedicationRequest` | `medicationRequest` | Active prescriptions |
| `MedicationAdministration` | `medicationAdministration` | Administered medications |

#### CVX Codes

Vaccine doses are identified by [CVX (Vaccine Administered)](https://www2a.cdc.gov/vaccines/iis/iisstandards/vaccines.asp?rpt=cvx) codes. The engine maps each CVX code to one or more target diseases using the schedule supporting data.

### Reading the Output

The output `Parameters` contains `ImmunizationEvaluation` and `ImmunizationRecommendation` resources:

```dart
final result = forecastFromParameters(input);

for (final param in result.parameter ?? []) {
  if (param.resource is ImmunizationEvaluation) {
    final eval = param.resource as ImmunizationEvaluation;
    print('Dose: ${eval.date}');
    print('Status: ${eval.status}');
    print('Target Disease: ${eval.targetDisease}');
    print('Dose Number: ${eval.doseNumberPositiveInt}');
  }

  if (param.resource is ImmunizationRecommendation) {
    final rec = param.resource as ImmunizationRecommendation;
    for (final recommendation in rec.recommendation ?? []) {
      print('Vaccine Group: ${recommendation.vaccineCode}');
      print('Forecast Status: ${recommendation.forecastStatus}');
      for (final dateCriterion in recommendation.dateCriterion ?? []) {
        print('${dateCriterion.code}: ${dateCriterion.value}');
      }
    }
  }
}
```

#### Forecast Statuses

| Status | Meaning |
|--------|---------|
| Not Complete | More doses needed; forecast dates provided |
| Complete | Series is complete; no more doses needed |
| Immune | Patient has clinical evidence of immunity |
| Contraindicated | Vaccine is contraindicated for this patient |
| Not Recommended | Vaccine is not recommended (e.g., aged out) |
| Aged Out | Patient has exceeded the maximum age for the series |

#### Dose Statuses

| Status | Meaning |
|--------|---------|
| Valid | Dose meets all requirements |
| Not Valid | Dose fails one or more checks |
| Sub-standard | Dose partially meets requirements |
| Extraneous | Dose is not needed by the series |

### Lower-Level API

For more control, use `evaluateForForecast()` which returns the full model hierarchy:

```dart
final ForecastResult result = evaluateForForecast(
  input,
  mode: ForecastMode.cdc,
);

// Access the parsed patient
final VaxPatient patient = result.patient;
print('Birth date: ${patient.dob}');

// Access antigen-level results
for (final entry in result.agMap.entries) {
  final String disease = entry.key;
  final VaxAntigen antigen = entry.value;
  print('$disease: ${antigen.seriesStatus}');
}

// Access vaccine group forecasts
for (final entry in result.vaccineGroupForecasts.entries) {
  final String groupName = entry.key;
  final VaccineGroupForecast forecast = entry.value;
  print('$groupName: ${forecast.status}');
  print('  Recommended: ${forecast.recommendedDate}');
  print('  Earliest: ${forecast.earliestDate}');
  print('  Past due: ${forecast.pastDueDate}');
}
```

### ForecastMode

The `ForecastMode` enum controls which supporting data is used:

```dart
// Check current mode
print(currentForecastMode); // ForecastMode.cdc

// Set mode explicitly
setForecastMode(ForecastMode.who);

// Or pass mode to forecast functions
forecastFromParameters(input, mode: ForecastMode.who);
```

The mode selects between:
- `activeAntigenMap` — CDC's `antigenSupportingDataMap` or WHO's `whoAntigenSupportingDataMap`
- `activeScheduleData` — CDC's `scheduleSupportingData` or WHO's `whoScheduleSupportingData`
- `activeMultiAntigenGroups` — Derived from the active schedule's vaccine-group-to-antigen map

### ImmDS Server

Cicada includes an HTTP server for the FHIR `$immds-forecast` operation:

```bash
# Start the server
dart run bin/server.dart -p 8080

# CDC forecast (JSON)
curl -X POST http://localhost:8080/\$immds-forecast \
  -H 'Content-Type: application/fhir+json' \
  -d @input.json

# CDC forecast (XML)
curl -X POST http://localhost:8080/\$immds-forecast \
  -H 'Content-Type: application/xml' \
  -H 'Accept: application/xml' \
  -d @input.xml

# WHO forecast (JSON)
curl -X POST http://localhost:8080/\$immds-forecast-who \
  -H 'Content-Type: application/fhir+json' \
  -d @input.json
```

Both `$immds-forecast` (CDC) and `$immds-forecast-who` (WHO) accept identical FHIR `Parameters` input.

The server:
- Accepts JSON or XML FHIR Parameters
- Returns the same format as the input (or as specified by `Accept` header)
- Includes CORS headers for browser clients
- Logs requests to stdout
- Serves a metadata endpoint at `GET /metadata`

#### FITS Testing

The server is compatible with [NIST FITS](https://fits.nist.gov) (Forecasting and Immunization Testing Standard). To test:

1. Start the server: `dart run bin/server.dart -p 8080`
2. Expose with ngrok: `ngrok http 8080`
3. Register the ngrok URL in FITS as an R4 endpoint
4. Run FITS test suites

FITS sends XML with `Content-Type: application/xml; charset=utf8` and `Accept: application/xml`.

### From JSON Map

If you have the input as a raw JSON map:

```dart
final Map<String, dynamic> jsonInput = {
  'resourceType': 'Parameters',
  'parameter': [/* ... */],
};

final Parameters result = forecastFromMap(jsonInput);
// Or with WHO mode:
final Parameters whoResult = forecastFromMap(jsonInput, mode: ForecastMode.who);
```
