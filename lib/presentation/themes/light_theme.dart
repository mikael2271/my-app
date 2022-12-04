import 'package:flutter/material.dart';

final ThemeData LightTheme = _buildLightTheme();

ThemeData _buildLightTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    backgroundColor: Colors.white,
    primaryColor: Color(0xff004eff),
    /*textTheme: _buildLightTextTheme(base.textTheme),
    colorScheme: _buildLightColorScheme(base.colorScheme),
    inputDecorationTheme:
        _buildLightInputDecorationTheme(base.inputDecorationTheme),*/
  );
}
