// lib/state/patient_list_controller.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nurse_os/models/patient_model.dart';
import 'package:nurse_os/services/fake_patient_repository.dart';
import 'patient_repository_provider.dart';

class PatientListController extends AsyncNotifier<List<PatientModel>> {
  late final PatientRepository _repository;

  @override
  Future<List<PatientModel>> build() async {
    _repository = ref.read(patientRepositoryProvider);
    return _repository.getAllPatients();
  }
}

final patientListControllerProvider =
    AsyncNotifierProvider<PatientListController, List<PatientModel>>(
        () => PatientListController());
