import 'package:colorist/colorist.dart';

/// Schema for color themes
///
/// All color theme classes must implement this schema via generated helper mixins, as it is the starting
/// point for managing theming using [ThemeManeger].
///
/// Please deifine at least themeData getter or cupertinoThemeData getter when implementing your color theme class,
/// depending on the type of app you are building (MaterialApp or CupertinoApp).
///
/// By default, it includes:
/// - [brightness]: A [Brightness] value indicating whether the theme is light or dark.
/// - [themeData]: An optional [ThemeData] object that can be used to apply a Material theme to a Flutter app.
/// - [cupertinoThemeData]: An optional [CupertinoThemeData] object that can be used to apply a Cupertino theme to a Flutter app.
/// - [themeExtension]: A GENERATED [ThemeExtension] for adding the theme class itself as an extension.
abstract class ColorThemeSchema {
  Brightness get brightness;
  ThemeData? get themeData;
  ThemeExtension<dynamic> get themeExtension;
  CupertinoThemeData? get cupertinoThemeData;
}

extension ColorThemeSchemaX on ColorThemeSchema {
  ThemeBrightness get themeBrightness => (brightness == Brightness.light)
      ? ThemeBrightness.light
      : ThemeBrightness.dark;
}
