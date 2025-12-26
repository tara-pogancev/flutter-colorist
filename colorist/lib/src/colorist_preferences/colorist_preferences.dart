import 'package:colorist/colorist.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _brightnessIndexKey = 'colorist_theme_brightness_index';
const String _themeIndexKey = 'colorist_selected_theme_index';

/// Helper class for persisting user's preferences related to Colorist's ThemeManager.
/// Persisted settings are [ThemeBrightness] and selected [ColorThemeSchema].
/// Persistence is handled using the `shared_preferences` package, and will override initial settings provided
/// with [ThemeManager] root widget if available.
class ColoristPreferences {
  static late SharedPreferences _preferences;
  static bool _initialized = false;

  static final ColoristPreferences _instance = ColoristPreferences._();
  ColoristPreferences._();

  static Future<void> init() async {
    if (!_initialized) {
      _preferences = await SharedPreferences.getInstance();
      _initialized = true;
    }
  }

  /// Getter for ColoristPreferences, ensuring initialization has occurred.
  /// Do not use this unless you are certain that [ColoristPreferences.init] has been called.
  static ColoristPreferences get instance {
    assert(_initialized,
        '[await ThemeManager.init()] must be called first before runApp()');
    return _instance;
  }

  /// Safe getter for ColoristPreferences, ensuring initialization has occurred.
  /// The gettes is async, as it will always check and perform initialization if needed.
  static Future<ColoristPreferences> get safeInstance async {
    await init();
    return _instance;
  }

  void saveBrightness(ThemeBrightness brightness) {
    _preferences.setInt(_brightnessIndexKey, brightness.index);
  }

  void saveTheme(
      ColorThemeSchema theme, List<ColorThemeSchema> availableThemes) {
    // Selecting the current theme's index from all available themes
    final index = availableThemes.indexOf(theme);

    if (index == -1) {
      // If the theme's index is not found, default to the first available theme
      _preferences.setInt(_themeIndexKey, 0);
    } else {
      _preferences.setInt(_themeIndexKey, index);
    }
  }

  ThemeBrightness? getSavedBrightness() {
    final brightnessIndex = _preferences.getInt(_brightnessIndexKey);
    if (brightnessIndex == null) {
      return null;
    } else {
      return ThemeBrightness.values[brightnessIndex];
    }
  }

  int? getSavedThemeIndex() {
    return _preferences.getInt(_themeIndexKey);
  }
}
