import 'package:flutter/material.dart';
import 'package:nurse_os/models/vitals_model.dart';
import 'package:nurse_os/widgets/vitals_summary_card.dart';

/// VitalsCarousel
///
/// Displays 1 or 2 vitals side-by-side, or up to 3 in a horizontal scroll.
/// If there are more than 3 vitals, adds a trailing ghost indicator.
class VitalsCarousel extends StatelessWidget {
  final List<VitalsModel> vitals;

  const VitalsCarousel({super.key, required this.vitals});

  @override
  Widget build(BuildContext context) {
    final padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8);

    if (vitals.length == 1) {
      return Padding(
        padding: padding,
        child: SizedBox(
          width: double.infinity,
          child: VitalsSummaryCard(vitals: vitals.first),
        ),
      );
    }

    if (vitals.length == 2) {
      return Padding(
        padding: padding,
        child: Row(
          children: vitals.map((v) {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: VitalsSummaryCard(vitals: v),
              ),
            );
          }).toList(),
        ),
      );
    }

    // 🟦 For 3+ vitals → scrollable cards, capped at 3 + ghost if needed
    return SizedBox(
      height: 220,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: padding,
        itemCount: vitals.length > 3 ? 4 : vitals.length.clamp(0, 3),
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (_, i) {
          if (i < 3 && i < vitals.length) {
            // ✅ Real vitals card
            return SizedBox(
              width: 260,
              child: VitalsSummaryCard(vitals: vitals[i]),
            );
          } else {
            // 🕶️ Ghost indicator showing there’s more
            return Container(
              width: 80,
              margin: const EdgeInsets.only(top: 12),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Icon(Icons.more_horiz, size: 24, color: Colors.grey),
              ),
            );
          }
        },
      ),
    );
  }
}
