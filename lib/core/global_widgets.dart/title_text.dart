import 'package:flutter/material.dart';
import '../../utils/colors.dart';

class TitleText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  const TitleText(
      {Key? key,
      this.text = '',
      this.fontSize = 18,
      this.color = LightColor.navyBlue2})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(
            fontFamily: 'QuickSand',
            fontSize: fontSize,
            fontWeight: FontWeight.w800,
            color: color));
  }
}
