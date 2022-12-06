import 'package:flutter/material.dart';

const Map<ColorsEnum, Color> colorList = {
  ColorsEnum.black: Color(0xff000000),
  ColorsEnum.grey: Color(0xfff0f0f0),
  ColorsEnum.white: Color(0xffffffff),
  ColorsEnum.transparent: Colors.transparent,
};

enum ColorsEnum {
  black,
  grey,
  white,
  transparent,
}

const Map fontSizeList = {
  'error': 12.0,
  'small': 14.0,
  'regular': 16.0,
  'button': 18.0,
  'textfield': 18.0,
  'textfieldhint': 20.0,
  'title': 30.0,
};

const Map fontFamilyList = {
  '': '',
};

const Map fontWeightList = {
  'light': FontWeight.w300,
  'semibold': FontWeight.w600,
  'bold': FontWeight.w700,
};

final ThemeData lightTheme = _buildLightTheme();

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
