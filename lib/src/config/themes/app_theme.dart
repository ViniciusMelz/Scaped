import 'package:flutter/material.dart';
import 'package:scaped/src/config/themes/theme_size.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'theme_color.dart';

enum ApplicationTheme { dark, light }

class AppTheme {
  static AppTheme? _appTheme;
  static AppTheme get instance => _appTheme ??= AppTheme._();
  static SharedPreferences? _userPrefs;

  final ValueNotifier<ApplicationTheme> _themeNotifier = ValueNotifier<ApplicationTheme>(ApplicationTheme.light);
  ThemeData _theme = _getThemeData(colorScheme: ThemeColor.lightColorScheme);
  AppTheme._() {
    SharedPreferences.getInstance().then((value) {
      _userPrefs = value;

      setTheme(_getThemeFromString());
    });
  }

  void setTheme(ApplicationTheme theme) {
    ColorScheme colorScheme;

    if (themeNotifier.value == theme) {
      return;
    }

    switch (theme) {
      case ApplicationTheme.dark:
        colorScheme = ThemeColor.darkColorScheme;
      case ApplicationTheme.light:
        colorScheme = ThemeColor.lightColorScheme;
    }

    _userPrefs?.setString('userTheme', theme.toString());
    _theme = _getThemeData(colorScheme: colorScheme);
    themeNotifier.value = theme;
  }

  static ThemeData _getThemeData({required ColorScheme colorScheme}) {
    return ThemeData(
      useMaterial3: true,
      inputDecorationTheme: const InputDecorationTheme(
        contentPadding: EdgeInsets.all(8.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
      ),
      cardTheme: CardTheme(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(ThemeSize.defaultBorderRadius)),
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      ),
      colorScheme: colorScheme,
      filledButtonTheme: const FilledButtonThemeData(
        style: ButtonStyle(
          maximumSize: MaterialStatePropertyAll(Size.infinite),
          minimumSize: MaterialStatePropertyAll(Size(double.infinity, ThemeSize.defaultButtonHeight)),
        ),
      ),
      outlinedButtonTheme: const OutlinedButtonThemeData(
        style: ButtonStyle(
          maximumSize: MaterialStatePropertyAll(Size.infinite),
          minimumSize: MaterialStatePropertyAll(Size(double.infinity, ThemeSize.defaultButtonHeight)),
        ),
      ),
    );
  }

  ThemeData get theme => _theme;
  ValueNotifier<ApplicationTheme> get themeNotifier => _themeNotifier;

  ApplicationTheme _getThemeFromString() {
    String? value = _userPrefs?.getString('userTheme');

    return switch (value) {
      "ApplicationTheme.light" => ApplicationTheme.light,
      "ApplicationTheme.dark" => ApplicationTheme.dark,
      _ => ApplicationTheme.light,
    };
  }
}
