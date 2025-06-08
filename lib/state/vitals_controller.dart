import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nurse_os/models/vitals_model.dart';
import 'package:nurse_os/state/vitals_repository_provider.dart';

class VitalsController extends FamilyAsyncNotifier<List<VitalsModel>, String> {
  late final String patientId;

  @override
  Future<List<VitalsModel>> build(String id) async {
    patientId = id;
    final repo = ref.read(vitalsRepositoryProvider);
    return repo.getVitalsForPatient(patientId);
  }

  Future<void> addVitals(VitalsModel vitals) async {
    final repo = ref.read(vitalsRepositoryProvider);
    await repo.saveVitals(vitals);
    state = await AsyncValue.guard(() => repo.getVitalsForPatient(patientId));
  }
}

final vitalsControllerProvider =
    AsyncNotifierProvider.family<VitalsController, List<VitalsModel>, String>(
  VitalsController.new,
);
