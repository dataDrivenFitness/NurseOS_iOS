
class UserDisplayPreferences {
  final bool showAge;
  final bool showRoomNumber;
  final bool showDiagnosis;
  final bool showPreferredPronouns;
  final bool showHighRiskAlerts;
  final bool showVitalsTrend;
  final bool showTags;
  final bool showAbsoluteTimestamps; // NEW

  const UserDisplayPreferences({
    this.showAge = true,
    this.showRoomNumber = true,
    this.showDiagnosis = true,
    this.showPreferredPronouns = true,
    this.showHighRiskAlerts = true,
    this.showVitalsTrend = true,
    this.showTags = true,
    this.showAbsoluteTimestamps = false,
  });

  UserDisplayPreferences copyWith({
    bool? showAge,
    bool? showRoomNumber,
    bool? showDiagnosis,
    bool? showPreferredPronouns,
    bool? showHighRiskAlerts,
    bool? showVitalsTrend,
    bool? showTags,
    bool? showAbsoluteTimestamps,
  }) {
    return UserDisplayPreferences(
      showAge: showAge ?? this.showAge,
      showRoomNumber: showRoomNumber ?? this.showRoomNumber,
      showDiagnosis: showDiagnosis ?? this.showDiagnosis,
      showPreferredPronouns: showPreferredPronouns ?? this.showPreferredPronouns,
      showHighRiskAlerts: showHighRiskAlerts ?? this.showHighRiskAlerts,
      showVitalsTrend: showVitalsTrend ?? this.showVitalsTrend,
      showTags: showTags ?? this.showTags,
      showAbsoluteTimestamps: showAbsoluteTimestamps ?? this.showAbsoluteTimestamps,
    );
  }
}
