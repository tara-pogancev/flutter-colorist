import 'package:collection/collection.dart';
import 'package:colorist/colorist.dart';
import 'package:colorist/src/colorist_preferences/colorist_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeManager<T extends ColorThemeSchema> extends StatefulWidget {
  const ThemeManager(
      {super.key,
      required this.themes,
      this.builder,
      this.cupertinoBuilder,
      this.initialTheme,
      this.initialBrightness});

  final Widget Function(ThemeData curentTheme)? builder;
  final Widget Function(CupertinoThemeData curentTheme)? cupertinoBuilder;
  final List<T> themes;
  final T? initialTheme;
  final ThemeBrightness? initialBrightness;

  static ThemeManagerController of(BuildContext context) {
    final inherited =
        context.dependOnInheritedWidgetOfExactType<_InheritedThemeManager>();
    assert(inherited != null, 'No ThemeManager found in context');
    return inherited!.controller;
  }

  static Future<void> init() async {
    await ColoristPreferences.init();
  }

  @override
  State<ThemeManager<T>> createState() => _ThemeManagerState<T>();
}

class _ThemeManagerState<T extends ColorThemeSchema>
    extends State<ThemeManager<T>> {
  late T _currentTheme;
  late ThemeBrightness _brightness;

  late final ColoristPreferences _preferences;

  @override
  void initState() {
    super.initState();

    // Initial checks regarding root widget configuration
    if (widget.themes.isEmpty) {
      throw Exception('ThemeManager requires at least one theme');
    }

    if (widget.cupertinoBuilder != null && widget.builder != null) {
      throw Exception(
          'ThemeManager cannot have both builder and cupertinoBuilder defined. Please define either a builder (for MaterialApp) or a cupertinoBuilder (for CupertinoApp).');
    }

    if (widget.cupertinoBuilder == null && widget.builder == null) {
      throw Exception(
          'ThemeManager requires either a builder (for MaterialApp) or a cupertinoBuilder (for CupertinoApp).');
    }

    _currentTheme = widget.themes.first;
    _brightness = ThemeBrightness.system;

    setupThemeManager();
  }

  void setupThemeManager() {
    _preferences = ColoristPreferences.instance;

    // 0. Consider saved preferences first
    final savedBrightness = _preferences.getSavedBrightness();
    final savedThemeIndex = _preferences.getSavedThemeIndex();

    // Both preferences are successfully saved, and we can restore them
    if (savedThemeIndex != null && savedBrightness != null) {
      T? targetTheme;
      if (savedThemeIndex >= 0 && savedThemeIndex < widget.themes.length) {
        targetTheme = widget.themes.elementAtOrNull(savedThemeIndex);
      }
      if (targetTheme != null) {
        _currentTheme = targetTheme;
        _brightness = savedBrightness;
      } else {
        final T? targetTheme = widget.themes
            .firstWhereOrNull((t) => t.brightness == _brightness.dart);

        // We can match with the saved brightness
        if (targetTheme != null) {
          _currentTheme = targetTheme;
          _brightness = savedBrightness;
        } else {
          _currentTheme = widget.themes.first;
          _brightness = _currentTheme.themeBrightness;
        }
      }

      _syncPreferencesAndRebuild();
      return;
    }

    // No preferences were stored, this is likely app's first run, fallback to widget settings

    // 1. Prioritize initialTheme if provided
    if (widget.initialTheme != null) {
      _currentTheme = widget.initialTheme!;
      _brightness = (widget.initialTheme!.brightness == Brightness.light)
          ? ThemeBrightness.light
          : ThemeBrightness.dark;
      _syncPreferencesAndRebuild();
      return;
    }

    // 2. Prioritize initialBrightness if provided
    if (widget.initialBrightness != null) {
      _brightness = widget.initialBrightness!;

      final T? targetTheme = widget.themes.firstWhereOrNull(
          (t) => t.brightness == widget.initialBrightness!.dart);

      if (targetTheme != null) {
        _currentTheme = targetTheme;
      } else {
        _currentTheme = widget.themes.first;
      }

      _syncPreferencesAndRebuild();
      return;
    }

    final T? targetTheme = widget.themes
        .firstWhereOrNull((t) => t.brightness == ThemeBrightness.system.dart);

    if (targetTheme != null) {
      // 3. If brightness system has a match, use first matching theme
      _currentTheme = targetTheme;
    } else {
      // 4. If brightness system has no match, use first theme in list
      _currentTheme = widget.themes.first;
    }

    _brightness = _currentTheme.themeBrightness;

    // Rebuild the widget upon completing setup
    _syncPreferencesAndRebuild();
    return;
  }

  /// Set app's current theme. This will also override current brightness to match the theme's brightness.
  /// Even if app's brightness is set to system, the theme's brightness will be applied.
  /// If your app only supports light and dark theme, consider using [setBrightness], or [toggleBrightness] instead.
  /// This function is more useful if you have multiple themes with various brightness settings, where the theme colors
  /// are more important than the brightness setting. You may also implement a custom brightness toggle logic in this case.
  void setTheme(T theme) {
    setState(() {
      _currentTheme = theme;
      _brightness = theme.themeBrightness;
    });

    _syncPreferences();
  }

  /// Set app's current brightness settings. If possible, first available theme matching desired brightness will be applied.
  /// System brightness will prioritise device's settings.
  void setBrightness(ThemeBrightness brightness) {
    setState(() {
      _brightness = brightness;
    });

    if (_currentTheme.brightness == brightness.dart) {
      _syncPreferences();
      return;
    }

    final T? targetTheme = widget.themes
        .firstWhereOrNull((theme) => theme.brightness == brightness.dart);

    if (targetTheme != null) {
      setState(() {
        _currentTheme = targetTheme;
      });
    }

    _syncPreferences();
  }

  /// Toggle between [Brightness.light] and [Brightness.dark] theme mode.
  /// If possible, first available theme matching desired brightness will be applied.
  void toggleBrightness() {
    setBrightness(
      _currentTheme.brightness == Brightness.light
          ? ThemeBrightness.dark
          : ThemeBrightness.light,
    );
  }

  void _syncPreferences() {
    _preferences.saveBrightness(_brightness);
    _preferences.saveTheme(_currentTheme, widget.themes);
  }

  void _syncPreferencesAndRebuild() {
    _syncPreferences();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final controller = ThemeManagerController<T>._(
      currentTheme: _currentTheme,
      brightness: _brightness,
      setTheme: setTheme,
      setBrightness: setBrightness,
      toggleBrightness: toggleBrightness,
      themes: widget.themes,
    );

    return _InheritedThemeManager(
      controller: controller,
      child: (widget.builder != null)
          ? widget.builder!(_currentTheme.themeData!)
          : widget.cupertinoBuilder!(_currentTheme.cupertinoThemeData!),
    );
  }
}

class ThemeManagerController<T extends ColorThemeSchema> {
  final T currentTheme;
  final ThemeBrightness brightness;
  final List<T> themes;
  final void Function(T) setTheme;
  final void Function(ThemeBrightness) setBrightness;
  final VoidCallback toggleBrightness;

  const ThemeManagerController._({
    required this.currentTheme,
    required this.brightness,
    required this.themes,
    required this.setTheme,
    required this.setBrightness,
    required this.toggleBrightness,
  });
}

class _InheritedThemeManager extends InheritedWidget {
  final ThemeManagerController controller;

  const _InheritedThemeManager({
    required this.controller,
    required super.child,
  });

  @override
  bool updateShouldNotify(_InheritedThemeManager oldWidget) {
    return controller.currentTheme != oldWidget.controller.currentTheme ||
        controller.brightness != oldWidget.controller.brightness;
  }
}
