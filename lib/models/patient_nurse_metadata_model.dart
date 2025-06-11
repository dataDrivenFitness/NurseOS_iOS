/// Tracks when a nurse first saw a patient, used for "New" pill logic
class PatientNurseMetadata {
  final String patientId;
  final String nurseId;
  final DateTime firstSeenAt;

  PatientNurseMetadata({
    required this.patientId,
    required this.nurseId,
    required this.firstSeenAt,
  });

  bool get isNew => DateTime.now().difference(firstSeenAt).inHours < 24;
}
