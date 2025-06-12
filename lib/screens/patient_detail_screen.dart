import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nurse_os/models/patient_model.dart';
import 'package:nurse_os/state/display_preferences_provider.dart';
import 'package:nurse_os/widgets/profile_avatar.dart';
import 'package:nurse_os/widgets/vitals_interactive_section.dart';
import 'package:nurse_os/widgets/care_plan_section.dart';
import 'package:nurse_os/widgets/error_banner.dart';
import 'package:nurse_os/state/vitals_provider.dart';
import 'package:nurse_os/extensions/risk_utils.dart';
import 'package:nurse_os/extensions/patient_risk_extension.dart';

/// Text styling and dimension constants for the patient detail screen.
class _PatientStyles {
  static const double avatarRadius = 55;
  static const name = TextStyle(fontSize: 24, fontWeight: FontWeight.bold, height: 1.1);
  static const meta = TextStyle(fontSize: 14, color: Colors.black54, height: 1.2);
  static const diagnosis = TextStyle(fontSize: 16, height: 1.2);
  static const riskPill = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    height: 1,
  );
  static const tagFont = TextStyle(fontSize: 12);
}

/// Main detail screen showing full patient profile, vitals, and care plan.
class PatientDetailScreen extends ConsumerWidget {
  final PatientModel patient;

  const PatientDetailScreen({super.key, required this.patient});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prefs = ref.watch(displayPreferencesProvider);
    final risk = patient.resolvedRiskLevel;
    final hasRisk = prefs.showHighRiskAlerts &&
        (risk == RiskLevel.high || risk == RiskLevel.medium);

    return Scaffold(
      appBar: AppBar(title: const Text('Patient Details')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          /// Profile image
          Center(
            child: buildProfileAvatar(
              context: context,
              imageUrl: patient.photoUrl,
              fullName: '${patient.firstName} ${patient.lastName}',
              radius: _PatientStyles.avatarRadius,
            ),
          ),
          const SizedBox(height: 12),

          /// Center-aligned text block: Name, Meta, Diagnosis, Risk
          Center(
            child: Column(
              children: [
                /// Full name
                Text(
                  '${patient.firstName} ${patient.lastName}',
                  style: _PatientStyles.name,
                ),

                /// Meta line: Age • Pronouns • Location
                if (prefs.showAge || prefs.showPreferredPronouns || prefs.showRoomNumber)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      [
                        if (prefs.showAge) '${patient.age}',
                        if (prefs.showPreferredPronouns && patient.pronouns != null)
                          patient.pronouns!,
                        if (prefs.showRoomNumber && patient.location != null)
                          patient.location!
                      ].join(' • '),
                      style: _PatientStyles.meta,
                    ),
                  ),

                /// Diagnosis
                if (prefs.showDiagnosis && patient.diagnosis != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      patient.diagnosis!,
                      style: _PatientStyles.diagnosis,
                    ),
                  ),

                /// Risk Pill
                if (hasRisk)
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: risk == RiskLevel.high ? Colors.red : Colors.orange,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Center(
                      child: Text(
                        '${risk.name.toUpperCase()} RISK',
                        style: _PatientStyles.riskPill,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          /// Tags
          if (prefs.showTags && patient.tags != null && patient.tags!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Wrap(
                spacing: 6,
                runSpacing: 4,
                children: patient.tags!
                    .map(
                      (tag) => Chip(
                        label: Text(tag, style: _PatientStyles.tagFont),
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1.5),
                        backgroundColor:
                            Theme.of(context).brightness == Brightness.dark
                                ? Colors.grey[850]
                                : Colors.grey[200],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(999),
                        ),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.compact,
                      ),
                    )
                    .toList(),
              ),
            ),

          const Divider(height: 32),

          /// Vitals Section
          ref.watch(vitalsProvider(patient.id)).when(
                data: (vitals) => VitalsInteractiveSection(patientId: patient.id),
                loading: () => const CircularProgressIndicator(),
                error: (e, _) => ErrorBanner(
                  message: 'Unable to load vitals.',
                  onRetry: () => ref.refresh(vitalsProvider(patient.id)),
                ),
              ),

          const SizedBox(height: 16),

          /// Action Buttons
          Center(
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 12,
              runSpacing: 8,
              children: [
                FilledButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                  label: const Text("Add Vitals"),
                ),
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.show_chart),
                  label: const Text("View Graph"),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          /// Care Plan Section
          CarePlanSection(patientId: patient.id),
        ],
      ),
    );
  }
}
