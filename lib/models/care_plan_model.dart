/// Represents a structured nursing care plan for a patient in NurseOS.
class CarePlanModel {
  final String id; // NurseOS: unique document ID (UUID or Firestore docId)
  final String patientId; // NurseOS: links to PatientModel.id
  final String title; // NurseOS: short plan label (e.g., "Fall Risk Protocol")
  final String description; // NurseOS: detailed steps or goals
  final DateTime startDate; // NurseOS: required activation date
  final DateTime? endDate; // NurseOS: optional, for plan closure
  final DateTime createdAt; // NurseOS: timestamp for audit/log
  final String createdBy; // NurseOS: nurse name or UID (mock/fake for now)

  CarePlanModel({
    required this.id,
    required this.patientId,
    required this.title,
    required this.description,
    required this.startDate,
    this.endDate,
    required this.createdAt,
    required this.createdBy,
  });

  /// Factory for parsing from Firestore-style map.
  /// NurseOS: `docId` passed separately to support Firestore document IDs.
  factory CarePlanModel.fromMap(Map<String, dynamic> data, String docId) {
    return CarePlanModel(
      id: docId,
      patientId: data['patientId'],
      title: data['title'],
      description: data['description'],
      startDate: DateTime.parse(data['startDate']),
      endDate: data['endDate'] != null ? DateTime.parse(data['endDate']) : null,
      createdAt: DateTime.parse(data['createdAt']),
      createdBy: data['createdBy'],
    );
  }

  /// Converts model to JSON-serializable map.
  /// NurseOS: used for mock repo and Firebase sync (Phase 3).
  Map<String, dynamic> toMap() {
    return {
      'patientId': patientId,
      'title': title,
      'description': description,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'createdBy': createdBy,
    };
  }
}
