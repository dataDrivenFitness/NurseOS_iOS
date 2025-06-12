import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nurse_os/state/vitals_provider.dart';
import 'package:nurse_os/screens/vitals_entry_screen.dart';
import 'package:nurse_os/screens/vitals_chart_screen.dart';
import 'package:nurse_os/widgets/vitals_carousel.dart';
import 'package:nurse_os/widgets/vitals_action_buttons.dart';

// 🔧 Adjustable layout constants
const double _titleFontSize = 24;

/// VitalsInteractiveSection
///
/// Handles display of the vitals section on patient detail screen.
/// Shows title, add button, vitals (if available), and action buttons.
class VitalsInteractiveSection extends ConsumerWidget {
  final String patientId;

  const VitalsInteractiveSection({super.key, required this.patientId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brightness = MediaQuery.of(context).platformBrightness;
    final isDark = brightness == Brightness.dark;

    final vitalsAsync = ref.watch(vitalsProvider(patientId));

    return vitalsAsync.when(
      data: (vitals) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🟦 Section header: Vitals title + circular "+" button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Vitals',
                    style: TextStyle(
                      fontSize: _titleFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder: (_) => VitalsEntryScreen(patientId: patientId),
                        ),
                      );
                    },
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: CupertinoColors.systemGrey5,
                      ),
                      child: const Icon(CupertinoIcons.add, size: 20),
                    ),
                  ),
                ],
              ),
            ),

            // 🟧 Conditionally show vitals carousel if present
            if (vitals.isNotEmpty) ...[
              VitalsCarousel(vitals: vitals),
              const SizedBox(height: 8),
            ] else ...[
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'No vitals logged yet.',
                  style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
                ),
              ),
              const SizedBox(height: 12),
            ],

            // ✅ Repurposed, tag-style action buttons
            VitalsActionButtons(
              patientId: patientId,
              onViewGraph: () => Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (_) => VitalsChartScreen(patientId: patientId),
                ),
              ),
            ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Center(child: Text('Error: $e')),
    );
  }
}
