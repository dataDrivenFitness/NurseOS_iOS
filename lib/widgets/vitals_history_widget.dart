// lib/widgets/vitals_history_widget.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nurse_os/state/vitals_controller.dart';

class VitalsHistoryWidget extends ConsumerWidget {
  final String patientId;

  const VitalsHistoryWidget({super.key, required this.patientId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vitalsAsync = ref.watch(vitalsControllerProvider(patientId));

    return vitalsAsync.when(
      loading: () => const CircularProgressIndicator(),
      error: (e, _) => Text('Error loading vitals: $e'),
      data: (vitalsList) {
        if (vitalsList.isEmpty) {
          return const Text('No vitals recorded.');
        }

        final latest = vitalsList.first;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Latest Vitals', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text('Temp: ${latest.temperature} °F'),
            Text('Pulse: ${latest.pulse} bpm'),
            Text('BP: ${latest.systolicBP}/${latest.diastolicBP} mmHg'),
            Text('RR: ${latest.respirationRate} breaths/min'),
            Text('SpO₂: ${latest.oxygenSaturation}%'),
            if (latest.notes != null && latest.notes!.isNotEmpty)
              Text('Notes: ${latest.notes}', style: const TextStyle(fontStyle: FontStyle.italic)),
            Text('Logged by: ${latest.recordedBy ?? "unknown"}', style: const TextStyle(color: Colors.grey)),
          ],
        );
      },
    );
  }
}
