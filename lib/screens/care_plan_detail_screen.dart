import 'package:flutter/material.dart';
import '../models/care_plan_model.dart';

class CarePlanDetailScreen extends StatelessWidget {
  final CarePlanModel carePlan;

  const CarePlanDetailScreen({super.key, required this.carePlan});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(carePlan.title)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(carePlan.description, style: theme.textTheme.bodyLarge),
            const SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Start: ${carePlan.startDate.toLocal().toIso8601String().split('T').first}'),
                Text('End: ${carePlan.endDate != null ? carePlan.endDate!.toLocal().toIso8601String().split('T').first : 'Ongoing'}'),
              ],
            ),

            const SizedBox(height: 12),
            Text(
              'Created by ${carePlan.createdBy}',
              style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.outline),
            ),

            const Divider(height: 40),
            Text('AI RECOMMENDATION (stubbed)', style: theme.textTheme.labelLarge),
            const SizedBox(height: 6),
            const Text('Future GPT insights will show here.'),
          ],
        ),
      ),
    );
  }
}