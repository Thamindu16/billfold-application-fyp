import 'package:flutter/material.dart';

class AppTheme {
  // Define application primary and secondary colors (Professional Finance Theme)
  static const Color primaryColor = Color(0xFF1E3A8A); // Deep Blue
  static const Color accentColor = Color(
    0xFF10B981,
  ); // Emerald Green for finance/growth
  static const Color backgroundColor = Color(
    0xFFF9FAFB,
  ); // Light Gray/White background
  static const Color surfaceColor = Colors.white;
  static const Color textPrimary = Color(
    0xFF1F2937,
  ); // Dark Charcoal for readability

  // Define the light theme data for the application
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      useMaterial3: true,
      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        secondary: accentColor,
        surface: surfaceColor,
      ),
      // Styling for all input fields (TextFields) in the app
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryColor, width: 2),
        ),
      ),
      // Styling for elevated buttons across the app
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}
