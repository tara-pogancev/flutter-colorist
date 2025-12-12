import 'package:colorist/colorist.dart';
import 'package:flutter/material.dart';

class ThemeBrightnessSwitch extends StatelessWidget {
  const ThemeBrightnessSwitch({
    super.key,
    this.switchOnValue = Brightness.dark,
    this.label = "Dark mode enabled",
    this.subtitle = "Enable dark mode for the app",
  });

  final Brightness switchOnValue;
  final String label;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    // This will cause the widget to rebuild when theme or brightness changes
    final controller = ThemeManager.of(context);

    return SwitchListTile(
      value: controller.brightness == switchOnValue,
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
      subtitle: Text(subtitle),
    );
  }
}
