import '../models/patient_model.dart';
import 'package:flutter/foundation.dart';

class FakePatientRepository extends ChangeNotifier {
  final List<PatientModel> _patients;

  FakePatientRepository({List<PatientModel>? patients})
      : _patients = patients ?? [];

  List<PatientModel> get patients => List.unmodifiable(_patients);

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
    // In a real implementation, this might fetch from a backend
    await Future.delayed(const Duration(milliseconds: 300));
    notifyListeners();
  }
}
