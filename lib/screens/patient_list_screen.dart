import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nurse_os/models/patient_model.dart';
import 'package:nurse_os/state/display_preferences_provider.dart';
import 'package:nurse_os/state/patient_provider.dart';
import 'package:nurse_os/widgets/patient_card_widget.dart';
import 'patient_detail_screen.dart';

class PatientListScreen extends ConsumerWidget {
  const PatientListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final patientsAsync = ref.watch(patientsProvider);
    final prefs = ref.watch(displayPreferencesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Patient List')),
      body: patientsAsync.when(
        data: (patients) => ListView.builder(
          itemCount: patients.length,
          itemBuilder: (context, index) {
            final patient = patients[index];
            return PatientCardWidget(
              patient: patient,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PatientDetailScreen(patient: patient),
                  ),
                );
              },
              showTags: prefs.showTags,
              showDiagnosis: prefs.showDiagnosis,
              showHighRiskAlerts: prefs.showHighRiskAlerts,
              showAge: prefs.showAge,
              showRoomNumber: prefs.showRoomNumber,
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error loading patients: $e')),
      ),
    );
  }
}
