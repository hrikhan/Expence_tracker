import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'custom_themes/app_bar_theme.dart';
import 'custom_themes/elevated_button_theme.dart';
import 'custom_themes/text_field_theme.dart';
import 'custom_themes/text_theme.dart';


class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: const Color(0xFF231C18),
      scaffoldBackgroundColor: const Color(0xFFFAF8F6),
      textTheme: GoogleFonts.interTextTheme(AppTextTheme.lightTextTheme),
      elevatedButtonTheme: AppElevatedButtonTheme.lightElevatedButtonTheme,
      appBarTheme: App_BarTheme.lightAppBarTheme,
      inputDecorationTheme: AppTextFormFieldTheme.lightInputDecorationTheme);

  static ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: const Color(0xFF231C18),
      scaffoldBackgroundColor: const Color(0xFF121212),
      textTheme: GoogleFonts.interTextTheme(AppTextTheme.darkTextTheme),
      elevatedButtonTheme: AppElevatedButtonTheme.darkElevatedButtonTheme,
      appBarTheme: App_BarTheme.darkAppBarTheme,
      inputDecorationTheme: AppTextFormFieldTheme.darkInputDecorationTheme);
}
