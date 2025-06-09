import 'package:nurse_os/models/patient_model.dart';
import 'package:nurse_os/services/patient_repository.dart';

class FakePatientRepository implements PatientRepository {
  final List<PatientModel> _patients;

  FakePatientRepository({required List<PatientModel> patients})
      : _patients = patients;

  @override
  Future<List<PatientModel>> getAllPatients() async {
    // Simulate delay if desired
    await Future.delayed(const Duration(milliseconds: 200));
    return _patients;
  }
}
