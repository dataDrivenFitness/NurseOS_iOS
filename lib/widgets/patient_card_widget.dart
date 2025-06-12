import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/patient_model.dart';
import '../state/display_preferences_provider.dart';
import '../ui/style.dart';               // ← design tokens
import 'nurse_pill.dart';
import 'nurse_icon_button.dart';

/// Card that shows a patient avatar, name, risk pill and optional “NEW” tag.
/// Taps navigate to Patient Detail.
///
/// All spacing / colours come from design tokens (Guidelines §3).
class PatientCardWidget extends ConsumerWidget {
  const PatientCardWidget({
    super.key,
    required this.patient,
    required this.prefs,
    this.onTap,
  });

  final PatientModel patient;
  final DisplayPreferences prefs;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Theme.of(context).extension<AppTheme>()!; // quick token shortcut

    return InkWell(
      borderRadius: BorderRadius.circular(Radii.card),
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: Spacing.sm),
        padding: const EdgeInsets.all(Spacing.lg),
        decoration: BoxDecoration(
          color: t.surface,
          borderRadius: BorderRadius.circular(Radii.card),
        ),
        child: Row(
          children: [
            /* ------------------ Avatar ------------------ */
            CircleAvatar(
              radius: Radii.avatar,
              backgroundColor: Colors.blueGrey.withOpacity(.3),
              foregroundImage: patient.photoUrl?.isNotEmpty == true
                  ? NetworkImage(patient.photoUrl!)
                  : null,
              child: (patient.photoUrl?.isEmpty ?? true)
                  ? Text(
                      '${patient.firstName[0]}${patient.lastName[0]}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )
                  : null,
            ),
            const SizedBox(width: Spacing.lg),

            /* ------------- Name + pills column ------------- */
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    patient.displayName,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: Spacing.xs),

                  // Risk pill + optional “NEW”
                  Row(
                    children: [
                      NursePill(
                        patient.riskLevel.display,
                        bg: _riskBg(patient.riskLevel, t),
                        fg: Colors.white,
                      ),
                      if (patient.isNew)
                        Padding(
                          padding: const EdgeInsets.only(left: Spacing.sm),
                          child: const NursePill('NEW'),
                        ),
                    ],
                  ),
                ],
              ),
            ),

            /* --------- Optional actions (future) --------- */
            // NurseIconButton(
            //   icon: CupertinoIcons.ellipsis,
            //   onTap: () => showPatientMenu(context, patient),
            // ),
          ],
        ),
      ),
    );
  }

  /* Helper to map risk level → colour */
  Color _riskBg(RiskLevel level, AppTheme t) => switch (level) {
        RiskLevel.high => t.error,
        RiskLevel.medium => t.secondary,
        RiskLevel.low => t.divider,
      };
}
