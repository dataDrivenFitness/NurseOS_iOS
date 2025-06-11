import 'dart:collection';
import 'package:uuid/uuid.dart';
import 'package:nurse_os/models/vitals_model.dart';
import 'package:nurse_os/services/vitals_repository.dart';

class InMemoryVitalsRepository implements VitalsRepository {
  final Map<String, List<VitalsModel>> _vitalsMap = HashMap();
  final _uuid = const Uuid();

  InMemoryVitalsRepository() {
    _seedInitialData();
  }

  void _seedInitialData() {
    final now = DateTime.now();

    // patient_001: 34 days of data
    _vitalsMap['patient_001'] = List.generate(34, (i) {
      final date = now.subtract(Duration(days: i));
      return _createVitals('patient_001', date, 98.6 + (i % 3) * 0.2, 70 + (i % 5), 120 + (i % 4), 80 + (i % 4), 16, 98, 'Nurse Alice');
    });

    // patient_002: 4 entries
    _vitalsMap['patient_002'] = List.generate(4, (i) {
      final date = now.subtract(Duration(days: i));
      return _createVitals('patient_002', date, 98.7, 75, 118, 78, 16, 97, 'Nurse Ben');
    });

    // patient_003: no data
    _vitalsMap['patient_003'] = [];

    // patient_004: 8 entries
    _vitalsMap['patient_004'] = List.generate(8, (i) {
      final date = now.subtract(Duration(days: i));
      return _createVitals('patient_004', date, 98.2 + (i % 2) * 0.3, 68 + (i % 4), 115 + (i % 3), 77 + (i % 3), 15, 97, 'Nurse Dana');
    });

    // patient_005: 1 entry
    _vitalsMap['patient_005'] = [
      _createVitals('patient_005', now.subtract(const Duration(days: 1)), 98.9, 72, 122, 79, 16, 99, 'Nurse Evan'),
    ];
  }

  VitalsModel _createVitals(
    String patientId,
    DateTime recordedAt,
    double temperature,
    int pulse,
    int systolic,
    int diastolic,
    int respiratoryRate,
    int oxygenSaturation,
    String recordedBy,
  ) {
    return VitalsModel(
      uid: _uuid.v4(),
      patientId: patientId,
      recordedAt: recordedAt,
      temperature: temperature,
      pulse: pulse,
      systolic: systolic,
      diastolic: diastolic,
      respiratoryRate: respiratoryRate,
      oxygenSaturation: oxygenSaturation,
      recordedBy: recordedBy,
    );
  }

  @override
  Future<List<VitalsModel>> getVitalsForPatient(String patientId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _vitalsMap[patientId] ?? [];
  }

  @override
  Future<void> addVitals(VitalsModel vitals) async {
    _vitalsMap.putIfAbsent(vitals.patientId, () => []);
    _vitalsMap[vitals.patientId]!.add(vitals);
  }
}
