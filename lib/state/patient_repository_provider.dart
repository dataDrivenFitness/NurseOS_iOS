// lib/state/patient_repository_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/patient_repository.dart';
import '../services/fake_patient_repository.dart';

final patientRepositoryProvider = Provider<PatientRepository>((ref) {
  return FakePatientRepository(); // Replace with FirebasePatientRepository later
});
