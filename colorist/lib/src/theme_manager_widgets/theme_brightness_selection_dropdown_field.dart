import 'package:colorist/colorist.dart';
import 'package:flutter/material.dart';

/// A dropdown field that allows selecting prefered app's theme brightness
/// Available options are [ThemeBrightness.light], [ThemeBrightness.dark], and [ThemeBrightness.system].
/// Upon changing the selection, the theme will also change accordingly. If multiple themes were provided, matching
/// the desired brightness, the first matching theme will be applied.
class ThemeBrightnessSelectionDropdownField extends StatelessWidget {
  const ThemeBrightnessSelectionDropdownField(
      {super.key,
      this.label = "Select theme brightness",
      this.optionNameBuilder});

  /// Dropdown field descriptive label
  final String label;

  /// String builder for each theme brightness option.
  final String Function(ThemeBrightness)? optionNameBuilder;

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
            (brightnessOption) => DropdownMenuItem(
              value: brightnessOption,
              child: Text(optionNameBuilder?.call(brightnessOption) ?? brightnessOption.name),
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
