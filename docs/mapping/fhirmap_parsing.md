---
id: fhirmap_parsing
title: FHIR Map Parser
---

# FHIR Map to StructureMap Parser in FHIR-FLI

## Understanding the StructureMap Parser

The StructureMap Parser is a crucial component in FHIR mapping that converts the human-readable FHIR mapping language into a formal StructureMap resource that the mapping engine can execute. This conversion process involves parsing the syntax, validating structure, and producing a properly formatted FHIR resource.

## Creating a StructureMap Parser

The parser must be created asynchronously due to internal setup requirements. Here's how to create a parser instance:

```dart
// Create a new StructureMap parser
final parser = await StructureMapParser.create();
```

This initialization sequence ensures that all the necessary components are properly set up before the parser is used.

## Basic Usage

Once you have a parser instance, you can use it to parse FHIR mapping language text:

```dart
// A string containing FHIR mapping language
final fhirMapText = '''
map "http://example.org/map/PatientToPersonMap" = PatientToPerson

uses "http://hl7.org/fhir/StructureDefinition/Patient" as source
uses "http://hl7.org/fhir/StructureDefinition/Person" as target

group PatientToPerson(source src : Patient, target tgt : Person) {
  src.name -> tgt.name;
  src.gender -> tgt.gender;
  src.birthDate -> tgt.birthDate;
}
''';

// Parse the mapping language into a StructureMap resource
try {
  final structureMap = parser.parse(fhirMapText, 'fhirmap');
  print('Successfully parsed StructureMap: ${structureMap.id}');
} catch (e) {
  print('Error parsing map: $e');
}
```

The `parse` method takes two parameters:
1. The FHIR mapping language text
2. A format identifier (typically 'fhirmap')

## Parsing Process Details

When the parser processes a FHIR map, it goes through several stages:

1. **Lexical Analysis** - Breaks down the text into tokens
2. **Syntactic Analysis** - Creates a parse tree from tokens
3. **Semantic Analysis** - Validates the meaning and relationships
4. **StructureMap Construction** - Builds the formal FHIR resource

Throughout this process, the parser handles:

- URL and identifier resolution
- Group and rule organization
- Transform operation mapping
- Syntax validation

## Handling Common Scenarios

### Parsing From Files

Often, you'll want to parse mapping files from the file system:

```dart
import 'dart:io';

Future<StructureMap> parseMapFile(String filePath) async {
  final parser = await StructureMapParser.create();
  final fileContent = await File(filePath).readAsString();
  return parser.parse(fileContent, 'fhirmap');
}
```

### Comparing Generated Maps to Existing Ones

When testing or validating your parser, you might want to compare the generated StructureMap to a known good version:

```dart
void compareGeneratedMap(String mapText, String referencePath) async {
  final parser = await StructureMapParser.create();
  
  // Parse the map text
  final generatedMap = parser.parse(mapText, 'fhirmap');
  
  // Load the reference map
  final referenceMapJson = jsonDecode(await File(referencePath).readAsString());
  final referenceMap = StructureMap.fromJson(referenceMapJson);
  
  // Compare the maps (excluding metadata fields)
  final generatedJson = generatedMap.toJson()
    ..remove('text')
    ..remove('meta');
  
  final referenceJson = referenceMap.toJson()
    ..remove('text')
    ..remove('meta');
  
  final equals = const DeepCollectionEquality().equals(referenceJson, generatedJson);
  print('Maps are equal: $equals');
}
```

## Error Handling and Debugging

The parser provides detailed error information when it encounters problems in the mapping language. Common issues include:

### Syntax Errors

If the map contains syntax errors, the parser will throw an exception with details about the location and nature of the error:

```dart
try {
  final structureMap = parser.parse(invalidMapText, 'fhirmap');
} catch (e) {
  print('Syntax error: $e');
  // Handle the error appropriately
}
```

### Validation Errors

Even with correct syntax, a map might have semantic problems like undefined sources or targets:

```dart
try {
  final structureMap = parser.parse(semanticallyInvalidMap, 'fhirmap');
} catch (e) {
  if (e.toString().contains('undefined source')) {
    print('Map references undefined source: $e');
    // Handle the specific error
  } else {
    print('Other validation error: $e');
  }
}
```

## Advanced Features

### Reusing the Parser

The same parser instance can be reused for multiple parsing operations, which is more efficient than creating a new parser each time:

```dart
Future<void> parseMapsInDirectory(String directoryPath) async {
  final dir = Directory(directoryPath);
  final parser = await StructureMapParser.create();
  
  for (final file in dir.listSync()) {
    if (file is File && file.path.endsWith('.map')) {
      try {
        final content = await File(file.path).readAsString();
        final map = parser.parse(content, 'fhirmap');
        print('Successfully parsed ${file.path}');
        
        // Do something with the map...
        
      } catch (e) {
        print('Error parsing ${file.path}: $e');
      }
    }
  }
}
```

### Serializing StructureMaps

After parsing, you might want to serialize the StructureMap to JSON for storage or transmission:

```dart
void saveStructureMap(StructureMap map, String outputPath) {
  final json = map.toJson();
  final prettyJson = JsonEncoder.withIndent('  ').convert(json);
  File(outputPath).writeAsStringSync(prettyJson);
  print('Saved StructureMap to $outputPath');
}
```

## Example: Complete Parsing Workflow

Here's a complete example that demonstrates parsing a FHIR map from a file, validating it, and saving the result:

```dart
import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:fhir_r4/fhir_r4.dart';
import 'package:fhir_r4_mapping/fhir_r4_mapping.dart';

Future<void> processMapFile(String inputPath, String outputPath) async {
  try {
    // Create the parser
    final parser = await StructureMapParser.create();
    
    // Read and parse the map file
    final mapContent = await File(inputPath).readAsString();
    final structureMap = parser.parse(mapContent, 'fhirmap');
    
    // Validate by comparing with a reference if available
    final referencePath = inputPath.replaceAll('.map', '.json');
    if (await File(referencePath).exists()) {
      final referenceJson = jsonDecode(await File(referencePath).readAsString());
      final referenceMap = StructureMap.fromJson(referenceJson);
      
      // Compare maps (excluding metadata)
      final generatedJson = structureMap.toJson()
        ..remove('text')
        ..remove('meta');
      
      final referenceJson2 = referenceMap.toJson()
        ..remove('text')
        ..remove('meta');
      
      final equals = const DeepCollectionEquality().equals(referenceJson2, generatedJson);
      print('Validation result: maps are ${equals ? "equal" : "different"}');
    }
    
    // Save the parsed map to the output path
    final prettyJson = JsonEncoder.withIndent('  ').convert(structureMap.toJson());
    await File(outputPath).writeAsString(prettyJson);
    print('Successfully processed and saved map to $outputPath');
    
  } catch (e, s) {
    print('Error processing map file: $e');
    print('Stack trace: $s');
  }
}
```

## Best Practices

When working with the StructureMap Parser, follow these best practices:

1. **Reuse the parser instance** for multiple parsing operations to improve performance
2. **Handle exceptions** properly to provide meaningful feedback about parsing errors
3. **Validate maps** against reference implementations when available
4. **Make parser creation asynchronous** as shown in the examples
5. **Store both map text and StructureMap resources** for easier maintenance

## Next Steps

Now that you understand how to parse FHIR mapping language into StructureMap resources, the next step is to learn how to use the [FHIR Mapping Engine](fhir_mapping_engine.md) to execute these maps and transform data.