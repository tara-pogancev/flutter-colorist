import 'package:colorist/colorist.dart';
import 'package:flutter/material.dart';

/// A dropdown field that allows selecting a theme from Colorist's ThemeManager.
/// Changing active theme will also set prefered [BrightnessTheme] to one matching the theme.
/// If the [Brightness] matches the current system brightness, the app will continue using system brightness.
class ThemeSelectionDropdownField extends StatelessWidget {
  const ThemeSelectionDropdownField(
      {super.key, this.label = "Select theme", this.themeNameBuilder});

  /// Dropdown field descriptive label
  final String label;

  /// String builder for each theme option. It is highly recommended to implement this builder,
  /// as the default implementation does not provide descriptive names for themes.
  final String Function(ColorThemeSchema theme)? themeNameBuilder;

  @override
  Widget build(BuildContext context) {
    final controller = ThemeManager.of(context);

    return DropdownButtonFormField<ColorThemeSchema>(
      initialValue: controller.currentTheme,
      decoration: InputDecoration(
        labelText: label,
      ),
      items: controller.themes
          .asMap()
          .map((index, theme) => MapEntry(
                index,
                DropdownMenuItem<ColorThemeSchema>(
                  value: theme,
                  child: Text(
                    themeNameBuilder?.call(theme) ??
                        "${theme.runtimeType.toString().replaceAll("_", "")} ${index + 1} [${theme.brightness.name}]",
                  ),
                ),
              ))
          .values
          .toList(),
      onChanged: (value) {
        if (value != null) {
          controller.setTheme(value);
        }
      },
    );
  }
}
