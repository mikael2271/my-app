import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../themes/light_theme.dart';
import 'default_text.dart';

enum SnackbarType {
  error,
  success,
}

class CustomSnackbar {
  static void buildCustomSnackbar(
    BuildContext context,
    SnackbarType type,
    String? message,
  ) {
    showTopSnackBar(
      Overlay.of(context),
      Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
          color: type == SnackbarType.error
              ? const Color(0xfff27373)
              : const Color(0xff2f2f2f),
        ),
        padding: const EdgeInsets.only(left: 24, right: 24),
        height: 100,
        child: Container(
          height: 90,
          width: MediaQuery.of(context).size.width - 120,
          alignment: Alignment.center,
          child: DefaultTextStyle(
            style: const TextStyle(),
            child: DefaultText(
              text: message != null && message.isNotEmpty
                  ? message
                  : AppLocalizations.of(context).defaultError,
              color: colorList[ColorsEnum.white]!,
              fontSize: fontSizeList['regular']!,
              fontFamily: '', //fontFamilyList['MyriadPro'], todo: set font
              fontWeight: fontWeightList['light']!,
            ),
          ),
        ),
      ),
      displayDuration: const Duration(
        milliseconds: 1000,
      ),
    );
  }
}
