import 'package:flutter/cupertino.dart';
import '../ui/style.dart';
import 'package:flutter/material.dart';   // ← add this


class NurseIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const NurseIconButton({required this.icon, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).extension<AppTheme>()!;
    return CupertinoButton(
      padding: const EdgeInsets.all(Spacing.sm),
      borderRadius: BorderRadius.circular(Radii.card),
      color: t.primary.withOpacity(.1),
      minSize: 0,
      onPressed: onTap,
      child: Icon(icon, size: 20, color: t.primary),
    );
  }
}
