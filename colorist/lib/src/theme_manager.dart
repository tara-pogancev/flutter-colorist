// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:colorist/colorist.dart';
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

  @override
  State<ThemeManager<T>> createState() => _ThemeManagerState<T>();
}

class _ThemeManagerState<T extends ColorThemeSchema>
    extends State<ThemeManager<T>> {
  late T _currentTheme;
  late ThemeBrightness _brightness;
  late ThemeManagerController<T> _controller;

  @override
  void initState() {
    super.initState();

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

    // 1. Prioritize initialTheme if provided
    if (widget.initialTheme != null) {
      _currentTheme = widget.initialTheme!;
      _brightness = (widget.initialTheme!.brightness == Brightness.light)
          ? ThemeBrightness.light
          : ThemeBrightness.dark;
      _controller = ThemeManagerController<T>._(
        currentTheme: _currentTheme,
        brightness: _brightness.dart,
        setTheme: setTheme,
        setBrightness: setBrightness,
        toggleBrightness: toggleBrightness,
        themes: widget.themes,
      );
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

      _controller = ThemeManagerController<T>._(
        currentTheme: _currentTheme,
        brightness: _brightness.dart,
        setTheme: setTheme,
        setBrightness: setBrightness,
        toggleBrightness: toggleBrightness,
        themes: widget.themes,
      );
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

    _controller = ThemeManagerController<T>._(
      currentTheme: _currentTheme,
      brightness: _brightness.dart,
      setTheme: setTheme,
      setBrightness: setBrightness,
      toggleBrightness: toggleBrightness,
      themes: widget.themes,
    );
  }

  void _updateController() {
    _controller = ThemeManagerController<T>._(
      currentTheme: _currentTheme,
      brightness: _brightness.dart,
      setTheme: setTheme,
      setBrightness: setBrightness,
      toggleBrightness: toggleBrightness,
      themes: widget.themes,
    );
  }

  void setTheme(T theme) {
    setState(() {
      _currentTheme = theme;
      _updateController();
    });
  }

  void setBrightness(ThemeBrightness brightness) {
    setState(() {
      _brightness = brightness;
      _updateController();
    });

    if (_currentTheme.themeBrightness == brightness) {
      return;
    }

    final T? targetTheme =
        widget.themes.firstWhereOrNull((t) => t.brightness == brightness.dart);

    if (targetTheme != null) {
      setTheme(targetTheme);
    }
  }

  void toggleBrightness() {
    setBrightness(
      _currentTheme.brightness == Brightness.light
          ? ThemeBrightness.dark
          : ThemeBrightness.light,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedThemeManager(
      controller: _controller,
      child: (widget.builder != null)
          ? widget.builder!(_currentTheme.themeData!)
          : widget.cupertinoBuilder!(_currentTheme.cupertinoThemeData!),
    );
  }
}

class ThemeManagerController<T extends ColorThemeSchema> {
  final T currentTheme;
  final Brightness brightness;
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
  bool updateShouldNotify(_InheritedThemeManager oldWidget) =>
      controller.currentTheme != oldWidget.controller.currentTheme ||
      controller.brightness != oldWidget.controller.brightness;
}
