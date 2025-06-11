import '../models/patient_model.dart';
import '../models/vitals_model.dart';
import '../models/sentiment_note_model.dart';
import '../models/shift_note_model.dart';
import '../mock_data/mock_constants.dart';

class MockScenarioBuilder {
  static PatientModel stablePatient({required String uid}) {
    return PatientModel(
      uid: uid,
      displayName: "Liam Smith",
      assignedNurses: [mockNurseAnaId],
      riskFlags: ["low"],
      vitals: [
        VitalsEntry(
          patientId: uid,
          timestamp: DateTime.now().subtract(Duration(hours: 2)),
          bp: "120/80",
          pulse: 72,
        )
      ],
      sentimentNotes: [
        SentimentNote(
          patientId: uid,
          content: "Calm and cooperative",
          sentimentTag: "neutral",
          wasAiGenerated: false,
          createdAt: DateTime.now().subtract(Duration(hours: 1)),
          createdBy: mockNurseAnaId,
        )
      ],
    );
  }

  static ShiftNote gptGeneratedShiftNote({required String patientId}) {
    return ShiftNote(
      patientId: patientId,
      content: "Patient remained stable during morning shift. Vitals within normal limits.",
      generated: true,
      generatedBy: "GPT",
      createdBy: mockNurseAnaId,
      createdAt: DateTime.now(),
    );
  }

  static PatientModel chfExacerbation() {
    return PatientModel(
      id: 'patient_001',
      firstName: 'Ava',
      lastName: 'Rodriguez',
      age: 72,
      roomNumber: '401B',
      diagnosis: 'CHF Exacerbation',
      tags: ['fall risk', 'daily weights'],
      photoUrl: 'https://i.pravatar.cc/150?img=1',
      pronouns: 'she/her',
      admittedAt: DateTime.now().subtract(const Duration(hours: 2)),
      assignedNurses: ['nurse_001'],
      ownerUid: 'nurse_001',
      createdBy: 'nurse_001',
      manualRiskOverride: null,
    );
  }

  static PatientModel pneumoniaCase() {
    return PatientModel(
      id: 'patient_002',
      firstName: 'Leo',
      lastName: 'Chen',
      age: 56,
      roomNumber: '402A',
      diagnosis: 'Pneumonia',
      tags: ['oxygen', 'telemetry'],
      photoUrl: 'https://i.pravatar.cc/150?img=2',
      pronouns: 'he/him',
      admittedAt: DateTime.now().subtract(const Duration(hours: 2)),
      assignedNurses: ['nurse_001', 'nurse_002'],
      ownerUid: 'nurse_002',
      createdBy: 'nurse_002',
      manualRiskOverride: null,
    );
  }
}
