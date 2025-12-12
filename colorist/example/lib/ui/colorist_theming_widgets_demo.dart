import 'package:colorist/colorist.dart';
import 'package:flutter/material.dart';

/// A demo widget showcasing various theming widgets provided by Colorist.
class ColoristThemingWidgetsDemo extends StatelessWidget {
  const ColoristThemingWidgetsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      spacing: 16,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ThemeBrightnessSwitch(),
        Divider(),
        ThemeSelectionDropdownField(),
        Divider(),
        ThemeBrightnessSelectionDropdownField(),
        ColoristThemeDebugWidget(),
        Divider(),
      ],
    );
  }
}
