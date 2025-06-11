import 'package:nurse_os/models/patient_model.dart';
import 'package:nurse_os/extensions/risk_utils.dart';

extension PatientRiskExtension on PatientModel {
  RiskLevel get resolvedRiskLevel {
    return manualRiskOverride ?? determineRiskLevel(diagnosis);
  }
}
