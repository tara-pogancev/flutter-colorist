import 'package:colorist/colorist.dart';
import 'package:example/theme/color_themes.dart';
import 'package:flutter/material.dart';

/// A demo widget showcasing various theming widgets provided by Colorist.
class ColoristThemingWidgetsDemo extends StatelessWidget {
  const ColoristThemingWidgetsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ThemeBrightnessSwitch(),
        const Divider(),
        ThemeSelectionDropdownField(
          label: 'Select preferred app theme',

          /// Example for a custom theme name builder
          themeNameBuilder: (theme) {
            if (theme == appColorThemes['ocean']) {
              return 'Ocean Theme (Light)';
            } else if (theme == appColorThemes['desert']) {
              return 'Desert Theme (Light)';
            } else if (theme == appColorThemes['dark_forest']) {
              return 'Forest Theme (Dark)';
            } else {
              return 'Unknown Theme';
            }
          },
        ),
        const Divider(),
        const ThemeBrightnessSelectionDropdownField(),
        const Divider(),
        const ColoristThemeDebugWidget(),
      ],
    );
  }
}
