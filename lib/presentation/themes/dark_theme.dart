import 'package:flutter/material.dart';

final ThemeData darkTheme = _buildDarkTheme();

ThemeData _buildDarkTheme() {
  final ThemeData base = ThemeData.dark();
  return base.copyWith(
    backgroundColor: const Color(0xff191919),
    primaryColor: const Color(0xff004eff),
    /*textTheme: _buildDarkTextTheme(base.textTheme),
    colorScheme: _buildDarkColorScheme(base.colorScheme),
    inputDecorationTheme:
        _buildDarkInputDecorationTheme(base.inputDecorationTheme),*/
  );
}
