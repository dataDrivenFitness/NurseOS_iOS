import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/vitals_model.dart';

class VitalsSummaryCard extends StatelessWidget {
  final VitalsModel vitals;

  const VitalsSummaryCard({super.key, required this.vitals});

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat('MMM d, h:mm a');

    String timeAgo(DateTime dt) {
      final duration = DateTime.now().difference(dt);
      if (duration.inMinutes < 1) return 'just now';
      if (duration.inMinutes < 60) return '${duration.inMinutes} min ago';
      if (duration.inHours < 24) return '${duration.inHours} hr${duration.inHours > 1 ? 's' : ''} ago';
      return '${duration.inDays} day${duration.inDays > 1 ? 's' : ''} ago';
    }

    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 160),
      child: Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                formatter.format(vitals.recordedAt),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 6),
              Text('Pulse: ${vitals.pulse} bpm'),
              Text('BP: ${vitals.systolic}/${vitals.diastolic} mmHg'),
              Text('Temp: ${vitals.temperature.toStringAsFixed(1)} °F'),
              Text('Resp: ${vitals.respirationRate} bpm'),
              Text('O₂: ${vitals.oxygenSaturation}%'),
              const SizedBox(height: 8),
              Text(
                'Logged by: ${vitals.recordedBy}',
                style: Theme.of(context).textTheme.labelSmall,
              ),
              const SizedBox(height: 2),
              Text(
                timeAgo(vitals.recordedAt),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
