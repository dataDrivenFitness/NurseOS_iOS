import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/patient_model.dart';
import '../services/fake_patient_service.dart';

final patientListProvider = FutureProvider<List<PatientModel>>((ref) async {
  final service = FakePatientService();
  return service.fetchPatients();
});
