import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/textstyles.dart';

class NormalTextfield extends StatelessWidget {
  final TextInputType textInputType;
  final String labelText;
  final String? errorText;
  final Function(String)? onChanged;

  const NormalTextfield(
      {Key? key,
      required this.textInputType,
      required this.labelText,
      this.onChanged,
      this.errorText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
        keyboardType: textInputType,
        onChanged: onChanged,
        decoration: InputDecoration(
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                  width: 1.0, color: Color.fromARGB(255, 69, 74, 78))),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(width: 2.0, color: AppColors.lightGrey)),
          labelText: labelText,
          errorText: errorText,
          labelStyle: BlackTextStyles.bodyTextNormal,

          // floatingLabelStyle: const TextStyle(
          //     color: AppColors.greenColor, fontWeight: FontWeight.w500)
        ));
  }
}
