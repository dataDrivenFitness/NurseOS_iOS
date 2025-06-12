
import 'package:flutter/material.dart';
import 'package:nurse_os/models/risk_level.dart';

class RiskTagRow extends StatelessWidget {
  final List<String> tags;

  const RiskTagRow({super.key, required this.tags});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6,
      runSpacing: 4,
      children: tags
          .map((tag) => Chip(
                label: Text(tag),
                backgroundColor: Colors.blue.shade50,
                labelStyle: const TextStyle(fontSize: 12),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: const EdgeInsets.symmetric(horizontal: 8),
              ))
          .toList(),
    );
  }
}

class RiskLevelBadge extends StatelessWidget {
  final RiskLevel? level;

  const RiskLevelBadge({super.key, required this.level});

  @override
  Widget build(BuildContext context) {
    if (level == null) return const SizedBox.shrink();

    Color color;
    String label;

    switch (level) {
      case RiskLevel.high:
        color = Colors.red;
        label = 'HIGH RISK';
        break;
      case RiskLevel.medium:
        color = Colors.orange;
        label = 'MODERATE RISK';
        break;
      case RiskLevel.low:
        color = Colors.green;
        label = 'LOW RISK';
        break;
      default:
        color = Colors.grey;
        label = 'UNKNOWN';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
      ),
    );
  }
}
