// lib/widgets/display_preferences_sheet.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../state/display_preferences_provider.dart';

class DisplayPreferencesSheet extends ConsumerWidget {
  const DisplayPreferencesSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prefs = ref.watch(displayPreferencesProvider);

    final options = [
      _PrefOption('Room Number', prefs.showRoomNumber, 'roomNumber'),
      _PrefOption('Diagnosis', prefs.showDiagnosis, 'diagnosis'),
      _PrefOption('Age', prefs.showAge, 'age'),
      _PrefOption('Pronouns', prefs.showPreferredPronouns, 'pronouns'),
      _PrefOption('High-Risk', prefs.showHighRiskAlerts, 'highRisk'),
      _PrefOption('Vitals Trend', prefs.showVitalsTrend, 'vitals'),
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Patient Card Display', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: options.map((opt) {
              return ChoiceChip(
                label: Text(opt.label),
                selected: opt.value,
                selectedColor: Colors.indigo.shade100,
                onSelected: (_) {
                  ref.read(displayPreferencesProvider.notifier).toggle(opt.key);
                },
                labelStyle: TextStyle(
                  color: opt.value ? Colors.indigo.shade900 : Colors.grey[700],
                  fontWeight: opt.value ? FontWeight.w600 : FontWeight.w400,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _PrefOption {
  final String label;
  final bool value;
  final String key;

  _PrefOption(this.label, this.value, this.key);
}
