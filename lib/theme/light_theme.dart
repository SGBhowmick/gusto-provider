import 'package:flutter/material.dart';
import 'custom_theme_colors.dart';

ThemeData light = ThemeData(
  fontFamily: 'Roboto',
  // Updated to Dusto Green
  primaryColor: const Color(0xFF07B89C),

  primaryColorLight: const Color(0xFF3E9665),
  primaryColorDark: const Color(0xFF007A36),

  scaffoldBackgroundColor: const Color(0xFFF7F9FC),
  cardColor: const Color(0xFFFFFFFF),
  shadowColor: const Color(0xFFD1D5DB),
  canvasColor: const Color(0xFFFFFFFF),
  secondaryHeaderColor: const Color(0xFF8797AB),
  disabledColor: const Color(0xFF9E9E9E),
  brightness: Brightness.light,
  hintColor: const Color(0xFF838383),
  focusColor: const Color(0xFFFEFEFE),
  hoverColor: const Color(0xFFE8F5E9), // Soft green hover

  extensions: <ThemeExtension<CustomThemeColors>>[CustomThemeColors.light()],

  colorScheme: const ColorScheme.light(
    primary: const Color(0xFF07B89C),

    secondary: Color(0xFF3E9665), // Muted green
    tertiary: Color(0xffF58F2A), // Keeping your accent orange
    onTertiary: Color(0xFFffda6d),
    onSecondaryContainer: Color(0xFF3E9665),
    surface: Color(0xFFF7F9FC),
    error: Color(0xFFFF6767),
  ),

  timePickerTheme: const TimePickerThemeData(
    hourMinuteTextColor: Color(0xFF10324a),
  ),
  dividerTheme: const DividerThemeData(thickness: 0.5),
);
