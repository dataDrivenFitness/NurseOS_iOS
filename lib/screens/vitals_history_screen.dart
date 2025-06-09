import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nurse_os/models/vitals_model.dart';
import 'package:nurse_os/state/vitals_provider.dart';

class VitalsHistoryScreen extends ConsumerWidget {
  final String patientId;

  const VitalsHistoryScreen({super.key, required this.patientId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vitalsAsync = ref.watch(vitalsProvider(patientId));

    return Scaffold(
      appBar: AppBar(title: const Text("Vitals History")),
      body: vitalsAsync.when(
        data: (vitalsList) {
          if (vitalsList.isEmpty) {
            return const Center(child: Text("No vitals yet"));
          }

          return ListView.builder(
            itemCount: vitalsList.length,
            itemBuilder: (_, i) {
              final v = vitalsList[i];
              final time = '${v.recordedAt.toLocal()}'.split('.').first;
              return ListTile(
                title: Text(time),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Temp: ${v.temperature}°F'),
                    Text('Pulse: ${v.pulse} bpm'),
                    Text('BP: ${v.systolic}/${v.diastolic} mmHg'),
                    Text('Resp: ${v.respirationRate} bpm'),
                    Text('O₂: ${v.oxygenSaturation}%'),
                    const SizedBox(height: 4),
                    Text('- ${v.recordedBy}', style: Theme.of(context).textTheme.labelSmall),
                  ],
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
