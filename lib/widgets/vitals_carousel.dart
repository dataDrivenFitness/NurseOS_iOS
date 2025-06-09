import 'package:flutter/material.dart';
import 'package:nurse_os/models/vitals_model.dart';
import 'package:nurse_os/widgets/vitals_summary_card.dart';

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

    return SizedBox(
      height: 220,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: padding,
        itemCount: vitals.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (_, i) => SizedBox(
          width: 260,
          child: VitalsSummaryCard(vitals: vitals[i]),
        ),
      ),
    );
  }
}
