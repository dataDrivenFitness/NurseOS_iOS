import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/patient_model.dart';
import '../repositories/patient_repository.dart';
import 'mock_patient_data.dart';

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
      _cache = mockPatients;
    }

    return _cache!;
  }

  @override
  Future<PatientModel> getPatientById(String id) async {
    final list = _cache ?? mockPatients;
    try {
      final match = list.firstWhere((p) => p.id == id);
      return match;
    } catch (_) {
      throw StateError('No patient found with id: $id');
    }
  }
}
