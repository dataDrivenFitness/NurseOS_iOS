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
    ];
  }

  VitalsModel _createVitals(
    String patientId,
    DateTime timestamp,
    double temp,
    int hr,
    int sbp,
    int dbp,
    int rr,
    int spo2,
    String takenBy,
  ) {
    return VitalsModel(
      id: _uuid.v4(),
      patientId: patientId,
      timestamp: timestamp,
      temperature: temp,
      heartRate: hr,
      systolic: sbp,
      diastolic: dbp,
      respiratoryRate: rr,
      oxygenSaturation: spo2,
      takenBy: takenBy,
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