import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nurse_os/models/vitals_model.dart';
import 'package:nurse_os/state/vitals_repository_provider.dart';
import 'package:nurse_os/services/vitals_repository.dart';

// Async read provider (vitals list)
final vitalsProvider = FutureProvider.family<List<VitalsModel>, String>((ref, patientId) async {
  final repository = ref.watch(vitalsRepositoryProvider);
  return repository.getVitalsForPatient(patientId);
});

// StateNotifier for mutations (add vitals)
final vitalsControllerProvider = StateNotifierProvider.family<VitalsController, List<VitalsModel>, String>(
  (ref, patientId) {
    final repository = ref.watch(vitalsRepositoryProvider);
    return VitalsController(repository, patientId);
  },
);

class VitalsController extends StateNotifier<List<VitalsModel>> {
  final VitalsRepository repository;
  final String patientId;

  VitalsController(this.repository, this.patientId) : super([]);

  Future<void> addVitals(VitalsModel vitals) async {
    await repository.addVitals(vitals);
    state = [...state, vitals];
  }

  Future<void> loadInitial() async {
    state = await repository.getVitalsForPatient(patientId);
  }
}
