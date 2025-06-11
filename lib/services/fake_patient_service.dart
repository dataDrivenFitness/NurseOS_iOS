// Enhanced FakePatientService with mock error simulation
import 'package:nurse_os/models/patient_model.dart';
import 'package:nurse_os/models/error_types.dart';

class FakePatientService {
  /// Toggle this to simulate network failure scenarios
  bool simulateNetworkError = false;

  final List<PatientModel> _mockPatients = [
    PatientModel(
      id: 'p1',
      firstName: 'John',
      lastName: 'Doe',
      age: 68,
      roomNumber: '201B',
      diagnosis: 'CHF',
      admittedAt: DateTime.now().subtract(const Duration(days: 2)),
      pronouns: 'he/him',
      photoUrl: '',
      createdBy: 'demoUser123',
    ),
    PatientModel(
      id: 'p2',
      firstName: 'Maria',
      lastName: 'Santos',
      age: 54,
      roomNumber: '305A',
      diagnosis: 'COPD',
      admittedAt: DateTime.now().subtract(const Duration(days: 5)),
      pronouns: 'she/her',
      photoUrl: '',
      createdBy: 'demoUser123',
    ),
  ];

  Future<List<PatientModel>> fetchPatients() async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (simulateNetworkError) throw NetworkFailure();
    return _mockPatients;
  }
}
