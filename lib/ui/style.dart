/// Nurse OS design tokens + theme extension
///
/// Every widget should import these tokens instead of hard-coding
/// colours, spacing, or radii.  See Guidelines §3.
library style;

import 'package:flutter/material.dart';

/// Spacing scale (4-pt grid)
class Spacing {
  static const xs = 4.0;
  static const sm = 8.0;
  static const md = 12.0;
  static const lg = 16.0;
  static const xl = 24.0;
}

/// Border-radius tokens
class Radii {
  static const pill = 50.0;
  static const card = 12.0;
  static const avatar = 40.0;
}

/// App-wide colour bundle (light + dark) exposed via ThemeExtension
@immutable
class AppTheme extends ThemeExtension<AppTheme> {
  final Color primary, secondary, surface, background, divider, error;

  const AppTheme({
    required this.primary,
    required this.secondary,
    required this.surface,
    required this.background,
    required this.divider,
    required this.error,
  });

  /* ---------- preset factories ---------- */
  static const light = AppTheme(
    primary: Color(0xFF007AFF),
    secondary: Color(0xFF32D74B),
    surface: Color(0xFFF7F9FA),
    background: Color(0xFFFFFFFF),
    divider: Color(0xFFE0E3E7),
    error: Color(0xFFFF3B30),
  );

  static const dark = AppTheme(
    primary: Color(0xFF0A84FF),
    secondary: Color(0xFF30D158),
    surface: Color(0xFF1E1E1F),
    background: Color(0xFF121212),
    divider: Color(0xFF2C2C2E),
    error: Color(0xFFFF453A),
  );

  /* ---------- mandatory overrides ---------- */
  @override
  AppTheme copyWith({
    Color? primary,
    Color? secondary,
    Color? surface,
    Color? background,
    Color? divider,
    Color? error,
  }) =>
      AppTheme(
        primary: primary ?? this.primary,
        secondary: secondary ?? this.secondary,
        surface: surface ?? this.surface,
        background: background ?? this.background,
        divider: divider ?? this.divider,
        error: error ?? this.error,
      );

  @override
  AppTheme lerp(covariant ThemeExtension<AppTheme>? other, double t) {
    if (other is! AppTheme) return this;
    return AppTheme(
      primary: Color.lerp(primary, other.primary, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      background: Color.lerp(background, other.background, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
      error: Color.lerp(error, other.error, t)!,
    );
  }
}
