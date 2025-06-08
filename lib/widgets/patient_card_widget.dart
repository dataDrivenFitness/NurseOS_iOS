import 'package:flutter/material.dart';
import 'package:nurse_os/models/patient_model.dart';

class PatientCardWidget extends StatelessWidget {
  final PatientModel patient;
  final VoidCallback onTap;

  const PatientCardWidget({required this.patient, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fullName = '${patient.firstName} ${patient.lastName}';

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: theme.cardColor,
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        leading: CircleAvatar(
          radius: 28,
          backgroundImage: NetworkImage(patient.photoUrl),
          backgroundColor: Colors.indigo,
        ),
        title: Text(
          fullName,
          style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('${patient.diagnosis} • Room ${patient.roomNumber}'),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('${patient.age} yrs', style: theme.textTheme.bodyMedium),
            Text(patient.pronouns, style: theme.textTheme.labelLarge?.copyWith(color: Colors.grey[400])),
          ],
        ),
      ),
    );
  }
}
