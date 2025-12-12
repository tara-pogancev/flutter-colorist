import 'package:colorist/colorist.dart';
import 'package:example/theme/color_themes.dart';
import 'package:example/ui/demo_cupertino_home_page.dart';
import 'package:example/ui/demo_home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  /// Change this flag to switch between MaterialApp and CupertinoApp example
  final bool isMaterialApp = true;

  @override
  Widget build(BuildContext context) {
    /// Wrap your [MaterialApp]/[CupertinoApp] widget with [ThemeManager], passing your color schema as type parameter
    /// Here, you provide available themes, and an optional initial theme or [Brightness].
    /// If no initial theme is provided, the first theme in the list will be used.
    return (isMaterialApp)
        /// MATERIAL APP EXAMPLE
        ? ThemeManager<AppColorTheme>(
            themes: appColorThemes.values.toList(),
            initialTheme: appColorThemes['ocean'],
            initialBrightness: ThemeBrightness.system,
            builder: (currentTheme) {
              /// Your [MaterialApp] widget should use the [ThemeData] `currentTheme` provided by [ThemeManager]'s builder
              /// Colors are made accesible via extensions on BuildContext -> `context.colors`
              return MaterialApp(
                title: 'Colorist Demo',
                theme: currentTheme,
                home: const DemoHomePage(),
              );
            },
          )
        /// CUPERTINO APP EXAMPLE
        : ThemeManager<AppColorTheme>(
            themes: appColorThemes.values.toList(),
            initialTheme: appColorThemes['ocean'],
            initialBrightness: ThemeBrightness.system,
            cupertinoBuilder: (curentTheme) {
              /// CupertinoApp widget should use [CupertinoThemeData] `curentTheme` provided by [ThemeManager]'s cupertinoBuilder
              /// Colors are made eccesible via extensions on BuildContext -> `context.colors`
              /// In a special case where you provide both ThemeData and CupertinoThemeData, cupertino colors are accessible via `context.cupertinoColors`
              return CupertinoApp(
                title: 'Colorist Demo',
                theme: curentTheme,
                home: const DemoCupertinoHomePage(),
              );
            },
          );

    /// Note: Your [ThemeManager] will support either a `builder` or a `cupertinoBuilder`. You cannot define both at the same time.
    /// You also must provide at least one of them, otherwise, an exception will be thrown.
  }
}
