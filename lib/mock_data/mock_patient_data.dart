import 'package:nurse_os/models/patient_model.dart';
import 'package:nurse_os/models/risk_level.dart';
import 'package:nurse_os/mock_data/mock_patient_nurse_metadata_service.dart';

/// In-memory demo roster shown on the Patient List.
final mockPatients = [
  PatientModel(
    id: 'patient_001',
    firstName: 'Ava',
    lastName: 'Rodriguez',
    age: 72,
    location: 'Home Health',
    diagnosis: 'CHF exacerbation',
    tags: ['fall-risk', 'daily weights'],
    riskLevel: RiskLevel.high,
    photoUrl: 'https://i.pravatar.cc/150?img=1',
    pronouns: 'she/her',
    admittedAt: DateTime.now().subtract(const Duration(hours: 2)),
    assignedNurses: ['nurse_001'],
    ownerUid: 'nurse_001',
    createdBy: 'nurse_001',
  ),

  PatientModel(
    id: 'patient_002',
    firstName: 'Leo',
    lastName: 'Chen',
    age: 56,
    location: 'Room 402A · Med-Surg',
    diagnosis: 'Pneumonia',
    tags: ['oxygen', 'telemetry'],
    riskLevel: RiskLevel.medium,
    photoUrl: 'https://i.pravatar.cc/150?img=2',
    pronouns: 'he/him',
    admittedAt: DateTime.now().subtract(const Duration(days: 2)),
    assignedNurses: ['nurse_001', 'nurse_002'],
    ownerUid: 'nurse_002',
    createdBy: 'nurse_002',
    //manualRiskOverride: RiskLevel.high, // manual override example
  ),

  PatientModel(
    id: 'patient_003',
    firstName: 'Maya',
    lastName: 'Singh',
    age: 65,
    location: 'Room 403C · ICU',
    diagnosis: 'Sepsis',
    tags: ['pain-management'],
    riskLevel: RiskLevel.high,
    photoUrl: null,
    pronouns: 'she/her',
    admittedAt: DateTime.now().subtract(const Duration(hours: 20)),
    assignedNurses: ['nurse_001'],
    ownerUid: 'nurse_001',
    createdBy: 'nurse_001',
  ),

  PatientModel(
    id: 'patient_004',
    firstName: 'Jamal',
    lastName: 'Brown',
    age: 70,
    location: 'Room 404D',
    diagnosis: 'Asthma',
    tags: ['no-latex'],
    riskLevel: RiskLevel.low,
    photoUrl: 'https://i.pravatar.cc/150?img=4',
    pronouns: 'he/him',
    admittedAt: DateTime.now().subtract(const Duration(days: 1, hours: 3)),
    assignedNurses: ['nurse_003'],
    ownerUid: 'nurse_003',
    createdBy: 'nurse_003',
  ),

  PatientModel(
    id: 'patient_005',
    firstName: 'Lina',
    lastName: 'Garcia',
    age: 60,
    location: 'Room 405A',
    diagnosis: 'Diabetes—hyperglycemia',
    tags: ['foot-checks'],
    riskLevel: RiskLevel.medium,
    photoUrl: 'https://i.pravatar.cc/150?img=5',
    pronouns: 'they/them',
    admittedAt: DateTime.now().subtract(const Duration(days: 3)),
    assignedNurses: ['nurse_001'],
    ownerUid: 'nurse_001',
    createdBy: 'nurse_001',
  ),
];

/// Marks every patient “seen once” by the given nurse—used by demo flows.
void markPatientsSeenFor(String nurseId) {
  for (final patient in mockPatients) {
    MockPatientNurseMetadataService.markSeenOnce(patient.id, nurseId);
  }
}
