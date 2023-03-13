import 'package:flutter/material.dart';
import 'package:simple_chat/ui/theme/app_theme_colors.dart';
import 'package:simple_chat/ui/theme/color.dart';

class AppThemeData {
  const AppThemeData._();

  static ThemeData get dark {
    return ThemeData.dark().copyWith();
  }

  static ThemeData get light {
    const AppThemeColor color = AppThemeColor(
      primary: LightColor.primary,
      secondary: LightColor.secondary,
    );
    return ThemeData.light().copyWith(
      primaryColor: color.primary,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: color.primary,
        ),
      ),
      extensions: <ThemeExtension<dynamic>>[color],
    );
  }
}
