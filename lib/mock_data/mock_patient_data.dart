import 'package:nurse_os/models/patient_model.dart';
import 'package:nurse_os/extensions/risk_utils.dart';
import 'package:nurse_os/mock_data/mock_patient_nurse_metadata_service.dart';

final mockPatients = [
  PatientModel(
    id: 'patient_001',
    firstName: 'Ava',
    lastName: 'Rodriguez',
    age: 72,
    location: '4501 Business Center Drive, Fairfield, CA 94534',
    diagnosis: 'CHF Exacerbation',
    tags: ['fall risk', 'daily weights'],
    photoUrl: 'https://i.pravatar.cc/150?img=1',
    pronouns: 'she/her',
    admittedAt: DateTime.now().subtract(const Duration(hours: 2)),
    assignedNurses: ['nurse_001'],
    ownerUid: 'nurse_001',
    createdBy: 'nurse_001',
    manualRiskOverride: null,
  ),
  PatientModel(
    id: 'patient_002',
    firstName: 'Leo',
    lastName: 'Chen',
    age: 56,
    location: '402A',
    diagnosis: 'Pneumonia',
    tags: ['oxygen', 'telemetry'],
    photoUrl: 'https://i.pravatar.cc/150?img=2',
    pronouns: 'he/him',
    admittedAt: DateTime.now().subtract(const Duration(days: 2)),
    assignedNurses: ['nurse_001', 'nurse_002'],
    ownerUid: 'nurse_002',
    createdBy: 'nurse_002',
    manualRiskOverride: RiskLevel.high, // Example of manual risk override  
  ),
  PatientModel(
    id: 'patient_003',
    firstName: 'Maya',
    lastName: 'Singh',
    age: 65,
    location: '403C',
    diagnosis: 'Sepsis',
    tags: ['pain management'],
    photoUrl: null, // No photo available
    pronouns: 'she/her',
    admittedAt: DateTime.now().subtract(const Duration(hours: 20)),
    assignedNurses: ['nurse_001'],
    ownerUid: 'nurse_001',
    createdBy: 'nurse_001',
    manualRiskOverride: null,
  ),
  PatientModel(
    id: 'patient_004',
    firstName: 'Jamal',
    lastName: 'Brown',
    age: 70,
    location: '404D',
    diagnosis: 'Asthma',
    tags: ['no latex'],
    photoUrl: 'https://i.pravatar.cc/150?img=4',
    pronouns: 'he/him',
    admittedAt: DateTime.now().subtract(const Duration(days: 1, hours: 3)),
    assignedNurses: ['nurse_003'],
    ownerUid: 'nurse_003',
    createdBy: 'nurse_003',
    manualRiskOverride: null,
  ),
  PatientModel(
    id: 'patient_005',
    firstName: 'Lina',
    lastName: 'Garcia',
    age: 60,
    location: '405A',
    diagnosis: 'Hyper Sexuality',
    tags: ['foot checks'],
    photoUrl: 'https://i.pravatar.cc/150?img=5',
    pronouns: 'they/them',
    admittedAt: DateTime.now().subtract(const Duration(days: 3)),
    assignedNurses: ['nurse_001'],
    ownerUid: 'nurse_001',
    createdBy: 'nurse_001',
    manualRiskOverride: null,
  ),
];

void markPatientsSeenFor(String nurseId) {
  for (final patient in mockPatients) {
    MockPatientNurseMetadataService.markSeenOnce(patient.id, nurseId);
  }
}
