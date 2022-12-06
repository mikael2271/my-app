import 'package:flutter/material.dart';

import '../../themes/light_theme.dart';

class PasswordTextField extends StatefulWidget {
  final String hintText;
  final String? errorText;
  final Function(String) onChangedHandler;
  final VoidCallback? onEditingCompleteHandler;
  final TextInputAction? textInputAction;

  const PasswordTextField({
    Key? key,
    required this.hintText,
    required this.errorText,
    required this.onChangedHandler,
    this.onEditingCompleteHandler,
    this.textInputAction,
  }) : super(key: key);

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  var passwordIsObscure = true;

  void passwordVisibilitySwitch() {
    passwordIsObscure = !passwordIsObscure;

    setState(() {
      passwordIsObscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: widget.hintText,
        labelStyle: TextStyle(
          color: colorList[ColorsEnum.black],
          fontSize: fontSizeList['textfieldhint'],
          //fontFamily: fontFamilyList[''] todo: settar a font
          fontWeight: fontWeightList['light'],
        ),
        floatingLabelStyle: TextStyle(
          color: colorList[ColorsEnum.black],
          fontSize: fontSizeList['textfield'],
          //fontFamily: fontFamilyList[''] todo: settar a font
          fontWeight: fontWeightList['light'],
        ),
        errorText: widget.errorText,
        errorStyle: TextStyle(
          fontSize: fontSizeList['error'],
          //fontFamily: fontFamilyList[''] todo: settar a font
          fontWeight: fontWeightList['light'],
        ),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: colorList[ColorsEnum.black]!)),
        suffixIcon: IconButton(
          icon:
              Icon(passwordIsObscure ? Icons.visibility_off : Icons.visibility),
          color: colorList[ColorsEnum.black],
          splashColor: colorList[ColorsEnum.transparent],
          onPressed: passwordVisibilitySwitch,
        ),
      ),
      style: TextStyle(
        color: colorList[ColorsEnum.black],
        fontSize: fontSizeList['textfield'],
        //fontFamily: fontFamilyList[''] todo: settar a font
        fontWeight: fontWeightList['semibold'],
      ),
      cursorColor: colorList[ColorsEnum.black],
      cursorWidth: 1,
      obscureText: passwordIsObscure,
      onChanged: (value) => widget.onChangedHandler(value),
      onEditingComplete: widget.onEditingCompleteHandler,
      textInputAction: widget.textInputAction,
    );
  }
}
