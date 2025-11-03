import 'package:flutter/material.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    brightness: Brightness.light,
    textTheme: TextTheme(
      // Define your text styles for light theme
      displayLarge: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
      displayMedium: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
      bodyMedium: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal),
      // Add other text styles as needed
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    textTheme: TextTheme(
      // Define your text styles for dark theme
      displayLarge: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
      displayMedium: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
      bodyMedium: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal),
      // Add other text styles as needed
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}
