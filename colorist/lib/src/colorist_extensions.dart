import 'package:colorist/colorist.dart';
import 'package:flutter/material.dart';

extension ContextThemeX on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;

  ThemeManagerController get themeManager => ThemeManager.of(this);

  /// Returns true if the current theme brightness is dark mode. If the
  /// brightness is set to system, it checks the actual platform brightness,
  /// and returns true if that is dark mode.
  bool get isDarkMode {
    return themeManager.brightness.dart == Brightness.dark;
  }
}
