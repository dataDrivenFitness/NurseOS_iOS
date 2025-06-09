
import 'package:flutter/material.dart';
import 'package:nurse_os/widgets/risk_widgets.dart';
import 'package:nurse_os/models/patient_model.dart';
import 'package:nurse_os/utils/risk_utils.dart';

class PatientCardWidget extends StatelessWidget {
  final PatientModel patient;
  final VoidCallback onTap;
  final bool showTags;
  final bool showHighRiskAlerts;
  final bool showDiagnosis;
  final bool showAge;
  final bool showRoomNumber;
  final bool showPreferredPronouns;

  const PatientCardWidget({
    Key? key,
    required this.patient,
    required this.onTap,
    this.showTags = true,
    this.showHighRiskAlerts = true,
    this.showDiagnosis = true,
    this.showAge = true,
    this.showRoomNumber = true,
    this.showPreferredPronouns = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        onTap: onTap,
        leading: patient.photoUrl != null
            ? CircleAvatar(
                radius: 24,
                backgroundImage: NetworkImage(patient.photoUrl!),
              )
            : const CircleAvatar(
                radius: 24,
                child: Icon(Icons.person),
              ),
        title: Text('${patient.firstName} ${patient.lastName}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (showDiagnosis) Text('Diagnosis: ${patient.diagnosis}'),
            
            if (showTags && patient.tags != null && patient.tags!.isNotEmpty)
              RiskTagRow(tags: patient.tags!),

            if (showAge) Text('Age: ${patient.age}'),
            if (showRoomNumber) Text('Room: ${patient.roomNumber}'),
            if (showPreferredPronouns && patient.pronouns != null)
              Text('Pronouns: ${patient.pronouns}'),
          ],
        ),
        trailing: (showHighRiskAlerts && patient.riskLevel == RiskLevel.high)
            ? RiskLevelBadge(level: patient.riskLevel)
            : null,
      ),
    );
  }

  
}
