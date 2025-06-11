import 'package:flutter/material.dart';

/// Constants for fallback styling
const double kAvatarFontSizeFactor = 0.70;

/// Returns a theme-aware background color for fallback avatar
Color avatarBackgroundColor(BuildContext context) {
  return Theme.of(context).brightness == Brightness.dark
      ? Colors.grey.shade700
      : Colors.blueGrey.shade100;
}

/// Returns a theme-aware text color for fallback initials
Color avatarTextColor(BuildContext context) {
  return Theme.of(context).brightness == Brightness.dark
      ? Colors.white
      : Colors.black87;
}

/// Helper widget to display user or patient profile photo with fallback initials.
/// Adapts to light/dark mode.
Widget buildProfileAvatar({
  required BuildContext context,
  required String? imageUrl,
  required String fullName,
  double radius = 40,
  TextStyle? initialsStyle,
}) {
  final initials = fullName
      .trim()
      .split(' ')
      .where((e) => e.isNotEmpty)
      .map((e) => e[0])
      .take(2)
      .join()
      .toUpperCase();

  if (imageUrl != null && imageUrl.isNotEmpty) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: NetworkImage(imageUrl),
    );
  } else {
    return CircleAvatar(
      radius: radius,
      backgroundColor: avatarBackgroundColor(context),
      child: Text(
        initials,
        style: initialsStyle ??
            TextStyle(
              fontSize: radius * kAvatarFontSizeFactor,
              fontWeight: FontWeight.w600,
              color: avatarTextColor(context),
              letterSpacing: 1.2,
            ),
      ),
    );
  }
}
