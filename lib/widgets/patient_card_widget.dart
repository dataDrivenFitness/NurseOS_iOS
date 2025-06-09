import 'package:flutter/material.dart';
import 'package:nurse_os/models/patient_model.dart';
import 'package:nurse_os/utils/risk_utils.dart';
import 'package:nurse_os/state/display_preferences_provider.dart';

class PatientCardWidget extends StatelessWidget {
  final PatientModel patient;
  final DisplayPreferences prefs;
  final VoidCallback? onTap;

  const PatientCardWidget({
    super.key,
    required this.patient,
    required this.prefs,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final hasRisk = prefs.showHighRiskAlerts &&
        (patient.riskLevel == RiskLevel.high || patient.riskLevel == RiskLevel.medium);

    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left: Profile + Risk
              Column(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage:
                        patient.photoUrl != null ? NetworkImage(patient.photoUrl!) : null,
                    backgroundColor: Colors.grey[300],
                  ),
                  if (hasRisk)
                    Container(
                      margin: const EdgeInsets.only(top: 6),
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: patient.riskLevel == RiskLevel.high ? Colors.red : Colors.orange,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${patient.riskLevel!.name.toUpperCase()} RISK',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 12),

              // Right: Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name + Pronouns
                    RichText(
                      text: TextSpan(
                        text: '${patient.firstName} ${patient.lastName} ',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                        children: prefs.showPreferredPronouns && patient.pronouns != null
                            ? [
                                TextSpan(
                                  text: '(${patient.pronouns})',
                                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                        color: Colors.grey[600],
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.normal,
                                      ),
                                )
                              ]
                            : [],
                      ),
                    ),

                    const SizedBox(height: 4),
                    if (prefs.showDiagnosis && patient.diagnosis != null)
                      RichText(
                        text: TextSpan(
                          text: 'Diagnosis: ',
                          style: DefaultTextStyle.of(context).style.copyWith(fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(
                              text: patient.diagnosis!,
                              style: const TextStyle(fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                    if (prefs.showAge)
                      RichText(
                        text: TextSpan(
                          text: 'Age: ',
                          style: DefaultTextStyle.of(context).style.copyWith(fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(
                              text: '${patient.age}',
                              style: const TextStyle(fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                    if (prefs.showRoomNumber && patient.roomNumber != null)
                      RichText(
                        text: TextSpan(
                          text: 'Room: ',
                          style: DefaultTextStyle.of(context).style.copyWith(fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(
                              text: patient.roomNumber!,
                              style: const TextStyle(fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),

                    // Tags row
                    if (prefs.showTags && patient.tags != null && patient.tags!.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 4,
                        runSpacing: 2,
                        children: patient.tags!
                            .map(
                              (tag) => Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.blueGrey[50],
                                  border: Border.all(color: Colors.blueGrey.shade300),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  tag,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
