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
      contentPadding:
          EdgeInsets.symmetric(horizontal: UISpaces.sm, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(UISpaces.radius),
        borderSide: BorderSide(color: AppColors.BORDER_COLOR),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(UISpaces.radius),
        borderSide: BorderSide(color: AppColors.BORDER_COLOR),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(UISpaces.radius),
        borderSide: BorderSide(color: AppColors.BORDER_COLOR),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(UISpaces.radius),
        borderSide: BorderSide(color: Colors.red),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(UISpaces.radius),
      ),
      errorStyle: TextStyle(color: Colors.red),
    ),
  );
}
