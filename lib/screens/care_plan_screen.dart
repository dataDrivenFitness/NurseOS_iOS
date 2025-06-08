import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../state/care_plan_provider.dart';
import '../models/care_plan_model.dart';
import 'care_plan_detail_screen.dart';

class CarePlanScreen extends ConsumerWidget {
  final String patientId;
  const CarePlanScreen({super.key, required this.patientId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final carePlansAsync = ref.watch(carePlansProvider(patientId));

    return carePlansAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (plans) => Column(
        children: [
          for (final plan in plans)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CarePlanCard(plan: plan),
            ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            icon: const Icon(Icons.add),
            label: const Text('Add Care Plan'),
            onPressed: () => _showAddPlanDialog(context, ref),
          ),
        ],
      ),
    );
  }

  void _showAddPlanDialog(BuildContext context, WidgetRef ref) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    DateTime? startDate = DateTime.now();
    DateTime? endDate;
    bool isOngoing = true;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('New Care Plan'),
        content: StatefulBuilder(
          builder: (ctx, setState) => SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                ListTile(
                  title: const Text('Start Date'),
                  subtitle: Text('${startDate?.toLocal().toIso8601String().split('T').first}'),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: ctx,
                      initialDate: startDate ?? DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2100),
                    );
                    if (picked != null) setState(() => startDate = picked);
                  },
                ),
                SwitchListTile(
                  title: const Text('Ongoing Plan'),
                  value: isOngoing,
                  onChanged: (val) => setState(() {
                    isOngoing = val;
                    if (val) endDate = null;
                  }),
                ),
                if (!isOngoing)
                  ListTile(
                    title: const Text('End Date'),
                    subtitle: Text(
                      endDate != null
                          ? endDate!.toLocal().toIso8601String().split('T').first
                          : 'Not selected',
                    ),
                    trailing: const Icon(Icons.calendar_month),
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: ctx,
                        initialDate: endDate ?? DateTime.now(),
                        firstDate: startDate ?? DateTime.now(),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) setState(() => endDate = picked);
                    },
                  ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              final plan = CarePlanModel(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                title: titleController.text,
                description: descriptionController.text,
                patientId: patientId,
                createdBy: 'demoUser123',
                startDate: startDate ?? DateTime.now(),
                endDate: isOngoing ? null : endDate,
                createdAt: DateTime.now(),
              );
              ref.read(carePlansProvider(patientId).notifier).addMockPlan(plan);
              Navigator.pop(ctx);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}

class CarePlanCard extends StatelessWidget {
  final CarePlanModel plan;
  const CarePlanCard({required this.plan});

  @override
  Widget build(BuildContext context) {
    final isOngoing = plan.endDate == null;
    final theme = Theme.of(context);
    final color = theme.colorScheme;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => CarePlanDetailScreen(carePlan: plan)),
        );
      },
      child: SizedBox(
        width: double.infinity,
        child: Card(
          color: color.surfaceVariant,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.symmetric(vertical: 6),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(plan.title, style: theme.textTheme.titleMedium),
                const SizedBox(height: 6),
                Text(plan.description, style: theme.textTheme.bodyMedium),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  children: [
                    _Tag(text: isOngoing ? 'Ongoing' : 'Scheduled'),
                    if (!isOngoing && plan.endDate != null)
                      _Tag(
                        text:
                            '${plan.startDate.toLocal().toIso8601String().split('T').first} → ${plan.endDate!.toLocal().toIso8601String().split('T').first}',
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  final String text;
  const _Tag({required this.text});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.primaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text, style: TextStyle(fontSize: 12, color: color.onPrimaryContainer)),
    );
  }
}