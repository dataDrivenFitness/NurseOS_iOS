import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/care_plan_model.dart';
import '../services/fake_care_plan_service.dart';

class CarePlanNotifier extends StateNotifier<AsyncValue<List<CarePlanModel>>> {
  final String patientId;
  final FakeCarePlanService _service = FakeCarePlanService();
  final List<CarePlanModel> _mockData = [];

  CarePlanNotifier(this.patientId) : super(const AsyncValue.loading()) {
    _loadPlans();
  }

  Future<void> _loadPlans() async {
    state = const AsyncValue.loading();
    try {
      final plans = await _service.fetchCarePlansByPatient(patientId);
      _mockData
        ..clear()
        ..addAll(plans);
      state = AsyncValue.data(plans);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addMockPlan(CarePlanModel plan) async {
    _mockData.add(plan);
    state = AsyncValue.data(List.from(_mockData));
  }
}

final carePlansProvider =
    StateNotifierProvider.family<CarePlanNotifier, AsyncValue<List<CarePlanModel>>, String>(
  (ref, patientId) => CarePlanNotifier(patientId),
);
