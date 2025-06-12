
import 'package:nurse_os/extensions/risk_utils.dart' show RiskLevel;

class PatientModel {
  final String id;
  final String firstName;
  final String lastName;
  final int age;
  final String location;
  final String diagnosis;
  final List<String>? tags;
  final RiskLevel? riskLevel;
  final String? photoUrl;
  final String? pronouns;
  final DateTime? admittedAt;
  final List<String>? assignedNurses; // 🆕 NEW FIELD
  final String? ownerUid;              // 🆕 OPTIONAL (Phase 4)
  final RiskLevel? manualRiskOverride; // <— ADD THIS
  final String? createdBy; // <— ADD THIS if needed separately

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
    this.assignedNurses,  // include in constructor
    this.ownerUid,
    this.manualRiskOverride, // <— ADD TO CONSTRUCTOR
    this.createdBy, // <— Optional
  });

  Map<String, dynamic> toMap() {
    return {
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
      'assignedNurses': assignedNurses, // persist
      'ownerUid': ownerUid,
      'manualRiskOverride': manualRiskOverride?.name,
      'createdBy': createdBy,
    };
  }

  factory PatientModel.fromMap(Map<String, dynamic> map) {
    return PatientModel(
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
}
