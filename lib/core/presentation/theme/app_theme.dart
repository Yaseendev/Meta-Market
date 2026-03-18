import 'package:flutter/material.dart';
import 'package:supermarket/core/presentation/theme/colors.dart';

final class AppTheme {
  static ThemeData themeData = ThemeData(
    primaryColor: AppColors.PRIMARY_COLOR,
    primarySwatch: AppColors.PRIMARY_SWATCH,
    scaffoldBackgroundColor: AppColors.BACKGROUND_COLOR,
  );
}