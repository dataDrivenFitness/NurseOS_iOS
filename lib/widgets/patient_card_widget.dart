import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/patient_model.dart';
import '../models/risk_level.dart';
import '../state/display_preferences_provider.dart';
import '../ui/style.dart';
import 'nurse_pill.dart';

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
    final t     = Theme.of(context).extension<AppTheme>()!;
    final level = patient.resolvedRiskLevel;

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /* ── Avatar + risk pill column ── */
            Column(
              children: [
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
                const SizedBox(height: Spacing.xs),
                if (level != RiskLevel.low)                // hide Low risk
                  NursePill(
                    level.display,
                    bg: _riskBg(level, t),
                    fg: Colors.white,
                  ),
              ],
            ),
            const SizedBox(width: Spacing.lg),

            /* ── Name + tag + NEW column ── */
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
                  /* ── NEW: Location / room row ── */
                  if (patient.location.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: Spacing.xs),
                      child: Text(
                        patient.location,
                        style: TextStyle(
                          fontSize: 12,
                          color: t.divider,      // muted grey token
                        ),
                      ),
                    ),

                  if (patient.tags != null && patient.tags!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: Spacing.xs),
                      child: Wrap(
                        spacing: Spacing.xs,
                        runSpacing: Spacing.xs,
                        children: patient.tags!
                            .map((tag) => NursePill(
                                  tag,
                                  bg: t.surface,
                                  fg: t.primary,
                                ))
                            .toList(),
                      ),
                    ),
                  if (patient.isNew)
                    const Padding(
                      padding: EdgeInsets.only(top: Spacing.xs),
                      child: NursePill('NEW'),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /* Map RiskLevel -> pill colour */
  Color _riskBg(RiskLevel level, AppTheme t) => switch (level) {
        RiskLevel.high   => t.error,
        RiskLevel.medium => t.secondary,
        RiskLevel.low    => t.divider, // not shown
      };
}
