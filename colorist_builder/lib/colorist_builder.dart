import 'package:build/build.dart';
import 'package:colorist_builder/src/color_theme_generator.dart';
import 'package:source_gen/source_gen.dart';

Builder coloristBuilder(BuilderOptions options) => PartBuilder(
      [ColoristThemeGenerator()],
      '.g.dart',
      header: '''
// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
''',
    );
