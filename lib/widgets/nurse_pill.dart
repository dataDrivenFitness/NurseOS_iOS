import 'package:flutter/material.dart';
import '../ui/style.dart';

/// Reusable pill/tag widget — all risk badges, “NEW” tags, etc.
class NursePill extends StatelessWidget {
  final String label;
  final Color? bg;
  final Color? fg;

  const NursePill(this.label, {this.bg, this.fg, super.key});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).extension<AppTheme>()!;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.sm,
        vertical: Spacing.xs,
      ),
      decoration: BoxDecoration(
        color: bg ?? t.surface,
        borderRadius: BorderRadius.circular(Radii.pill),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: fg ?? t.primary,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
