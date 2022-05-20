import 'package:flutter/material.dart';
import '../../utils/colors.dart';

class DarkGreenButton extends StatelessWidget {
  final double width;
  final double height;
  final String text;
  final TextStyle textStyle;
  final Function()? onPress;

  const DarkGreenButton(
      {Key? key,
      required this.width,
      required this.height,
      required this.text,
      required this.textStyle,
      required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
          primary: AppColors.actionColorLightGreen.withOpacity(0.8),
          onPrimary: AppColors.primaryWhite,
          elevation: 0.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
          fixedSize: Size(width, height)),
      child: Text(
        text,
        style: textStyle,
      ),
    );
  }
}

class LightGreenButton extends StatelessWidget {
  final double width;
  final double height;
  final String text;
  final TextStyle textStyle;

  const LightGreenButton(
      {Key? key,
      required this.width,
      required this.height,
      required this.text,
      required this.textStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
          primary: AppColors.greenColor,
          onPrimary: AppColors.primaryWhite,
          elevation: 0.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
          fixedSize: Size(width, height)),
      child: Text(
        text,
        style: textStyle,
      ),
    );
  }
}
