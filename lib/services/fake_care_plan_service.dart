import 'package:nurse_os/models/care_plan_model.dart';

class FakeCarePlanService {
  Future<List<CarePlanModel>> fetchCarePlansByPatient(String patientId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      CarePlanModel(
        id: 'cp1',
        patientId: patientId,
        title: 'Oxygen Support',
        description: 'Ensure oxygen sat > 95%, monitor respiratory status',
        startDate: DateTime.now().subtract(const Duration(days: 3)),
        endDate: null,
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
        createdBy: 'nurse_1',
      ),
      CarePlanModel(
        id: 'cp2',
        patientId: patientId,
        title: 'Fall Precautions',
        description: 'Non-skid socks, call bell within reach, hourly rounding',
        startDate: DateTime.now().subtract(const Duration(days: 5)),
        endDate: DateTime.now().subtract(const Duration(days: 1)),
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
        createdBy: 'nurse_1',
      ),
    ];
  }
}
