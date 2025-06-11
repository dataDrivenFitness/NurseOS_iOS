import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nurse_os/constants/global_constants.dart';
import 'package:nurse_os/services/in_memory_patient_repository.dart';
import 'package:nurse_os/repositories/patient_repository.dart';
// import 'package:nurse_os/services/firebase_patient_repository.dart'; // 🔒 For Phase 5

final patientRepositoryProvider = Provider<PatientRepository>((ref) {
  if (kUseFirebase) {
    // return FirebasePatientRepository(); // 🔓 Enable in Phase 5
    throw UnimplementedError('FirebasePatientRepository not yet implemented.');
  } else {
    return InMemoryPatientRepository();
  }
});