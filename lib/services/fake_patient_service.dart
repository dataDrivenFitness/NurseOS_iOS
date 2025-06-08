import '../models/patient_model.dart';

class FakePatientService {
  Future<List<PatientModel>> fetchPatients() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return [
      PatientModel(
        id: 'p1',
        name: 'John Doe',
        age: 68,
        roomNumber: '201B',
        diagnosis: 'CHF',
        admittedAt: DateTime.now().subtract(const Duration(days: 2)),
        createdBy: 'demoUser123',
      ),
      PatientModel(
        id: 'p2',
        name: 'Maria Santos',
        age: 54,
        roomNumber: '305A',
        diagnosis: 'COPD',
        admittedAt: DateTime.now().subtract(const Duration(days: 5)),
        createdBy: 'demoUser123',
      ),
    ];
  }
}
