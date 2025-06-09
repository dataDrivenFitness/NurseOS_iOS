import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nurse_os/state/vitals_provider.dart';
import 'package:nurse_os/widgets/vitals_carousel.dart';
import 'package:nurse_os/widgets/vitals_action_buttons.dart';

class VitalsInteractiveSection extends ConsumerWidget {
  final String patientId;

  const VitalsInteractiveSection({super.key, required this.patientId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vitalsAsync = ref.watch(vitalsProvider(patientId));

    return vitalsAsync.when(
      data: (vitals) {
        if (vitals.isEmpty) {
          return const Center(child: Text('No vitals logged yet.'));
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VitalsCarousel(vitals: vitals),
            const SizedBox(height: 8),
            VitalsActionButtons(
              patientId: patientId,
              onAddVital: () => debugPrint("Add Vitals tapped"),
              onViewGraph: () => debugPrint("View Graph tapped"),
            ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Center(child: Text('Error: $e')),
    );
  }
}
