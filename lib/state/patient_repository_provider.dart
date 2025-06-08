// lib/state/patient_repository_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nurse_os/services/fake_patient_repository.dart';

final patientRepositoryProvider = Provider<PatientRepository>((ref) {
  return FakePatientRepository();
});
