import 'package:nurse_os/models/patient_model.dart';
import 'package:nurse_os/extensions/risk_utils.dart'; // Assumes enum RiskLevel { low, medium, high }

extension PatientRiskExtension on PatientModel {
  /// Resolves the patient's risk level based on override, age, diagnosis flags, and tags.
  RiskLevel get resolvedRiskLevel {
    // 1. Manual override takes priority
    if (manualRiskOverride != null) return manualRiskOverride!;

    // 2. Age-based logic
    if (age != null && age! >= 80) return RiskLevel.high;
    if (age != null && age! >= 65) return RiskLevel.medium;

    // 3. Diagnosis-based logic (placeholder keyword matching)
    if (diagnosis != null) {
      final dx = diagnosis!.toLowerCase();
      if (dx.contains('pneumonia') || dx.contains('sepsis')) {
        return RiskLevel.high;
      } else if (dx.contains('infection') || dx.contains('fall')) {
        return RiskLevel.medium;
      }
    }

    // 4. Tag-based logic
    if (tags != null && tags!.any((t) => t.toLowerCase().contains('fall risk'))) {
      return RiskLevel.medium;
    }

    // 5. Default
    return RiskLevel.low;
  }
}
