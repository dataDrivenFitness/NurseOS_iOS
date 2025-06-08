import 'package:nurse_os/models/care_plan_model.dart';

abstract class CarePlanRepository {
  Future<List<CarePlanModel>> getCarePlansForPatient(String patientId);
  Future<void> addCarePlan(CarePlanModel plan);
}
