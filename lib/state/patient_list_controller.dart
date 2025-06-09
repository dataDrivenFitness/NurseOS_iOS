// lib/state/patient_list_controller.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/patient_model.dart';
import '../repositories/patient_repository.dart';
import 'patient_repository_provider.dart';
import 'package:nurse_os/services/mock_patient_data.dart';


final patientListControllerProvider = FutureProvider<List<PatientModel>>((ref) async {
  await Future.delayed(const Duration(milliseconds: 300));
  return mockPatients; // No filtering!
});

