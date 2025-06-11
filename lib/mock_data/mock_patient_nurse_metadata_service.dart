
import 'package:nurse_os/models/patient_nurse_metadata_model.dart';

class MockPatientNurseMetadataService {
  static final Map<String, PatientNurseMetadata> _store = {};

  static String _key(String patientId, String nurseId) => '$nurseId|$patientId';

  static Future<PatientNurseMetadata> getOrCreate({
    required String patientId,
    required String nurseId,
  }) async {
    final key = _key(patientId, nurseId);
    if (_store.containsKey(key)) return _store[key]!;

    final newEntry = PatientNurseMetadata(
      patientId: patientId,
      nurseId: nurseId,
      firstSeenAt: DateTime.now(),
    );
    _store[key] = newEntry;
    return newEntry;
  }

  static void markSeen(String patientId, String nurseId) {
    final key = _key(patientId, nurseId);
    _store[key] = PatientNurseMetadata(
      patientId: patientId,
      nurseId: nurseId,
      firstSeenAt: DateTime.now(),
    );
  }

  static void markSeenOnce(String patientId, String nurseId) {
    final key = _key(patientId, nurseId);
    _store.putIfAbsent(key, () => PatientNurseMetadata(
      patientId: patientId,
      nurseId: nurseId,
      firstSeenAt: DateTime.now(),
    ));
  }

  static void reset() => _store.clear();
}
