import '../models/patient_model.dart';

abstract class PatientRepository {
  Future<List<PatientModel>> getAllPatients();
}