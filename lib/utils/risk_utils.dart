enum RiskLevel { low, medium, high }

const Map<RiskLevel, List<String>> riskDiagnosisMap = {
  RiskLevel.high: [
    /* Life-threatening acute conditions */
    'sepsis',
    'septic shock',
    'myocardial infarction',
    'stroke',
    'acute respiratory distress syndrome',
    'respiratory failure',
    'cardiogenic shock',
    'acute pulmonary embolism',
    'gi bleed',
    'intracranial hemorrhage',
    'acute renal failure',
    'major trauma',
  ],
  RiskLevel.medium: [
    /* Serious but not immediately life-threatening */
    'pneumonia',
    'diabetes',
    'hypertension',
    'congestive heart failure',
    'chronic kidney disease',
    'asthma',
    'uti',
    'copd exacerbation',
    'cancer',
    'atrial fibrillation',
  ],
  RiskLevel.low: [
    /* Chronic/mild conditions with minimal acute danger */
    'allergies',
    'minor injuries',
    'seasonal rhinitis',
    'eczema',
    'back pain',
    'otitis media',
    'sinusitis',
  ],
};

RiskLevel determineRiskLevel(String diagnosis) {
  final text = diagnosis.toLowerCase();
  for (final level in RiskLevel.values) {
    for (final keyword in riskDiagnosisMap[level]!) {
      if (text.contains(keyword)) return level;
    }
  }
  return RiskLevel.low;
}
