// lib/widgets/vitals_compact_card.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:nurse_os/models/vitals_model.dart';

class VitalsCompactCard extends StatelessWidget {
  final VitalsModel vitals;

  const VitalsCompactCard({super.key, required this.vitals});

  @override
  Widget build(BuildContext context) {
    final timeString = timeago.format(vitals.recordedAt);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _formatDate(vitals.recordedAt),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            _buildVitalRow(CupertinoIcons.thermometer, 'Temp', '${vitals.temperature} °F'),
            _buildVitalRow(CupertinoIcons.heart, 'Heart Rate', '${vitals.pulse} bpm'),
            _buildVitalRow(CupertinoIcons.arrow_up_right, 'BP', '${vitals.systolic}/${vitals.diastolic} mmHg'),
            _buildVitalRow(CupertinoIcons.wind, 'Respiratory', '${vitals.respiratoryRate} bpm'),
            _buildVitalRow(CupertinoIcons.drop, 'SpO₂', '${vitals.oxygenSaturation}%'),
            const SizedBox(height: 8),
            Text(
              'Taken by ${vitals.recordedBy} • $timeString',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVitalRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.blueGrey),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          const Spacer(),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.month}/${date.day}/${date.year}';
  }
}
