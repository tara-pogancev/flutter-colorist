import 'package:colorist_annotations/src/color_getter_generation_options.dart';
import 'package:meta/meta.dart';

/// Use on abstract classes that implement a color theme schema.
/// Annotations are used to generate the implementation code for the color theme class.
/// When implementing your class, you must add getter override for either `themeData` or `cupertinoThemeData`.
/// You could also implement both if you wish to support both Material and Cupertino theming in your app.
/// Example:
/// ```dart
/// @ColorTheme(name: 'main', description: 'Main application color theme', colorsGetterGeneration: ColorsGetterGeneration.auto)
/// abstract class AppColorTheme with _$AppColorTheme {
///  const factory AppColorTheme({
///    required Brightness brightness,
///    required Color firstColor,
///    required Color secondColor,
///    // more colors...
///  }) = _AppColorTheme;
///
///  @override
///  ThemeData? get themeData => MaterialAppTheme.getForColorTheme(this);
///
///  @override
///  CupertinoThemeData? get cupertinoThemeData => CupertinoAppTheme.getForColorTheme(this);
///}
/// ```
@immutable
class ColorTheme {
  /// Optional name for this palette (defaults the extended class name if none is provided).
  final String? name;

  /// Optional description of the pallete's documentation and use
  final String? description;

  /// Optional preference for generating color getters for different UI frameworks ([MaterialApp] or [CupertinoApp]).
  /// The getter generated for a [@ColorTheme] is for simplified access to your colors: `context.colors`.
  ///
  /// By default, the generation is set to [ColorsGetterGeneration.auto], which will decide what getter
  /// to create depending on passed getters for [themeData] and/or [cupertinoThemeData].
  final ColorsGetterGeneration colorsGetterGeneration;

  const ColorTheme({
    this.name,
    this.description,
    this.colorsGetterGeneration = ColorsGetterGeneration.auto,
  });
}
