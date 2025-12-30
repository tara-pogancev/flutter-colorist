import 'package:example/theme/color_themes.dart';
import 'package:flutter/cupertino.dart';

class CupertinoAppTheme {
  static CupertinoThemeData getForColorTheme(AppColorTheme theme) {
    return CupertinoThemeData(
      brightness: theme.brightness,
      primaryColor: theme.primary,
    );
  }
}
