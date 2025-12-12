import 'package:flutter/widgets.dart';

/// Brightness options for themes.
enum ThemeBrightness {
  /// Light theme mode, prioritizing a light background and darker text.
  light,

  /// Dark theme mode, prioritizing a dark background and lighter text. Typically uses less energy, and is easier on the eyes in low-light environments.
  dark,

  /// System theme mode, which follows the device's system-wide brightness setting.
  system
}

extension ThemeBrightnessX on ThemeBrightness {
  /// Converts [ThemeBrightness] to Flutter's built-in [Brightness].
  Brightness get dart {
    switch (this) {
      case ThemeBrightness.light:
        return Brightness.light;
      case ThemeBrightness.dark:
        return Brightness.dark;
      case ThemeBrightness.system:
        return WidgetsBinding.instance.platformDispatcher.platformBrightness;
    }
  }
}
