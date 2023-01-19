import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../themes/light_theme.dart';

class DefaultTextField extends StatelessWidget {
  const DefaultTextField({
    Key? key,
    required this.hintText,
    this.errorText,
    required this.onChangedHandler,
    required this.textInputAction,
    required this.textInputType,
    this.controllerHandler,
    this.maxLength,
    this.inputFormatters,
    this.editable = true,
  }) : super(key: key);

  final String hintText;
  final String? errorText;
  final void Function(String) onChangedHandler;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final TextEditingController? controllerHandler;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final bool? editable;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        counterText: '',
        labelText: hintText,
        labelStyle: TextStyle(
          color: colorList[ColorsEnum.black],
          fontSize: fontSizeList['textfieldhint'],
          //fontFamily: fontFamilyList['MyriadPro'], todo: set font
          fontWeight: fontWeightList['light'],
        ),
        floatingLabelStyle: TextStyle(
          color: colorList[ColorsEnum.black],
          fontSize: fontSizeList['textfield'],
          //fontFamily: fontFamilyList['MyriadPro'], todo: set font
          fontWeight: fontWeightList['light'],
        ),
        errorText: errorText,
        errorStyle: TextStyle(
          fontSize: fontSizeList['error'],
          //fontFamily: FontFamilyList['MyriadPro'], todo: set font
          fontWeight: fontWeightList['light'],
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: colorList[ColorsEnum.black]!),
        ),
      ),
      style: TextStyle(
        color: colorList[ColorsEnum.black],
        fontSize: fontSizeList['textfield'],
        //fontFamily: FontFamilyList['MyriadPro'], todo: set font
        fontWeight: fontWeightList['semibold'],
      ),
      cursorColor: colorList[ColorsEnum.black],
      cursorWidth: 1,
      onChanged: onChangedHandler,
      textInputAction: textInputAction,
      keyboardType: textInputType,
      controller: controllerHandler,
      maxLength: maxLength,
      maxLines: null,
      inputFormatters: inputFormatters,
      enabled: editable,
    );
  }
}
