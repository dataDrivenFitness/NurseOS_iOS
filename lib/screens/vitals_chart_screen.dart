import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:nurse_os/models/vitals_model.dart';
import 'package:nurse_os/state/vitals_provider.dart';

class VitalsChartScreen extends ConsumerWidget {
  final String patientId;

  const VitalsChartScreen({super.key, required this.patientId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vitalsAsync = ref.watch(vitalsProvider(patientId));

    return Scaffold(
      appBar: AppBar(title: const Text("Vitals Charts")),
      body: vitalsAsync.when(
        data: (vitalsList) {
          if (vitalsList.isEmpty) {
            return const Center(child: Text("No data available"));
          }

          final sorted = [...vitalsList]..sort((a, b) => a.recordedAt.compareTo(b.recordedAt));

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _VitalsLineChart(
                title: 'Temperature (°F)',
                data: sorted.map((v) => v.temperature.toDouble()).toList(),
              ),
              _VitalsLineChart(
                title: 'Pulse (bpm)',
                data: sorted.map((v) => v.pulse.toDouble()).toList(),
              ),
              _VitalsLineChart(
                title: 'Systolic BP (mmHg)',
                data: sorted.map((v) => v.systolic.toDouble()).toList(),
              ),
              _VitalsLineChart(
                title: 'Diastolic BP (mmHg)',
                data: sorted.map((v) => v.diastolic.toDouble()).toList(),
              ),
              _VitalsLineChart(
                title: 'Respiration Rate (bpm)',
                data: sorted.map((v) => v.respiratoryRate.toDouble()).toList(),
              ),
              _VitalsLineChart(
                title: 'Oxygen Saturation (%)',
                data: sorted.map((v) => v.oxygenSaturation.toDouble()).toList(),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}

class _VitalsLineChart extends StatelessWidget {
  final String title;
  final List<double> data;

  const _VitalsLineChart({required this.title, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          SizedBox(
            height: 180,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(show: true),
                titlesData: FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: data
                        .asMap()
                        .entries
                        .map((e) => FlSpot(e.key.toDouble(), e.value))
                        .toList(),
                    isCurved: true,
                    barWidth: 2,
                    color: Colors.blue,
                    dotData: FlDotData(show: false),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
