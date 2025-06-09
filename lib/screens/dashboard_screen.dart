import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../state/user_provider.dart';
import '../widgets/dashboard_task_card.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userProvider);

    return userAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (user) {
        final hour = DateTime.now().hour;
        final greeting = hour < 12
            ? 'Good morning'
            : hour < 17
                ? 'Good afternoon'
                : 'Good evening';
        final emoji = hour < 12
            ? '☀️'
            : hour < 17
                ? '🌤️'
                : '🌙';

        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('$greeting,', style: Theme.of(context).textTheme.bodyLarge),
                  Text('Nurse ${user.firstName} $emoji',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          )),
                  const SizedBox(height: 32),

                  DashboardTaskCard(
                    icon: Icons.monitor_heart,
                    title: 'Vitals Entry',
                    subtitle: 'Record vital signs for assigned patients',
                    onTap: () {}, // 🔗 Add route later
                  ),
                  const SizedBox(height: 12),
                  DashboardTaskCard(
                    icon: Icons.assignment,
                    title: 'Care Plans',
                    subtitle: 'Review and update care plans',
                    onTap: () {}, // 🔗 Add route later
                  ),
                  const SizedBox(height: 12),
                  DashboardTaskCard(
                    icon: Icons.note_alt,
                    title: 'Notes',
                    subtitle: 'Add clinical notes and observations',
                    onTap: () {}, // 🔗 Add route later
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
