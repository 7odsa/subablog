import 'package:flutter/material.dart';
import 'package:subablog/core/theme/app_colors.dart';

sealed class AppTheme {
  static OutlineInputBorder _border([Color color = AppColors.borderColor]) =>
      OutlineInputBorder(
        borderSide: BorderSide(color: color, width: 3),
        borderRadius: BorderRadius.circular(10),
      );

  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppColors.backgroundColor,
    appBarTheme: AppBarTheme(backgroundColor: AppColors.backgroundColor),
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: _border(),
      focusedBorder: _border(AppColors.gradient2),
      errorBorder: _border(AppColors.errorColor),
      contentPadding: EdgeInsets.all(28),
    ),
  );
}
