import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nurse_os/models/patient_model.dart';
import 'package:nurse_os/screens/patient_detail_screen.dart';
import 'package:nurse_os/state/display_preferences_provider.dart';
import 'package:nurse_os/state/patient_provider.dart';
import 'package:nurse_os/widgets/patient_card_widget.dart';

class PatientListScreen extends ConsumerWidget {
  const PatientListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prefs = ref.watch(displayPreferencesProvider);
    final asyncPatients = ref.watch(patientsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Patient List')),
      body: asyncPatients.when(
        data: (patients) {
          return ListView.builder(
            itemCount: patients.length,
            itemBuilder: (context, index) {
              final patient = patients[index];
              return PatientCardWidget(
                patient: patient,
                prefs: prefs,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => PatientDetailScreen(patient: patient),
                    ),
                  );
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
