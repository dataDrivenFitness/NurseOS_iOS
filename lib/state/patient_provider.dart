// lib/state/patient_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/patient_model.dart';
import '../services/fake_patient_repository.dart';

final patientsProvider = FutureProvider<List<PatientModel>>((ref) async {
  final repository = FakePatientRepository();
  return repository.getAllPatients();
});
