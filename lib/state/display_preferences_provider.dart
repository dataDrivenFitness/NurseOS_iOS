
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DisplayPreferences {
  final bool showHighRiskAlerts;
  final bool showDiagnosis;
  final bool showRoomNumber;
  final bool showVitalsTrend;
  final bool showAge;
  final bool showPreferredPronouns;
  final bool showTags;
  final bool showAbsoluteTimestamps; // NEW

  const DisplayPreferences({
    this.showHighRiskAlerts = true,
    this.showDiagnosis = true,
    this.showRoomNumber = true,
    this.showVitalsTrend = true,
    this.showAge = true,
    this.showPreferredPronouns = true,
    this.showTags = true,
    this.showAbsoluteTimestamps = false, // NEW default
  });

  DisplayPreferences copyWith({
    bool? showHighRiskAlerts,
    bool? showDiagnosis,
    bool? showRoomNumber,
    bool? showVitalsTrend,
    bool? showAge,
    bool? showPreferredPronouns,
    bool? showTags,
    bool? showAbsoluteTimestamps, // NEW
  }) {
    return DisplayPreferences(
      showHighRiskAlerts: showHighRiskAlerts ?? this.showHighRiskAlerts,
      showDiagnosis: showDiagnosis ?? this.showDiagnosis,
      showRoomNumber: showRoomNumber ?? this.showRoomNumber,
      showVitalsTrend: showVitalsTrend ?? this.showVitalsTrend,
      showAge: showAge ?? this.showAge,
      showPreferredPronouns: showPreferredPronouns ?? this.showPreferredPronouns,
      showTags: showTags ?? this.showTags,
      showAbsoluteTimestamps: showAbsoluteTimestamps ?? this.showAbsoluteTimestamps,
    );
  }
}

class DisplayPreferencesNotifier extends StateNotifier<DisplayPreferences> {
  DisplayPreferencesNotifier() : super(const DisplayPreferences());

  void toggle(String key) {
    switch (key) {
      case 'highRisk':
        state = state.copyWith(showHighRiskAlerts: !state.showHighRiskAlerts);
        break;
      case 'diagnosis':
        state = state.copyWith(showDiagnosis: !state.showDiagnosis);
        break;
      case 'room':
        state = state.copyWith(showRoomNumber: !state.showRoomNumber);
        break;
      case 'vitals':
        state = state.copyWith(showVitalsTrend: !state.showVitalsTrend);
        break;
      case 'age':
        state = state.copyWith(showAge: !state.showAge);
        break;
      case 'pronouns':
        state = state.copyWith(showPreferredPronouns: !state.showPreferredPronouns);
        break;
      case 'tags':
        state = state.copyWith(showTags: !state.showTags);
        break;
      case 'timestamps': // NEW
        state = state.copyWith(showAbsoluteTimestamps: !state.showAbsoluteTimestamps);
        break;
    }
  }
}

final displayPreferencesProvider =
    StateNotifierProvider<DisplayPreferencesNotifier, DisplayPreferences>(
        (ref) => DisplayPreferencesNotifier());
