import 'package:flutter/painting.dart';

/// Convenience class to access application colors.
abstract class AppColors {
  /// Dark background color.
  static const Color backgroundColor = Color(0xFF191D1F);

  /// Slightly lighter version of [backgroundColor].
  static const Color backgroundFadedColor = Color(0xFF191B1C);

  /// Color used for cards and surfaces.
  static const Color cardColor = Color(0xFF1f363d);

  /// Accent color used in the application.
  static const Color accentColor = Color(0xFFef8354);

  ///AppBar color used in the application
  static const Color appBarColor = Color(0xFF3c434a);

  ///AppBackgroundColor color used in the application
  static const Color appBackgroundColor = Color(0xFF23292e);

  ///ButtonColor color used in the application
  static const Color buttonColor = Color(0xFF040bac1);
}
