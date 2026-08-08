import 'package:flutter/material.dart';
import 'package:supermarket/core/presentation/constants/ui_spaces.dart';
import 'package:supermarket/core/presentation/theme/colors.dart';
import 'package:supermarket/core/presentation/utils/generated/generated_assets/fonts.gen.dart';

final class AppTheme {
  static ThemeData themeData = ThemeData(
    primaryColor: AppColors.PRIMARY_COLOR,
    primarySwatch: AppColors.PRIMARY_SWATCH,
    scaffoldBackgroundColor: AppColors.BACKGROUND_COLOR,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.PRIMARY_COLOR),
    fontFamily: FontFamily.andale,
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.symmetric(
        horizontal: UIMetrics.sm,
        vertical: 12,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(UIMetrics.radius),
        borderSide: BorderSide(color: AppColors.BORDER_COLOR),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(UIMetrics.radius),
        borderSide: BorderSide(color: AppColors.BORDER_COLOR),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(UIMetrics.radius),
        borderSide: BorderSide(color: AppColors.BORDER_COLOR),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(UIMetrics.radius),
        borderSide: BorderSide(color: Colors.red),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(UIMetrics.radius),
      ),
      errorStyle: TextStyle(color: Colors.red),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 2,
      enableFeedback: true,
      selectedItemColor: AppColors.PRIMARY_COLOR,
      showUnselectedLabels: true,
      selectedLabelStyle: TextStyle(
        fontWeight: FontWeight.bold,
        color: AppColors.PRIMARY_COLOR,
      ),
      unselectedItemColor: Colors.black,
      unselectedLabelStyle: TextStyle(color: Colors.black),
      type: BottomNavigationBarType.fixed,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.PRIMARY_COLOR,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(UIMetrics.radius),
        ),
        padding: EdgeInsets.all(UIMetrics.sm),
        disabledBackgroundColor: Colors.grey.shade500.withValues(alpha: .4),
        disabledForegroundColor: Colors.grey.shade500,
        textStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    ),
  );
}
