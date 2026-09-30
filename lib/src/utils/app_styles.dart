import 'package:flutter/material.dart';

class AppStyles {
  // Colors
  static const Color primaryColor = Color(0xFF1976D2);       // Blue
  static const Color accentColor = Color(0xFFFFC107);        // Amber
  static const Color backgroundColor = Color(0xFFF5F5F5);    // Light grey
  static const Color successColor = Color(0xFF4CAF50);       // Green
  static const Color errorColor = Color(0xFFF44336);         // Red
  static const Color textColor = Color(0xFF212121);          // Dark grey
  static const Color scaffoldColor = Color(0xFFF5F5F5); // Add your desired scaffold background color here
  // Add other style constants here

  // Padding
  static const EdgeInsets screenPadding = EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0);

  // Text Styles
  static const TextStyle titleText = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: AppStyles.textColor,
  );

  static const TextStyle subtitleText = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppStyles.textColor,
  );

  static const TextStyle bodyText = TextStyle(
    fontSize: 16,
    color: AppStyles.textColor,
  );

  static const TextStyle buttonText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static ButtonStyle primaryButton = ElevatedButton.styleFrom(
    backgroundColor: primaryColor,
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  );
}
