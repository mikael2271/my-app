import 'package:flutter/material.dart';

import '../../themes/light_theme.dart';
import 'default_text.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton(this.buttonText, this.buttonEvent, {super.key});

  final String buttonText;
  final VoidCallback buttonEvent;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              12,
            ),
          ),
          backgroundColor: colorList[ColorsEnum.grey],
          shadowColor: colorList[ColorsEnum.transparent],
          textStyle: const TextStyle(),
        ),
        onPressed: buttonEvent,
        child: DefaultText(
          text: buttonText,
          color: colorList[ColorsEnum.black]!,
          fontSize: fontSizeList['button']!,
          fontFamily: '', //fontFamilyList['MyriadPro'], todo: set font
          fontWeight: fontWeightList['semibold']!,
        ),
      ),
    );
  }
}
