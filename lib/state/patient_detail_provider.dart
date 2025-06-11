// lib/state/patient_detail_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/patient_model.dart';
import '../repositories/patient_repository.dart';
import '../services/in_memory_patient_repository.dart';

final patientRepositoryProvider = Provider<PatientRepository>((ref) {
  return InMemoryPatientRepository(); // Will swap for Firebase later
});

final patientDetailProvider = FutureProvider.family<PatientModel, String>((ref, patientId) async {
  final repo = ref.read(patientRepositoryProvider);
  final patient = await repo.getPatientById(patientId);

  if (patient == null) {
    throw Exception('Patient not found with id: $patientId');
  }

  return patient;
});

