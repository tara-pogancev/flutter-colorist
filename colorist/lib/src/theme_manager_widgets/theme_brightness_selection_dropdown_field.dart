import 'package:colorist/colorist.dart';
import 'package:flutter/material.dart';

class ThemeBrightnessSelectionDropdownField extends StatelessWidget {
  const ThemeBrightnessSelectionDropdownField(
      {super.key, this.label = "Select theme brightness"});

  final String label;

  @override
  Widget build(BuildContext context) {
    final controller = ThemeManager.of(context);

    return DropdownButtonFormField<ThemeBrightness>(
      initialValue: controller.brightness,
      decoration: InputDecoration(
        labelText: label,
      ),
      items: ThemeBrightness.values
          .map(
            (o) => DropdownMenuItem(
              value: o,
              child: Text(o.name),
            ),
          )
          .toList(),
      onChanged: (value) {
        if (value != null) {
          controller.setBrightness(value);
        }
      },
    );
  }
}
