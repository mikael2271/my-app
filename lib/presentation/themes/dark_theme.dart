import 'package:flutter/material.dart';

final ThemeData DarkTheme = _buildDarkTheme();

ThemeData _buildDarkTheme() {
  final ThemeData base = ThemeData.dark();
  return base.copyWith(
    backgroundColor: Color(0xff191919),
    primaryColor: Color(0xff004eff),
    /*textTheme: _buildDarkTextTheme(base.textTheme),
    colorScheme: _buildDarkColorScheme(base.colorScheme),
    inputDecorationTheme:
        _buildDarkInputDecorationTheme(base.inputDecorationTheme),*/
  );
}
