import 'dart:collection';
import 'package:uuid/uuid.dart';
import 'package:nurse_os/models/vitals_model.dart';
import 'package:nurse_os/services/vitals_repository.dart';

class FakeVitalsRepository implements VitalsRepository {
  final Map<String, List<VitalsModel>> _vitalsMap = HashMap();
  final _uuid = const Uuid();

  FakeVitalsRepository() {
    _seedInitialData();
  }

  void _seedInitialData() {
    final now = DateTime.now();

    _vitalsMap['p001'] = [
      _createVitals('p001', now.subtract(const Duration(days: 1)), 98.4, 70, 120, 78, 16, 98, 'Nurse Alice'),
    ];

    _vitalsMap['p002'] = [
      _createVitals('p002', now.subtract(const Duration(days: 2)), 100.2, 90, 130, 85, 20, 95, 'Nurse Ben'),
      _createVitals('p002', now.subtract(const Duration(hours: 6)), 99.3, 84, 126, 82, 18, 97, 'Nurse Ben'),
      _createVitals('p002', now, 98.7, 80, 124, 81, 17, 98, 'Nurse Ben'),
    ];

    _vitalsMap['p003'] = [
      _createVitals('p003', now.subtract(const Duration(days: 1, hours: 6)), 97.9, 65, 110, 70, 14, 99, 'Nurse Chen'),
      _createVitals('p003', now.subtract(const Duration(hours: 10)), 98.1, 67, 112, 72, 15, 99, 'Nurse Chen'),
      _createVitals('p003', now.subtract(const Duration(hours: 5)), 98.3, 69, 114, 74, 15, 98, 'Nurse Chen'),
      _createVitals('p003', now, 98.6, 71, 116, 76, 16, 98, 'Nurse Chen'),
    ];

    _vitalsMap['p004'] = [
      _createVitals('p004', now.subtract(const Duration(hours: 3)), 98.2, 70, 119, 78, 16, 98, 'Nurse Erin'),
    ];

    _vitalsMap['p005'] = [];
  }

  VitalsModel _createVitals(String patientId, DateTime timestamp, double temp, int pulse,
      int systolic, int diastolic, int resp, int oxygen, String nurse) {
    return VitalsModel(
      id: _uuid.v4(),
      patientId: patientId,
      recordedAt: timestamp,
      temperature: temp,
      pulse: pulse,
      systolic: systolic,
      diastolic: diastolic,
      respirationRate: resp,
      oxygenSaturation: oxygen,
      recordedBy: nurse,
    );
  }

  @override
  Future<List<VitalsModel>> getVitalsForPatient(String patientId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final vitals = _vitalsMap[patientId] ?? [];
    vitals.sort((a, b) => b.recordedAt.compareTo(a.recordedAt));
    return vitals;
  }

  @override
  Future<void> addVitals(VitalsModel vitals) async {
    await Future.delayed(const Duration(milliseconds: 150));
    final entry = vitals.copyWith(
      id: _uuid.v4(),
      recordedAt: DateTime.now(),
    );
    _vitalsMap.putIfAbsent(entry.patientId, () => []).add(entry);
  }
}
