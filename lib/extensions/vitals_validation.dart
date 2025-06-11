// lib/extensions/vitals_validation.dart

import '../models/vitals_model.dart';

extension VitalsValidation on VitalsModel {
  String? get validationError {
    if (pulse < 30 || pulse > 300) return 'Heart rate must be 30–300 bpm';
    if (systolic <= 0 || diastolic <= 0) return 'Blood pressure values must be positive';
    if (oxygenSaturation < 50 || oxygenSaturation > 100) return 'SpO2 must be 50–100%';
    if (temperature < 90 || temperature > 110) return 'Temperature is out of range';
    return null; // All good
  }
} 
