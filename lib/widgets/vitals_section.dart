
import 'package:flutter/material.dart';
import 'vitals_summary_card.dart';
import 'vitals_chart_widget.dart';
import 'vitals_history_widget.dart';

class VitalsSection extends StatelessWidget {
  final String patientId;

  const VitalsSection({super.key, required this.patientId});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Vitals Overview', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        VitalsSummaryCard(patientId: patientId, showAllVitals: false),
        const SizedBox(height: 12),
        VitalsChartWidget(patientId: patientId),
        const SizedBox(height: 12),
        VitalsHistoryWidget(patientId: patientId),
      ],
    );
  }
}
