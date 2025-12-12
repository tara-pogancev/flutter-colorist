import 'package:colorist/colorist.dart';
import 'package:flutter/material.dart';

/// A dropdown field that allows selecting a theme from Colorist's ThemeManager.
class ThemeSelectionDropdownField extends StatelessWidget {
  const ThemeSelectionDropdownField({super.key, this.label = "Select theme"});

  final String label;

  @override
  Widget build(BuildContext context) {
    final controller = ThemeManager.of(context);

    return DropdownButtonFormField<ColorThemeSchema>(
      initialValue: controller.currentTheme,
      decoration: InputDecoration(
        labelText: label,
      ),
      items: controller.themes
          .map(
            (o) => DropdownMenuItem(
              value: o,
              child: Text(o.toString()),
            ),
          )
          .toList(),
      onChanged: (value) {
        if (value != null) {
          controller.setTheme(value);
        }
      },
    );
  }
}
