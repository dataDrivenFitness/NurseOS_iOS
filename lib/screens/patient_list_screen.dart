import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/patient_card_widget.dart';
import '../screens/patient_detail_screen.dart';
import '../state/patient_list_controller.dart';

class PatientListScreen extends ConsumerWidget {
  const PatientListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final patientAsync = ref.watch(patientListControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Patients')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: patientAsync.when(
          data: (patients) => ListView.builder(
            itemCount: patients.length,
            itemBuilder: (_, i) {
              final p = patients[i];
              return PatientCardWidget(
                patient: p,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PatientDetailScreen(patientId: p.id),
                    ),
                  );
                },
              );
            },
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error: $e')),
        ),
      ),
    );
  }
}
