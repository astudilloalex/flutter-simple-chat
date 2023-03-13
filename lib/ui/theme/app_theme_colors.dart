import 'package:flutter/material.dart';

/// Contains the primary colors of the app.
class AppThemeColor extends ThemeExtension<AppThemeColor> {
  /// Define the [AppThemeColor] class.
  const AppThemeColor({
    required this.primary,
    this.secondary,
  });

  /// The primary color of the app.
  final Color primary;

  /// The secondary color of the app.
  final Color? secondary;

  @override
  ThemeExtension<AppThemeColor> copyWith({
    Color? primary,
    Color? secondary,
  }) {
    return AppThemeColor(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
    );
  }

  @override
  ThemeExtension<AppThemeColor> lerp(
    ThemeExtension<AppThemeColor>? other,
    double t,
  ) {
    if (other is! AppThemeColor) return this;
    return AppThemeColor(
      primary: Color.lerp(primary, other.primary, t) ?? primary,
      secondary: Color.lerp(secondary, other.secondary, t),
    );
  }
}
