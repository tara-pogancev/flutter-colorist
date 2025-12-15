import 'package:colorist/colorist.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _brightnessIndexKey = 'colorist_theme_brightness_index';
const String _themeIndexKey = 'colorist_selected_theme_index';

/// Helper class for persisting user's preferences related to Colorist's ThemeManager.
/// Persisted settings are [ThemeBrightness] and selected [ColorThemeSchema].
/// Persistence is handled using the `shared_preferences` package, and will override initial settings provided
/// with [ThemeManager] root widget if available.
class ColoristPreferences {
  ColoristPreferences();

  Future<SharedPreferences> get _preferences async =>
      await SharedPreferences.getInstance();

  void saveBrightness(ThemeBrightness brightness) async {
    (await _preferences).setInt(_brightnessIndexKey, brightness.index);
  }

  void saveTheme(
      ColorThemeSchema theme, List<ColorThemeSchema> availableThemes) async {
    // Selecting the current theme's index from all available themes
    final index = availableThemes.indexOf(theme);

    if (index == -1) {
      // If the theme's index is not found, default to the first available theme
      (await _preferences).setInt(_themeIndexKey, 0);
    } else {
      (await _preferences).setInt(_themeIndexKey, index);
    }
  }

  Future<ThemeBrightness?> getSavedBrightness() async {
    final brightnessIndex = (await _preferences).getInt(_brightnessIndexKey);
    if (brightnessIndex == null) {
      return null;
    } else {
      return ThemeBrightness.values[brightnessIndex];
    }
  }

  Future<int?> getSavedThemeIndex() async {
    return (await _preferences).getInt(_themeIndexKey);
  }
}
