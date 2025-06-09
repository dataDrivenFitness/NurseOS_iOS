// lib/widgets/vitals_chart_widget.dart

import 'package:flutter/material.dart';

class VitalsChartWidget extends StatelessWidget {
  final String patientId;

  const VitalsChartWidget({super.key, required this.patientId});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Center(
        child: Text('Vitals chart coming soon', style: TextStyle(color: Colors.grey)),
      ),
    );
  }
}
