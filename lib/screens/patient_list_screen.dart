import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nurse_os/models/patient_model.dart';
import 'package:nurse_os/screens/patient_detail_screen.dart';
import 'package:nurse_os/screens/add_patient_screen.dart';
import 'package:nurse_os/state/display_preferences_provider.dart';
import 'package:nurse_os/state/patient_provider.dart';
import 'package:nurse_os/widgets/patient_card_widget.dart';

class PatientListScreen extends ConsumerWidget {
  const PatientListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prefs = ref.watch(displayPreferencesProvider);
    final patients = ref.watch(patientsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient List'),
        actions: [
          CupertinoButton(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: const Icon(CupertinoIcons.arrow_2_circlepath),
            onPressed: () async {
              await ref.read(patientRepositoryProvider).refresh();
            },
          ),
          CupertinoButton(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: const Icon(CupertinoIcons.add_circled),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const AddPatientScreen()),
              );
            },
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          CupertinoSliverRefreshControl(
            onRefresh: () async {
              await ref.read(patientRepositoryProvider).refresh();
            },
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
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
              childCount: patients.length,
            ),
          ),
        ],
      ),
    );
  }
}
