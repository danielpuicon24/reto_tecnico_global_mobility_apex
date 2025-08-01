import 'dart:ui';

class AppColors {
  static const Color primary = Color(0xFFC41A3B);
  static const Color primaryColor40 = Color(0xFFF9A4B4);
  static const Color background = Color(0xFFF0F0F0);
  static const Color black = Color(0xFF000000);
  static const Color grey = Color(0xFFE5E5E5);
  static const Color medium = Color(0xFFFFC800);
  static const Color white = Color(0xFFFFFFFF);
  static const Color verifyOTP = Color(0xFFF6F6F6);
  static const Color itemNavigationBar = Color(0xFF9DB2CE);
  static const Color iconNavigationBar = Color(0xFF613EEA);
  static const Color google = Color(0xFFEA4335);
  static const Color facebook = Color(0xFF1877F2);

}
Color applyOpacity(Color color, double opacity) {
  return color.withAlpha((opacity * 255).round());
}
