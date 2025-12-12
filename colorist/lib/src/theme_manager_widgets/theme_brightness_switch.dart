import 'package:colorist/colorist.dart';
import 'package:flutter/material.dart';

/// A switch tile that allows toggling between light and dark theme brightness
/// using Colorist's ThemeManager.
class ThemeBrightnessSwitch extends StatelessWidget {
  const ThemeBrightnessSwitch({
    super.key,
    this.switchOnValue = Brightness.dark,
    this.label = "Dark mode enabled",
    this.subtitle,
    this.hideSubtitle = false,
  });

  final Brightness switchOnValue;
  final String label;
  final String? subtitle;
  final bool hideSubtitle;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: context.themeManager.brightness.dart == switchOnValue,
      onChanged: (value) {
        if (value) {
          context.themeManager.setBrightness(switchOnValue == Brightness.dark
              ? ThemeBrightness.dark
              : ThemeBrightness.light);
        } else {
          context.themeManager.setBrightness(switchOnValue == Brightness.dark
              ? ThemeBrightness.light
              : ThemeBrightness.dark);
        }
      },
      title: Text(label),
      subtitle: (hideSubtitle)
          ? null
          : Text(subtitle ??
              "Enable ${switchOnValue == Brightness.dark ? "dark" : "light"} mode for the app"),
    );
  }
}
