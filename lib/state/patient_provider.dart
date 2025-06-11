import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/patient_model.dart';
import '../services/fake_patient_repository.dart';
import '../mock_data/mock_patient_data.dart';

final patientRepositoryProvider = ChangeNotifierProvider<FakePatientRepository>((ref) {
  return FakePatientRepository(patients: mockPatients);
});

final patientsProvider = Provider<List<PatientModel>>((ref) {
  return ref.watch(patientRepositoryProvider).patients;
});
