class VitalsModel {
  final String id;
  final String patientId;
  final DateTime timestamp;
  final double temperature;
  final int heartRate;
  final int systolic;
  final int diastolic;
  final int respiratoryRate;
  final int oxygenSaturation;
  final String takenBy;

  VitalsModel({
    required this.id,
    required this.patientId,
    required this.timestamp,
    required this.temperature,
    required this.heartRate,
    required this.systolic,
    required this.diastolic,
    required this.respiratoryRate,
    required this.oxygenSaturation,
    required this.takenBy,
  });

  factory VitalsModel.fromJson(Map<String, dynamic> json) {
    return VitalsModel(
      id: json['id'],
      patientId: json['patientId'],
      timestamp: DateTime.parse(json['timestamp']),
      temperature: json['temperature'],
      heartRate: json['heartRate'],
      systolic: json['systolic'],
      diastolic: json['diastolic'],
      respiratoryRate: json['respiratoryRate'],
      oxygenSaturation: json['oxygenSaturation'],
      takenBy: json['takenBy'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientId': patientId,
      'timestamp': timestamp.toIso8601String(),
      'temperature': temperature,
      'heartRate': heartRate,
      'systolic': systolic,
      'diastolic': diastolic,
      'respiratoryRate': respiratoryRate,
      'oxygenSaturation': oxygenSaturation,
      'takenBy': takenBy,
    };
  }
}