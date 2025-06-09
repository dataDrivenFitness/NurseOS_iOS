import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nurse_os/models/patient_model.dart';
import 'package:nurse_os/services/patient_repository.dart';
import 'package:nurse_os/services/fake_patient_repository.dart';
import 'package:nurse_os/services/mock_patient_data.dart';

/// Repository injection (can be overridden in main.dart)
final patientRepositoryProvider = Provider<PatientRepository>((ref) {
  return FakePatientRepository(patients: mockPatients);
});

/// Async provider to fetch patient list
final patientsProvider = FutureProvider<List<PatientModel>>((ref) async {
  final repository = ref.watch(patientRepositoryProvider);
  return repository.getAllPatients();
});
