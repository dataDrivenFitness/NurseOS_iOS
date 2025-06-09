
// Updated to include vitals trend indicators
// Example: ↑ if pulse is higher than previous, ↓ if lower

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nurse_os/state/vitals_controller.dart';
import 'package:nurse_os/models/vitals_model.dart';
import 'package:timeago/timeago.dart' as timeago;

class VitalsHistoryWidget extends ConsumerWidget {
  final String patientId;

  const VitalsHistoryWidget({super.key, required this.patientId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vitalsAsync = ref.watch(vitalsControllerProvider(patientId));

    return vitalsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Text('Error loading vitals: $e'),
      data: (vitalsList) {
        if (vitalsList.isEmpty) return const Text('No vitals recorded.');

        final latest = vitalsList[0];
        final previous = vitalsList.length > 1 ? vitalsList[1] : null;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Latest Vitals', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(child: _buildVitalsCard(context, latest, label: 'Current', previous: previous)),
                if (previous != null) ...[
                  const SizedBox(width: 12),
                  Expanded(child: _buildVitalsCard(context, previous, label: 'Previous')),
                ],
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildVitalsCard(BuildContext context, VitalsModel vitals, {required String label, VitalsModel? previous}) {
    final timeString = timeago.format(vitals.timestamp, allowFromNow: true);

    String trendIcon(num current, num? prev) {
      if (prev == null) return '';
      return current > prev ? '↑' : current < prev ? '↓' : '→';
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: Theme.of(context).textTheme.labelMedium),
            Text('Temp: ${vitals.temperature} °F ${trendIcon(vitals.temperature, previous?.temperature)}'),
            Text('Pulse: ${vitals.pulse} bpm ${trendIcon(vitals.pulse, previous?.pulse)}'),
            Text('BP: ${vitals.systolicBP}/${vitals.diastolicBP} mmHg'),
            Text('RR: ${vitals.respirationRate} ${trendIcon(vitals.respirationRate, previous?.respirationRate)}'),
            Text('SpO₂: ${vitals.oxygenSaturation}% ${trendIcon(vitals.oxygenSaturation, previous?.oxygenSaturation)}'),
            Text('Logged ${timeString}', style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
