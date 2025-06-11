import '../models/patient_model.dart';
import '../repositories/patient_repository.dart';
import 'package:flutter/foundation.dart';

class InMemoryPatientRepository extends ChangeNotifier implements PatientRepository {
  final List<PatientModel> _patients;

  InMemoryPatientRepository({List<PatientModel>? patients})
      : _patients = patients ?? [];

  List<PatientModel> get patients => List.unmodifiable(_patients);

  @override
  Future<List<PatientModel>> getAllPatients() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _patients;
  }

  @override
  Future<PatientModel?> getPatientById(String id) async {
    await Future.delayed(const Duration(milliseconds: 150));
    return _patients.firstWhere((p) => p.id == id, orElse: () => null as PatientModel);
  }

  void addPatient(PatientModel patient) {
    _patients.add(patient);
    notifyListeners();
  }

  void updatePatient(PatientModel updated) {
    final index = _patients.indexWhere((p) => p.id == updated.id);
    if (index != -1) {
      _patients[index] = updated;
      notifyListeners();
    }
  }

  void deletePatient(String id) {
    _patients.removeWhere((p) => p.id == id);
    notifyListeners();
  }

  Future<void> refresh() async {
    notifyListeners();
  }
}