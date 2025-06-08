class VitalsModel {
  final String id;
  final String patientId;
  final DateTime timestamp;
  final double temperature;       // °F
  final int pulse;                // bpm
  final int systolicBP;           // mmHg
  final int diastolicBP;          // mmHg
  final int respirationRate;      // breaths/min
  final int oxygenSaturation;     // %
  final String? recordedBy;       // Nurse ID or name
  final String? notes;            // Optional notes

  VitalsModel({
    required this.id,
    required this.patientId,
    required this.timestamp,
    required this.temperature,
    required this.pulse,
    required this.systolicBP,
    required this.diastolicBP,
    required this.respirationRate,
    required this.oxygenSaturation,
    this.recordedBy,
    this.notes,
  });

  factory VitalsModel.fromMap(Map<String, dynamic> map) => VitalsModel(
        id: map['id'],
        patientId: map['patientId'],
        timestamp: DateTime.parse(map['timestamp']),
        temperature: map['temperature'],
        pulse: map['pulse'],
        systolicBP: map['systolicBP'],
        diastolicBP: map['diastolicBP'],
        respirationRate: map['respirationRate'],
        oxygenSaturation: map['oxygenSaturation'],
        recordedBy: map['recordedBy'],
        notes: map['notes'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'patientId': patientId,
        'timestamp': timestamp.toIso8601String(),
        'temperature': temperature,
        'pulse': pulse,
        'systolicBP': systolicBP,
        'diastolicBP': diastolicBP,
        'respirationRate': respirationRate,
        'oxygenSaturation': oxygenSaturation,
        'recordedBy': recordedBy,
        'notes': notes,
      };
}
