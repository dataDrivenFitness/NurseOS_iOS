// lib/services/fake_vitals_repository.dart

import 'dart:collection';
import 'package:nurse_os/models/vitals_model.dart';
import 'package:uuid/uuid.dart';
import 'package:nurse_os/services/vitals_repository.dart';


class FakeVitalsRepository implements VitalsRepository {
  final Map<String, List<VitalsModel>> _vitalsMap = HashMap();
  final _uuid = const Uuid();

  @override
  Future<List<VitalsModel>> getVitalsForPatient(String patientId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final vitals = _vitalsMap[patientId] ?? [];
    vitals.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return vitals;
  }

  @override
  Future<void> saveVitals(VitalsModel vitals) async {
    await Future.delayed(const Duration(milliseconds: 150));
    final entry = vitals.copyWith(id: _uuid.v4(), timestamp: DateTime.now());
    _vitalsMap.putIfAbsent(entry.patientId, () => []).add(entry);
  }
}

extension on VitalsModel {
  VitalsModel copyWith({
    String? id,
    DateTime? timestamp,
  }) {
    return VitalsModel(
      id: id ?? this.id,
      patientId: patientId,
      timestamp: timestamp ?? this.timestamp,
      temperature: temperature,
      pulse: pulse,
      systolicBP: systolicBP,
      diastolicBP: diastolicBP,
      respirationRate: respirationRate,
      oxygenSaturation: oxygenSaturation,
      recordedBy: recordedBy,
      notes: notes,
    );
  }
}
