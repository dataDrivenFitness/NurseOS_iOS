import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/vitals_model.dart';

class VitalsNotifier extends StateNotifier<List<VitalsModel>> {
  final String patientId;

  VitalsNotifier(this.patientId) : super([]);

  void addVitals(VitalsModel vitals) {
    state = [...state, vitals];
  }

  VitalsModel? get lastEntry {
    if (state.isEmpty) return null;
    return state.last;
  }

  List<VitalsModel> get history => state.reversed.toList();
}

final vitalsProvider = StateNotifierProvider.family<VitalsNotifier, List<VitalsModel>, String>(
  (ref, patientId) => VitalsNotifier(patientId),
);
