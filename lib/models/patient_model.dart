import 'package:nurse_os/models/risk_level.dart';

/// Core patient record used across Nurse OS.
/// Add any new field here first, then migrate into repos/mock data.
class PatientModel {
  final String id;
  final String firstName;
  final String lastName;
  final int age;
  final String location;
  final String diagnosis;
  final List<String>? tags;
  final RiskLevel? riskLevel;              // nullable → defaulted in getter
  final String? photoUrl;
  final String? pronouns;
  final DateTime? admittedAt;
  final List<String>? assignedNurses;
  final String? ownerUid;
  final RiskLevel? manualRiskOverride;
  final String? createdBy;

  PatientModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.location,
    required this.diagnosis,
    this.tags,
    this.riskLevel,
    this.photoUrl,
    this.pronouns,
    this.admittedAt,
    this.assignedNurses,
    this.ownerUid,
    this.manualRiskOverride,
    this.createdBy,
  });

  /* ── UI helpers ── */
  String get displayName => '$firstName $lastName';
  bool    get isNew       => false;                 // TODO real logic
  RiskLevel get resolvedRiskLevel =>
      manualRiskOverride ?? riskLevel ?? RiskLevel.low;

  /* ── Serialisation helpers ── */
  Map<String, dynamic> toMap() => {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'age': age,
        'location': location,
        'diagnosis': diagnosis,
        'tags': tags,
        'riskLevel': riskLevel?.name,
        'photoUrl': photoUrl,
        'pronouns': pronouns,
        'admittedAt': admittedAt?.toIso8601String(),
        'assignedNurses': assignedNurses,
        'ownerUid': ownerUid,
        'manualRiskOverride': manualRiskOverride?.name,
        'createdBy': createdBy,
      };

  factory PatientModel.fromMap(Map<String, dynamic> map) => PatientModel(
        id: map['id'],
        firstName: map['firstName'],
        lastName: map['lastName'],
        age: map['age'],
        location: map['location'],
        diagnosis: map['diagnosis'],
        tags: map['tags'] != null ? List<String>.from(map['tags']) : null,
        riskLevel: map['riskLevel'] != null
            ? RiskLevel.values.byName(map['riskLevel'])
            : null,
        photoUrl: map['photoUrl'],
        pronouns: map['pronouns'],
        admittedAt: map['admittedAt'] != null
            ? DateTime.parse(map['admittedAt'])
            : null,
        assignedNurses: map['assignedNurses'] != null
            ? List<String>.from(map['assignedNurses'])
            : null,
        ownerUid: map['ownerUid'],
        manualRiskOverride: map['manualRiskOverride'] != null
            ? RiskLevel.values.byName(map['manualRiskOverride'])
            : null,
        createdBy: map['createdBy'],
      );
}
