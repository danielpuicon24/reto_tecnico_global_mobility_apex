import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppThemes {
  static final _appBarTheme = AppBarTheme(
    color: Colors.white,
    elevation: 0,
    toolbarTextStyle: GoogleFonts.workSans(
      color: Colors.grey.shade800,
      fontSize: 26,
      fontWeight: FontWeight.w600,
    ),
  );

  static final _textTheme = GoogleFonts.workSansTextTheme().copyWith(
    titleMedium: GoogleFonts.workSans(
      color: AppColors.black,
      fontWeight: FontWeight.w600,
      fontSize: 15,
    ),

    displayLarge: GoogleFonts.workSans(
      fontSize: 13,
      fontWeight: FontWeight.w500,
      color: AppColors.black,
    ),
    displayMedium: GoogleFonts.workSans(
      fontSize: 15,
      fontWeight: FontWeight.w600,
    ),
    displaySmall: GoogleFonts.workSans(
      fontSize: 23,
      color: AppColors.black,
      fontWeight: FontWeight.w700,
    ),
    headlineLarge: GoogleFonts.workSans(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: AppColors.black,
    ),
    headlineMedium: GoogleFonts.workSans(
      fontSize: 18,
      color: Colors.black,
      fontWeight: FontWeight.w700,
    ),
    headlineSmall: GoogleFonts.workSans(
      fontSize: 14,
      color: Colors.black,
      fontWeight: FontWeight.w500,
    ),
  );

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.white,
      primaryColor: AppColors.primary,
      secondaryHeaderColor: AppColors.primaryColor40,
      cardColor: AppColors.grey,
      appBarTheme: _appBarTheme,
      textTheme: _textTheme,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        onPrimary: Colors.white,
        onSurface: Colors.black,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: AppColors.primary),
      ),
      timePickerTheme: const TimePickerThemeData(
        dialHandColor: AppColors.primary,
        dialBackgroundColor: Colors.white,
        hourMinuteTextColor: Colors.black,
        dayPeriodColor: AppColors.primary,
        dayPeriodTextColor: Colors.black,
        hourMinuteTextStyle: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          height: 2,
          color: Colors.black,
        ),
        hourMinuteShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          side: BorderSide(color: AppColors.primary),
        ),
      ),
    );
  }
}
