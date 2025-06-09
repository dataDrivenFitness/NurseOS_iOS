class VitalsModel {
  final String id;
  final String patientId;
  final DateTime recordedAt;
  final String recordedBy;
  final int pulse;
  final int systolic;
  final int diastolic;
  final double temperature;
  final int respirationRate;
  final int oxygenSaturation;

  VitalsModel({
    required this.id,
    required this.patientId,
    required this.recordedAt,
    required this.recordedBy,
    required this.pulse,
    required this.systolic,
    required this.diastolic,
    required this.temperature,
    required this.respirationRate,
    required this.oxygenSaturation,
  });

  VitalsModel copyWith({
    String? id,
    String? patientId,
    DateTime? recordedAt,
    String? recordedBy,
    int? pulse,
    int? systolic,
    int? diastolic,
    double? temperature,
    int? respirationRate,
    int? oxygenSaturation,
  }) {
    return VitalsModel(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      recordedAt: recordedAt ?? this.recordedAt,
      recordedBy: recordedBy ?? this.recordedBy,
      pulse: pulse ?? this.pulse,
      systolic: systolic ?? this.systolic,
      diastolic: diastolic ?? this.diastolic,
      temperature: temperature ?? this.temperature,
      respirationRate: respirationRate ?? this.respirationRate,
      oxygenSaturation: oxygenSaturation ?? this.oxygenSaturation,
    );
  }
}
