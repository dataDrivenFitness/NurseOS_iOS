import 'package:flutter/material.dart';
import 'package:nurse_os/widgets/risk_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/patient_model.dart';
import '../state/display_preferences_provider.dart';
import '../widgets/vitals_interactive_section.dart';
import '../widgets/care_plan_section.dart';
import 'package:nurse_os/widgets/profile_avatar.dart';
import 'package:nurse_os/extensions/risk_utils.dart';
import 'package:nurse_os/widgets/error_banner.dart';
import '../state/vitals_provider.dart';

/// PatientDetailScreen renders the detailed profile view for a selected patient.
/// Includes profile info, vitals display with error handling, and care plan section.
class PatientDetailScreen extends ConsumerWidget {
  /// The patient whose details are being displayed
  final PatientModel patient;

  const PatientDetailScreen({super.key, required this.patient});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Fetch user-specific display preferences (e.g. what fields to show)
    final prefs = ref.watch(displayPreferencesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Patient Details')),
      // Main scrollable content area
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Patient profile photo and name
          Center(
            child: buildProfileAvatar(
              context: context,
              imageUrl: patient.photoUrl,
              fullName: '${patient.firstName} ${patient.lastName}',
              radius: 50,
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

          // Conditionally show patient demographics
          if (prefs.showAge) Text('Age: ${patient.age}'),
          if (prefs.showPreferredPronouns && patient.pronouns != null)
            Text('Pronouns: ${patient.pronouns}'),
          if (prefs.showRoomNumber) Text('Room: ${patient.roomNumber}'),
          if (prefs.showDiagnosis) Text('Diagnosis: ${patient.diagnosis}'),

          // Conditional risk badge
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

          // Optional patient tags
          if (prefs.showTags && patient.tags != null && patient.tags!.isNotEmpty)
            RiskTagRow(tags: patient.tags!),

          const Divider(height: 32),

          // Load vitals using Riverpod provider, with error-safe wrapper
          ref.watch(vitalsProvider(patient.id)).when(
            data: (vitals) => VitalsInteractiveSection(patientId: patient.id),
            loading: () => const CircularProgressIndicator(),
            error: (e, _) => ErrorBanner(
              message: 'Unable to load vitals.',
              onRetry: () => ref.refresh(vitalsProvider(patient.id)),
            ),
          ),

          const SizedBox(height: 16),

          // Vitals action buttons
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

          // Static care plan section (no error wrapper yet)
          CarePlanSection(patientId: patient.id),
        ],
      ),
    );
  }
}
