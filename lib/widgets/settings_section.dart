import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../state/theme_provider.dart';
import '../state/display_preferences_provider.dart';

class SettingsSection extends ConsumerWidget {
  const SettingsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(themeModeProvider) == ThemeMode.dark;
    final prefs = ref.watch(displayPreferencesProvider);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ListTile(
            title: Text('Settings', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          const Divider(height: 1),

          // 🌓 Dark Mode
          SwitchListTile(
            secondary: const Icon(Icons.brightness_6),
            title: const Text('Dark Mode'),
            value: isDark,
            onChanged: (_) => ref.read(themeModeProvider.notifier).toggle(),
          ),

          // 📋 Display Preferences
          ExpansionTile(
            leading: const Icon(Icons.visibility),
            title: const Text('Patient Card Display'),
            children: [
              _buildSwitchTile(ref, prefs.showHighRiskAlerts, 'Show High-Risk Alerts', 'highRisk', Icons.warning),
              _buildSwitchTile(ref, prefs.showDiagnosis, 'Show Diagnosis', 'diagnosis', Icons.local_hospital),
              _buildSwitchTile(ref, prefs.showRoomNumber, 'Show Room Number', 'room', Icons.meeting_room),
              _buildSwitchTile(ref, prefs.showVitalsTrend, 'Show Vitals Trend', 'vitals', Icons.favorite),
              _buildSwitchTile(ref, prefs.showAge, 'Show Age', 'age', Icons.cake),
              _buildSwitchTile(ref, prefs.showPreferredPronouns, 'Show Preferred Pronouns', 'pronouns', Icons.people),
              _buildSwitchTile(ref, prefs.showTags, 'Show Tags', 'tags', Icons.label),
              ],
          ),

          const Divider(),

          // 🔒 Biometric (Placeholder)
          ListTile(
            leading: const Icon(Icons.fingerprint),
            title: const Text('Enable Biometric Lock'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // TODO: Add FaceID/TouchID support
            },
          ),

          // 🔔 Notifications (Placeholder)
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notification Preferences'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // TODO: Navigate to notification settings
            },
          ),

          // 🌐 Language (Placeholder)
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Language'),
            trailing: const Text('English'),
            onTap: () {
              // TODO: Add language selection
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchTile(
    WidgetRef ref,
    bool value,
    String label,
    String key,
    IconData icon,
  ) {
    return SwitchListTile(
      secondary: Icon(icon),
      title: Text(label),
      value: value,
      onChanged: (_) => ref.read(displayPreferencesProvider.notifier).toggle(key),
    );
  }
}
