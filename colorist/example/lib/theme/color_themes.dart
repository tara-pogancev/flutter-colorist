import 'package:colorist/colorist.dart';
import 'package:example/theme/cupertino_app_theme.dart';
import 'package:example/theme/material_app_theme.dart';
import 'package:flutter/material.dart';

part 'color_themes.g.dart';

@ColorTheme(name: 'Primary app theme schema', colorsGetterGeneration: ColorsGetterGeneration.auto)
abstract class AppColorTheme with _$AppColorTheme {
  const factory AppColorTheme({
    required Brightness brightness,
    required Color primary,
    required Color cardBackground,
    required Color cardGradientStart,
    required Color cardGradientEnd,
    required Color canvas,
    required Color text,
    required Color textSecondary,
    required Color textTernary,
    required Color white,
  }) = _AppColorTheme;

  @override
  ThemeData get themeData => MaterialAppTheme.getForColorTheme(this);

  @override
  CupertinoThemeData get cupertinoThemeData => CupertinoAppTheme.getForColorTheme(this);
}

final Map<String, AppColorTheme> appColorThemes = {
  'ocean': const AppColorTheme(
    brightness: Brightness.light,
    primary: Color(0xFF0277BD),
    cardBackground: Color.fromARGB(255, 215, 244, 255),
    cardGradientStart: Color.fromARGB(255, 10, 99, 84),
    cardGradientEnd: Color.fromARGB(255, 14, 84, 98),
    canvas: Color(0xFFFFFFFF),
    text: Color(0xFF0D47A1),
    textSecondary: Color.fromARGB(255, 65, 98, 205),
    textTernary: Color.fromARGB(255, 78, 160, 183),
    white: Colors.white,
  ),

  'desert': const AppColorTheme(
    brightness: Brightness.light,
    primary: Color(0xFFFF7043),
    cardBackground: Color.fromARGB(255, 255, 235, 206),
    cardGradientStart: Color.fromARGB(255, 73, 15, 9),
    cardGradientEnd: Color.fromARGB(255, 129, 23, 23),
    canvas: Color(0xFFFFFFFF),
    text: Color(0xFFBF360C),
    textSecondary: Color.fromARGB(255, 220, 88, 48),
    textTernary: Color.fromARGB(255, 226, 72, 67),
    white: Colors.white,
  ),

  'dark_forest': const AppColorTheme(
    brightness: Brightness.dark,
    primary: Color(0xFF2F5D3E),
    cardBackground: Color.fromARGB(255, 51, 84, 54),
    cardGradientStart: Color.fromARGB(255, 199, 113, 218),
    cardGradientEnd: Color.fromARGB(255, 226, 168, 233),
    canvas: Color(0xFF0F1B10),
    text: Color(0xFFEBF0E8),
    textSecondary: Color(0xFF9DBA9D),
    textTernary: Color.fromARGB(255, 231, 156, 218),
    white: Color.fromARGB(255, 66, 17, 77),
  ),
};
