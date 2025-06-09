
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../state/care_plan_provider.dart';
import '../models/care_plan_model.dart';

class CarePlanSection extends ConsumerWidget {
  final String patientId;

  const CarePlanSection({super.key, required this.patientId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final carePlansAsync = ref.watch(carePlansProvider(patientId));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Care Plans', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        carePlansAsync.when(
          data: (plans) {
            if (plans.isEmpty) {
              return const Text('No active care plans.');
            }
            return Column(
              children: plans.map((plan) => ListTile(
                title: Text(plan.title),
                subtitle: Text(plan.description),
                trailing: Text(plan.endDate == null ? 'ACTIVE' : 'ENDED'),
              )).toList(),
            );
          },
          loading: () => const CircularProgressIndicator(),
          error: (err, _) => Text('Error: \$err'),
        ),
      ],
    );
  }
}
