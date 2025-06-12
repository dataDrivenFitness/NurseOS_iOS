import 'package:flutter/material.dart';
import 'package:nurse_os/screens/vitals_history_screen.dart';
import 'package:nurse_os/screens/vitals_chart_screen.dart';

/// VitalsActionButtons
///
/// A lightweight, pill-style action row used in the Vitals section. This layout:
/// - Matches the visual style of patient tags (e.g. “no latex”)
/// - Uses icons and text together
/// - Adapts to light/dark mode
/// - Is fully driven by layout constants for consistent theming
class VitalsActionButtons extends StatelessWidget {
  final String patientId;
  final VoidCallback onViewGraph;

  const VitalsActionButtons({
    super.key,
    required this.patientId,
    required this.onViewGraph,
  });

  // 🔧 Layout + styling constants (easily tweakable)
  static const double fontSize = 14;
  static const double iconSize = 18;
  static const double buttonHeight = 38;
  static const double spacing = 10;

  static const EdgeInsetsGeometry buttonPadding =
      EdgeInsets.symmetric(horizontal: 16, vertical: 8);

  static const BorderRadius borderRadius = BorderRadius.all(Radius.circular(999));

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // 🎨 Adaptive colors
    final Color textColor = isDark ? Colors.white : Colors.black;
    final Color borderColor = isDark ? Colors.white54 : Colors.black26;

    return Padding(
      padding: const EdgeInsets.only(top: 12.0, bottom: 8.0),
      child: Center(
        child: Wrap(
          spacing: spacing,
          alignment: WrapAlignment.center,
          children: [
            // 🕓 History Button
            _TagButton(
              label: "History",
              icon: Icons.history,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => VitalsHistoryScreen(patientId: patientId),
                  ),
                );
              },
              textColor: textColor,
              borderColor: borderColor,
            ),

            // 📊 Graph Button
            _TagButton(
              label: "Graph",
              icon: Icons.show_chart,
              onTap: onViewGraph,
              textColor: textColor,
              borderColor: borderColor,
            ),
          ],
        ),
      ),
    );
  }
}

/// _TagButton
///
/// A helper widget for a single button with:
/// - Rounded outline
/// - Icon + label horizontally
/// - Compact tag-style appearance
class _TagButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final Color textColor;
  final Color borderColor;

  const _TagButton({
    required this.label,
    required this.icon,
    required this.onTap,
    required this.textColor,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: VitalsActionButtons.buttonHeight,
        padding: VitalsActionButtons.buttonPadding,
        decoration: BoxDecoration(
          borderRadius: VitalsActionButtons.borderRadius,
          border: Border.all(color: borderColor),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: VitalsActionButtons.iconSize, color: textColor),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: VitalsActionButtons.fontSize,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
