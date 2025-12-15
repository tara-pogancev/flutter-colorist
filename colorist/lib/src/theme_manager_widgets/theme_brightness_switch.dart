import 'package:colorist/colorist.dart';
import 'package:flutter/material.dart';

/// A switch tile that allows toggling between light and dark theme brightness
/// using Colorist's ThemeManager. This overrides app's current brightness settings, and active theme if possible.
/// If default theme brightness mode is set to [ThemeBrightness.system], toggling the switch on and off will alter
/// this preference to either [ThemeBrightness.dark] or [ThemeBrightness.light].
/// If you want to keep the [ThemeBrightness.system] option, consider using [ThemeBrightnessSelectionDropdownField] instead.
class ThemeBrightnessSwitch extends StatelessWidget {
  const ThemeBrightnessSwitch({
    super.key,
    this.switchOnValue = Brightness.dark,
    this.label = "Dark mode enabled",
    this.subtitle,
    this.hideSubtitle = false,
  });

  /// The brightness value that the switch represents when turned on.
  /// By default, this is [Brightness.dark].
  final Brightness switchOnValue;

  /// Label describing the switch functionality.
  final String label;

  /// Optional subtitle for additional context.
  final String? subtitle;

  /// Boolean value to hide subtitle completely. If [false], and no subtitle is provided,
  /// the UI will still show default subtitle text.
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
