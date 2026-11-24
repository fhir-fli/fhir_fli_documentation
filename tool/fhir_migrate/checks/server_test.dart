// Runs the app's own search and create code against a local HAPI server.
import 'dart:convert';
import 'dart:io';

import 'package:banny_table/resources/PaaProfiles.dart';
import 'package:banny_table/ui/welcomeScreen/healthProvider/selectPrimaryServer/datamodel/serverModelJson.dart';
import 'package:banny_table/utils/preference.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_storage/get_storage.dart';
import 'FHIR_IMPORT';

const base = 'http://127.0.0.1:8099/fhir';
const patientId = '1000';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final out = <String, dynamic>{};
  ServerModelJson server() => ServerModelJson(isSecure: false, displayName: 'local',
      title: 'local', url: base, clientId: '', isSelected: true, isPrimary: true);
  setUpAll(() async {
    HttpOverrides.global = null; // real network to the local server
    final dir = Directory.systemTemp.createTempSync('gs');
    const ch = MethodChannel('plugins.flutter.io/path_provider');
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(ch, (c) async => dir.path);
    await GetStorage.init();
    await Preference.shared.instance();
    GetStorage().write(Preference.serverUrlAllListed, jsonEncode([server().toJson()]));
  });
  tearDownAll(() => File(Platform.environment['EQUIV_OUT']!)
      .writeAsStringSync(const JsonEncoder.withIndent('  ').convert(out)));

  test('search for the seeded patient', () async {
    final r = await PaaProfiles.getPatientListTestUse(R4ResourceType.Patient, patientId, 'Lee', server());
    final j = r?.toJson() as Map<String, dynamic>?;
    out['search'] = {'resourceType': j?['resourceType'], 'total': j?['total'],
      'entryIds': [for (final e in (j?['entry'] as List? ?? [])) e['resource']['id']]};
  });

  test('create an observation', () async {
    final p = PaaProfiles();
    final s = DateTime.utc(2024, 3, 4, 10, 30);
    final e = DateTime.utc(2024, 3, 4, 11, 15);
    final obs = p.createChildActivityStepsObservation('', 'Ann Lee', patientId, s, e, 5400, identifierDataList: const []);
    out['createResult'] = await p.processResource(obs, 'steps', base, '', '');
  });
}
