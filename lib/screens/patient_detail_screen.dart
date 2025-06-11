// Final version with only the centered vitals button row preserved and VitalsActionButtons removed

import 'package:flutter/material.dart';
import 'package:nurse_os/widgets/risk_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/patient_model.dart';
import '../state/display_preferences_provider.dart';
import '../utils/image_utils.dart';
import 'package:nurse_os/extensions/risk_utils.dart';
import '../widgets/vitals_interactive_section.dart';
import '../widgets/care_plan_section.dart';

class PatientDetailScreen extends ConsumerWidget {
  final PatientModel patient;

  const PatientDetailScreen({super.key, required this.patient});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prefs = ref.watch(displayPreferencesProvider);
    final image = imageProviderFromPath(patient.photoUrl);

    return Scaffold(
      appBar: AppBar(title: const Text('Patient Details')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: CircleAvatar(
              radius: 50,
              backgroundImage: image,
              backgroundColor: Colors.grey[200],
            ),
          ),
          const SizedBox(height: 12),
          Center(
            child: Text(
              '${patient.firstName} ${patient.lastName}',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          const SizedBox(height: 16),
          if (prefs.showAge) Text('Age: ${patient.age}'),
          if (prefs.showPreferredPronouns && patient.pronouns != null)
            Text('Pronouns: ${patient.pronouns}'),
          if (prefs.showRoomNumber) Text('Room: ${patient.roomNumber}'),
          if (prefs.showDiagnosis) Text('Diagnosis: ${patient.diagnosis}'),
          if ((prefs.showHighRiskAlerts &&
              (patient.riskLevel == RiskLevel.medium || patient.riskLevel == RiskLevel.high)))
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: patient.riskLevel == RiskLevel.high ? Colors.red : Colors.orange,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${patient.riskLevel?.name.toUpperCase() ?? 'UNKNOWN'} RISK',
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),

          if (prefs.showTags && patient.tags != null && patient.tags!.isNotEmpty)
            RiskTagRow(tags: patient.tags!),

          const Divider(height: 32),
          VitalsInteractiveSection(patientId: patient.id),
          const SizedBox(height: 16),

          Center(
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 12,
              runSpacing: 8,
              children: [
                FilledButton.icon(
                  onPressed: () {
                    // TODO: Navigate to vitals entry
                  },
                  icon: const Icon(Icons.add),
                  label: const Text("Add Vitals"),
                ),
                OutlinedButton.icon(
                  onPressed: () {
                    // TODO: Navigate to vitals graph
                  },
                  icon: const Icon(Icons.show_chart),
                  label: const Text("View Graph"),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),
          CarePlanSection(patientId: patient.id),
        ],
      ),
    );
  }
}
