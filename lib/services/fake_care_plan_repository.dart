import 'dart:collection';
import 'package:nurse_os/models/care_plan_model.dart';
import 'package:nurse_os/services/care_plan_repository.dart';

class FakeCarePlanRepository implements CarePlanRepository {
  final _storage = HashMap<String, List<CarePlanModel>>();

  @override
  Future<List<CarePlanModel>> getCarePlansForPatient(String patientId) async {
    final list = _storage[patientId] ?? [];
    list.sort((a, b) => b.startDate.compareTo(a.startDate));
    return Future.delayed(const Duration(milliseconds: 300), () => list);
  }

  @override
  Future<void> addCarePlan(CarePlanModel plan) async {
    final list = _storage[plan.patientId] ?? [];
    list.add(plan);
    _storage[plan.patientId] = list;
    await Future.delayed(const Duration(milliseconds: 200));
  }
}
