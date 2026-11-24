// Builds the same Observations with the app's own builders and writes their
// JSON, so the fhir 0.12 build and the fhir_r4 build can be compared.
import 'dart:convert';
import 'dart:io';

import 'package:banny_table/resources/PaaProfiles.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_storage/get_storage.dart';
import 'package:banny_table/utils/preference.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async {
    final dir = Directory.systemTemp.createTempSync('gs');
    const ch = MethodChannel('plugins.flutter.io/path_provider');
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(ch, (c) async => dir.path);
    await GetStorage.init();
    await Preference.shared.instance();
  });

  test('builders', () {
    final p = PaaProfiles();
    final s = DateTime.utc(2024, 3, 4, 10, 30);
    final e = DateTime.utc(2024, 3, 4, 11, 15);
    final out = <String, dynamic>{
      'parent': p.createParentActivityObservation('o1', 'Ann Lee', 'p1', 'Walking', s, e, [], identifierDataList: const []).toJson(),
      'name': p.createChildActivityNameObservation('o2', 'Ann Lee', 'p1', '55411-3', 'Walking', s, e, identifierDataList: const []).toJson(),
      'totalMin': p.createChildActivityTotalMinObservation('o3', 'Ann Lee', 'p1', s, e, 45, 'a note', identifierDataList: const []).toJson(),
      'modMin': p.createChildActivityModerateMinObservation('o4', 'Ann Lee', 'p1', s, e, 30, identifierDataList: const []).toJson(),
      'vigMin': p.createChildActivityVigorousMinObservation('o5', 'Ann Lee', 'p1', s, e, 15, identifierDataList: const []).toJson(),
      'peakHr': p.createChildActivityPeakHeartRateObservation('o6', 'Ann Lee', 'p1', s, e, 142, identifierDataList: const []).toJson(),
      'calories': p.createChildActivityCaloriesObservation('o7', 'Ann Lee', 'p1', s, e, 210.5, identifierDataList: const []).toJson(),
      'steps': p.createChildActivityStepsObservation('o8', 'Ann Lee', 'p1', s, e, 5400, identifierDataList: const []).toJson(),
      'experience': p.createChildActivityExObservation('o9', 'Ann Lee', 'p1', s, e, 'LA6111-4', 'Good', identifierDataList: const []).toJson(),
      'parent_new': p.createParentActivityObservation('', 'Ann Lee', 'p1', 'Walking', s, e, [], identifierDataList: const []).toJson(),
      'name_new': p.createChildActivityNameObservation('', 'Ann Lee', 'p1', '55411-3', 'Walking', s, e, identifierDataList: const []).toJson(),
      'totalMin_new': p.createChildActivityTotalMinObservation('', 'Ann Lee', 'p1', s, e, 45, 'a note', identifierDataList: const []).toJson(),
      'modMin_new': p.createChildActivityModerateMinObservation('', 'Ann Lee', 'p1', s, e, 30, identifierDataList: const []).toJson(),
      'vigMin_new': p.createChildActivityVigorousMinObservation('', 'Ann Lee', 'p1', s, e, 15, identifierDataList: const []).toJson(),
      'peakHr_new': p.createChildActivityPeakHeartRateObservation('', 'Ann Lee', 'p1', s, e, 142, identifierDataList: const []).toJson(),
      'calories_new': p.createChildActivityCaloriesObservation('', 'Ann Lee', 'p1', s, e, 210.5, identifierDataList: const []).toJson(),
      'steps_new': p.createChildActivityStepsObservation('', 'Ann Lee', 'p1', s, e, 5400, identifierDataList: const []).toJson(),
      'experience_new': p.createChildActivityExObservation('', 'Ann Lee', 'p1', s, e, 'LA6111-4', 'Good', identifierDataList: const []).toJson(),
    };
    File(Platform.environment['EQUIV_OUT']!)
        .writeAsStringSync(const JsonEncoder.withIndent('  ').convert(out));
  });
}
