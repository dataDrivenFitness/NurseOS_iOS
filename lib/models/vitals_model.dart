class VitalsModel {
  final String uid;
  final String patientId;
  final DateTime recordedAt;
  final String recordedBy;
  final int pulse;
  final int systolic;
  final int diastolic;
  final double temperature;
  final int respiratoryRate;
  final int oxygenSaturation;

  VitalsModel({
    required this.uid,
    required this.patientId,
    required this.recordedAt,
    required this.recordedBy,
    required this.pulse,
    required this.systolic,
    required this.diastolic,
    required this.temperature,
    required this.respiratoryRate,
    required this.oxygenSaturation,
  });

  VitalsModel copyWith({
    String? uid,
    String? patientId,
    DateTime? recordedAt,
    String? recordedBy,
    int? pulse,
    int? systolic,
    int? diastolic,
    double? temperature,
    int? respiratoryRate,
    int? oxygenSaturation,
  }) {
    return VitalsModel(
      uid: uid ?? this.uid,
      patientId: patientId ?? this.patientId,
      recordedAt: recordedAt ?? this.recordedAt,
      recordedBy: recordedBy ?? this.recordedBy,
      pulse: pulse ?? this.pulse,
      systolic: systolic ?? this.systolic,
      diastolic: diastolic ?? this.diastolic,
      temperature: temperature ?? this.temperature,
      respiratoryRate: respiratoryRate ?? this.respiratoryRate,
      oxygenSaturation: oxygenSaturation ?? this.oxygenSaturation,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'patientId': patientId,
      'recordedAt': recordedAt.toIso8601String(),
      'recordedBy': recordedBy,
      'pulse': pulse,
      'systolic': systolic,
      'diastolic': diastolic,
      'temperature': temperature,
      'respiratoryRate': respiratoryRate,
      'oxygenSaturation': oxygenSaturation,
    };
  }

  factory VitalsModel.fromJson(Map<String, dynamic> json) {
    return VitalsModel(
      uid: json['uid'],
      patientId: json['patientId'],
      recordedAt: DateTime.parse(json['recordedAt']),
      recordedBy: json['recordedBy'],
      pulse: json['pulse'],
      systolic: json['systolic'],
      diastolic: json['diastolic'],
      temperature: (json['temperature'] as num).toDouble(),
      respiratoryRate: json['respiratoryRate'],
      oxygenSaturation: json['oxygenSaturation'],
    );
  }
}
