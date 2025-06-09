
enum RiskLevel { low, medium, high }

RiskLevel determineRiskLevel(String diagnosis) {
  final text = diagnosis.toLowerCase();
  if (text.contains('sepsis')) return RiskLevel.high;
  if (text.contains('hypertension')) return RiskLevel.medium;
  return RiskLevel.low;
}
