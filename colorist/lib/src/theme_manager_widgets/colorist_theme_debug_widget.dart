import 'package:colorist/colorist.dart';
import 'package:flutter/material.dart';

class ColoristThemeDebugWidget extends StatelessWidget {
  const ColoristThemeDebugWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // This will cause the widget to rebuild when theme or brightness changes
    final controller = ThemeManager.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Theme Debug Info',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        Text('App brightness preference: ${controller.brightness.name}'),
        Text('Active theme: ${controller.currentTheme.runtimeType}'),
        Text(
            'Active theme brightness: ${controller.currentTheme.themeBrightness.name}'),
        // Text('Theme Name: ${controller.currentTheme.name}'),
      ],
    );
  }
}
