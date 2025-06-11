import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nurse_os/state/vitals_controller.dart';
import 'package:nurse_os/widgets/vitals_compact_card.dart';
import 'package:flutter/cupertino.dart';

class VitalsCardScroller extends ConsumerWidget {
  final String patientId;

  const VitalsCardScroller({super.key, required this.patientId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vitalsAsync = ref.watch(vitalsControllerProvider(patientId));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Vitals',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  Navigator.pushNamed(context, '/vitals-entry', arguments: {'patientId': patientId});
                },
                child: const Row(
                  children: [
                    Icon(CupertinoIcons.add, size: 20),
                    SizedBox(width: 4),
                    Text('Add Vitals'),
                  ],
                ),
              ),
            ],
          ),
        ),
        vitalsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error loading vitals')),
          data: (vitalsList) {
            if (vitalsList.isEmpty) {
              return const Center(child: Text('No vitals recorded'));
            }

            final screenWidth = MediaQuery.of(context).size.width;
            final cardWidth = vitalsList.length == 1
                ? screenWidth * 0.95
                : screenWidth * 0.8;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 220,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: vitalsList.length,
                    itemBuilder: (context, index) {
                      final vitals = vitalsList[index];
                      return SizedBox(
                        width: cardWidth,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: VitalsCompactCard(vitals: vitals),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/vitals-history', arguments: {'patientId': patientId});
                      },
                      child: const Text('Vitals History'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/vitals-chart', arguments: {'patientId': patientId});
                      },
                      child: const Text('View Graph'),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
