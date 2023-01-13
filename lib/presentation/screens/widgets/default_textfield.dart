import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../themes/light_theme.dart';

class DefaultTextField extends StatelessWidget {
  final String hintText;
  final String? errorText;
  final Function(String) onChangedHandler;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final TextEditingController? controllerHandler;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final bool? editable;

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

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        counterText: "",
        labelText: hintText,
        labelStyle: TextStyle(
          color: colorList[ColorsEnum.black],
          fontSize: fontSizeList['textfieldhint'],
          //fontFamily: fontFamilyList['MyriadPro'], todo: settar a font
          fontWeight: fontWeightList['light'],
        ),
        floatingLabelStyle: TextStyle(
          color: colorList[ColorsEnum.black],
          fontSize: fontSizeList['textfield'],
          //fontFamily: fontFamilyList['MyriadPro'], todo: settar a font
          fontWeight: fontWeightList['light'],
        ),
        errorText: errorText,
        errorStyle: TextStyle(
          fontSize: fontSizeList['error'],
          //fontFamily: FontFamilyList['MyriadPro'], todo: settar a font
          fontWeight: fontWeightList['light'],
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: colorList[ColorsEnum.black]!),
        ),
      ),
      style: TextStyle(
        color: colorList[ColorsEnum.black],
        fontSize: fontSizeList['textfield'],
        //fontFamily: FontFamilyList['MyriadPro'], todo: settar a font
        fontWeight: fontWeightList['semibold'],
      ),
      cursorColor: colorList[ColorsEnum.black],
      cursorWidth: 1,
      onChanged: (value) => onChangedHandler(value),
      textInputAction: textInputAction,
      keyboardType: textInputType,
      controller: controllerHandler,
      maxLength: maxLength,
      minLines: null,
      maxLines: null,
      inputFormatters: inputFormatters,
      enabled: editable,
    );
  }
}
