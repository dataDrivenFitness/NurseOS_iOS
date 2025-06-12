// lib/models/risk_level.dart
enum RiskLevel { low, medium, high }

extension RiskExt on RiskLevel {
  String get display => switch (this) {
        RiskLevel.low => 'Low',
        RiskLevel.medium => 'Medium',
        RiskLevel.high => 'High',
      };
}
