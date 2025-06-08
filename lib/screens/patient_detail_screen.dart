import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nurse_os/state/patient_list_controller.dart';
import 'package:nurse_os/screens/vitals_entry_screen.dart';
import 'package:nurse_os/screens/care_plan_screen.dart';
import 'package:nurse_os/widgets/vitals_history_widget.dart';

class PatientDetailScreen extends ConsumerWidget {
  final String patientId;

  const PatientDetailScreen({super.key, required this.patientId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final patientsAsync = ref.watch(patientListControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Patient Profile')),
      body: patientsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (patients) {
          final patient = patients.firstWhere((p) => p.id == patientId);
          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              _PatientHeader(patient: patient),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                icon: const Icon(Icons.monitor_heart),
                label: const Text('Enter Vitals'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => VitalsEntryScreen(patientId: patient.id),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              VitalsHistoryWidget(patientId: patient.id),
              const SizedBox(height: 24),
              Text('Care Plans', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              CarePlanScreen(patientId: patient.id),
            ],
          );
        },
      ),
    );
  }
}

class _PatientHeader extends StatelessWidget {
  final dynamic patient;

  const _PatientHeader({required this.patient});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final admitted = patient.admittedAt.toLocal().toIso8601String().split('T').first;
    final fullName = '${patient.firstName} ${patient.lastName}';

    return Row(
      children: [
        CircleAvatar(
          radius: 36,
          backgroundImage: NetworkImage(patient.photoUrl),
          backgroundColor: Colors.indigo,
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(fullName, style: theme.textTheme.headlineMedium),
            Text(
              patient.pronouns,
              style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
            ),
            const SizedBox(height: 4),
            Text('Room ${patient.roomNumber}', style: theme.textTheme.bodyLarge),
            Text('Diagnosis: ${patient.diagnosis}', style: theme.textTheme.bodyLarge),
            Text('Admitted: $admitted', style: theme.textTheme.bodyMedium),
          ],
        ),
      ],
    );
  }
}
