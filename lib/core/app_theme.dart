import 'package:flutter/material.dart';

class AppTheme {
  // --- Primary Colors ---
  static const Color primary = Color(0xFF1E88E5); // Blue 600 - Main Branding
  static const Color accent = Color(0xFFFFC107); // Amber - Secondary Highlight
  static const Color background = Color(0xFFF0F2F5); // Very Light Gray - Clean background

  // --- Status/Indicator Colors (Aligned with Machine Status) ---
  static const Color statusRunning = Color(0xFF43A047); // Green
  static const Color statusIdle = Color(0xFFFFA726); // Orange
  static const Color statusDown = Color(0xFFE53935); // Red
  static const Color statusMaintenance = Color(0xFF546E7A); // Blue Grey

  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: primary,
      scaffoldBackgroundColor: background,
      
      // Application Bar Theme
      appBarTheme: const AppBarTheme(
        color: primary,
        elevation: 0,
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      
      // Card Theme
      cardTheme: CardThemeData(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      
      // Button Theme
      buttonTheme: const ButtonThemeData(
        buttonColor: primary,
        textTheme: ButtonTextTheme.primary,
      ),
      
      // Text Theme
      textTheme: const TextTheme(
        titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87), // Main Screen Title
        titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black87), // Card Title
        bodyMedium: TextStyle(fontSize: 14, color: Colors.black54), // Standard text
      ),
      
      useMaterial3: true,
    );
  }
}// TODO Implement this library.