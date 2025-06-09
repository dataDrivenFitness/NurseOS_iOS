import 'package:nurse_os/models/vitals_model.dart';

/// NurseOS: Abstract base class for vitals logic (mock or real).
abstract class VitalsRepository {
  Future<List<VitalsModel>> getVitalsForPatient(String patientId);
  Future<void> addVitals(VitalsModel vitals);
}
