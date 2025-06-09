import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:nurse_os/models/vitals_model.dart';
import 'package:nurse_os/state/vitals_provider.dart';

class VitalsDashboardScreen extends ConsumerWidget {
  final String patientId;
  final DateTimeRange range;

  const VitalsDashboardScreen({
    super.key,
    required this.patientId,
    required this.range,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vitalsAsync = ref.watch(vitalsProvider(patientId));

    return Scaffold(
      appBar: AppBar(title: const Text("Vitals Dashboard")),
      body: vitalsAsync.when(
        data: (vitalsList) {
          final filtered = vitalsList
              .where((v) =>
                  v.recordedAt.isAfter(range.start.subtract(const Duration(days: 1))) &&
                  v.recordedAt.isBefore(range.end.add(const Duration(days: 1))))
              .toList()
            ..sort((a, b) => a.recordedAt.compareTo(b.recordedAt));

          if (filtered.isEmpty) {
            return const Center(child: Text("No vitals in range"));
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _VitalsSparkline(title: 'Temperature (°F)', data: filtered.map((v) => v.temperature.toDouble()).toList()),
              _VitalsSparkline(title: 'Pulse (bpm)', data: filtered.map((v) => v.pulse.toDouble()).toList()),
              _VitalsSparkline(title: 'Systolic BP (mmHg)', data: filtered.map((v) => v.systolic.toDouble()).toList()),
              _VitalsSparkline(title: 'Diastolic BP (mmHg)', data: filtered.map((v) => v.diastolic.toDouble()).toList()),
              _VitalsSparkline(title: 'Respiration Rate (bpm)', data: filtered.map((v) => v.respirationRate.toDouble()).toList()),
              _VitalsSparkline(title: 'O₂ Saturation (%)', data: filtered.map((v) => v.oxygenSaturation.toDouble()).toList()),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}

class _VitalsSparkline extends StatelessWidget {
  final String title;
  final List<double> data;

  const _VitalsSparkline({required this.title, required this.data});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleSmall),
          SizedBox(
            height: 100,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: data.asMap().entries.map((e) => FlSpot(e.key.toDouble(), e.value)).toList(),
                    isCurved: true,
                    color: color,
                    dotData: FlDotData(show: false),
                    barWidth: 2,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
