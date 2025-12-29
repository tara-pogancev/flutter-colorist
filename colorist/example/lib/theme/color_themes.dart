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
    cardBackground: Color(0xFFD7F4FF),
    cardGradientStart: Color(0xFF0A6354),
    cardGradientEnd: Color(0xFF0E5462),
    canvas: Color(0xFFFFFFFF),
    text: Color(0xFF0D47A1),
    textSecondary: Color(0xFF4162CD),
    textTernary: Color(0xFF4EA0B7),
    white: Colors.white,
  ),

  'desert': const AppColorTheme(
    brightness: Brightness.light,
    primary: Color(0xFFFF7043),
    cardBackground: Color(0xFFFFEBCE),
    cardGradientStart: Color(0xFF490F09),
    cardGradientEnd: Color(0xFF811717),
    canvas: Color(0xFFFFFFFF),
    text: Color(0xFFBF360C),
    textSecondary: Color(0xFFDC5830),
    textTernary: Color(0xFFE24843),
    white: Colors.white,
  ),

  'dark_forest': const AppColorTheme(
    brightness: Brightness.dark,
    primary: Color(0xFF2F5D3E),
    cardBackground: Color(0xFF335436),
    cardGradientStart: Color(0xFFC771DA),
    cardGradientEnd: Color(0xFFE2A8E9),
    canvas: Color(0xFF0F1B10),
    text: Color(0xFFEBF0E8),
    textSecondary: Color(0xFF9DBA9D),
    textTernary: Color(0xFFE79CDA),
    white: Color(0xFF42114D),
  ),
};
