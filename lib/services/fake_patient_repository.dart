// lib/services/fake_patient_repository.dart

import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:nurse_os/models/patient_model.dart';
import 'mock_patient_data.dart';

abstract class PatientRepository {
  Future<List<PatientModel>> getAllPatients();
  Future<PatientModel?> getPatientById(String id);
}

class FakePatientRepository implements PatientRepository {
  List<PatientModel>? _cache;

  @override
  Future<List<PatientModel>> getAllPatients() async {
    if (_cache != null) return _cache!;

    try {
      final jsonStr = await rootBundle.loadString('assets/mock/patients.json');
      final List<dynamic> jsonList = json.decode(jsonStr);
      _cache = jsonList.map((e) => PatientModel.fromMap(e)).toList();
    } catch (e) {
      _cache = mockPatients; // fallback to static Dart list
    }

    return _cache!;
  }

  @override
  Future<PatientModel> getPatientById(String id) async {
    final list = _cache ?? mockPatients;

    final match = list.firstWhere(
      (p) => p.id == id,
      orElse: () => throw StateError('No patient found with id: $id'),
    );

    return Future.value(match);
  }
}
