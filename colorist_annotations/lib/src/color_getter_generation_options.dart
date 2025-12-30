/// Options for generating color getters for different UI frameworks ([MaterialApp] or [CupertinoApp]).
/// The getter generated for a [@ColorTheme] is for simplified access to your colors: `context.colors`.
///
/// By default, the generation is set to [ColorsGetterGeneration.auto], which will decide what getter
/// to create depending on passed getters for [themeData] and/or [cupertinoThemeData].
///
/// If you use [MaterialApp], you must ensure that your color theme class implements a non-null
/// getter for [themeData]. Also, said [ThemeData] must define an extension for your color theme class which will
/// itself be generated undecr `myTheme.extension`.
///
/// If you use [CupertinoApp], you must ensure that your color theme class implements a non-null
/// getter for [cupertinoThemeData].
enum ColorsGetterGeneration {
  /// Automatically decide what getter to generate based on implemented getters for [themeData] and/or [cupertinoThemeData].
  auto,

  /// No color palette getters will be generated, color acces will be manualy developed.
  none,

  /// Generate color getters for MaterialApp only. [ThemeData] getter MUST define extension for the color theme class, accesible via `myTheme.extension`.
  /// Generated getter for `context.colors` will return the instance of your active's theme extension for colors, with lerp and copy with methods.
  material,

  /// Generate color getters for CupertinoApp only. `contex.colors` will return the instance of your own theme class.
  cupertino,

  /// Getters for color theme will be generated for both [MaterialApp] and [CupertinoApp] usage.
  /// `context.colors` will return an instance of your own class' definition of active colors; while `context.theme.colors` will return
  /// the theme extension instance defined in your [ThemeData] (recommended, due to it's lerp functionality).
  both,
}
