import 'package:flutter/material.dart';

class DefaultText extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final String fontFamily;
  final FontWeight fontWeight;
  final bool shouldCenter;
  final bool shouldRemoveEllipsis;

  DefaultText({
    required this.text,
    required this.color,
    required this.fontSize,
    required this.fontFamily,
    required this.fontWeight,
    this.shouldCenter = false,
    this.shouldRemoveEllipsis = false,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontFamily: fontFamily,
        fontWeight: fontWeight,
        leadingDistribution: TextLeadingDistribution.even,
        height: 1.2,
      ),
      textAlign: shouldCenter ? TextAlign.center : TextAlign.left,
      overflow: shouldRemoveEllipsis ? null : TextOverflow.ellipsis,
    );
  }
}
