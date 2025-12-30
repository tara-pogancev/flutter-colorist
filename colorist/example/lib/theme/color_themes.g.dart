// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// coverage:ignore-file
// ignore_for_file: type=lint

part of 'color_themes.dart';

// **************************************************************************
// ColoristThemeGenerator
// **************************************************************************

// **************************************************************************
// AppColorTheme implementation
// **************************************************************************

/// @nodoc
@immutable
mixin _$AppColorTheme implements ColorThemeSchema {
  // Custom theme colors
  Color get canvas;
  Color get cardBackground;
  Color get cardGradientEnd;
  Color get cardGradientStart;
  Color get primary;
  Color get text;
  Color get textSecondary;
  Color get textTernary;
  Color get white;
}

/// @nodoc
@immutable
class _AppColorTheme implements AppColorTheme {
  @override
  final Color canvas;
  @override
  final Color cardBackground;
  @override
  final Color cardGradientEnd;
  @override
  final Color cardGradientStart;
  @override
  final Color primary;
  @override
  final Color text;
  @override
  final Color textSecondary;
  @override
  final Color textTernary;
  @override
  final Color white;

  const _AppColorTheme({
    required this.brightness,
    required this.canvas,
    required this.cardBackground,
    required this.cardGradientEnd,
    required this.cardGradientStart,
    required this.primary,
    required this.text,
    required this.textSecondary,
    required this.textTernary,
    required this.white,
  });

  @override
  final Brightness brightness;

  @override
  ThemeExtension get themeExtension => AppColorThemeExtension(
    canvas: canvas,
    cardBackground: cardBackground,
    cardGradientEnd: cardGradientEnd,
    cardGradientStart: cardGradientStart,
    primary: primary,
    text: text,
    textSecondary: textSecondary,
    textTernary: textTernary,
    white: white,
  );

  ThemeData get themeData => MaterialAppTheme.getForColorTheme(this);

  CupertinoThemeData get cupertinoThemeData =>
      CupertinoAppTheme.getForColorTheme(this);
}

// **************************************************************************
// ThemeExtension adapter for Material integration
// **************************************************************************

@immutable
class AppColorThemeExtension extends ThemeExtension<AppColorThemeExtension> {
  // Custom theme colors
  final Color canvas;
  final Color cardBackground;
  final Color cardGradientEnd;
  final Color cardGradientStart;
  final Color primary;
  final Color text;
  final Color textSecondary;
  final Color textTernary;
  final Color white;

  const AppColorThemeExtension({
    required this.canvas,
    required this.cardBackground,
    required this.cardGradientEnd,
    required this.cardGradientStart,
    required this.primary,
    required this.text,
    required this.textSecondary,
    required this.textTernary,
    required this.white,
  });

  @override
  AppColorThemeExtension copyWith({AppColorTheme? data}) =>
      AppColorThemeExtension(
        canvas: data?.canvas ?? canvas,
        cardBackground: data?.cardBackground ?? cardBackground,
        cardGradientEnd: data?.cardGradientEnd ?? cardGradientEnd,
        cardGradientStart: data?.cardGradientStart ?? cardGradientStart,
        primary: data?.primary ?? primary,
        text: data?.text ?? text,
        textSecondary: data?.textSecondary ?? textSecondary,
        textTernary: data?.textTernary ?? textTernary,
        white: data?.white ?? white,
      );

  @override
  AppColorThemeExtension lerp(
    covariant ThemeExtension<AppColorThemeExtension>? other,
    double t,
  ) {
    if (other is! AppColorThemeExtension) {
      return this;
    }
    return AppColorThemeExtension(
      canvas: Color.lerp(canvas, other.canvas, t)!,
      cardBackground: Color.lerp(cardBackground, other.cardBackground, t)!,
      cardGradientEnd: Color.lerp(cardGradientEnd, other.cardGradientEnd, t)!,
      cardGradientStart: Color.lerp(
        cardGradientStart,
        other.cardGradientStart,
        t,
      )!,
      primary: Color.lerp(primary, other.primary, t)!,
      text: Color.lerp(text, other.text, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textTernary: Color.lerp(textTernary, other.textTernary, t)!,
      white: Color.lerp(white, other.white, t)!,
    );
  }
}

// **************************************************************************
// Context extension for color access
// Use 'context.colors' to access active colors defined in AppColorTheme
// **************************************************************************

extension AppColorThemeBuildContextX on BuildContext {
  AppColorThemeExtension get colors =>
      Theme.of(this).extension<AppColorThemeExtension>()
          as AppColorThemeExtension;

  AppColorThemeExtension get cupertinoColors =>
      this.themeManager.currentTheme.themeExtension as AppColorThemeExtension;
}
