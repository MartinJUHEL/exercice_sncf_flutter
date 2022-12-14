import 'package:flutter/material.dart';

class CustomStyles {
  static final submitPrimaryButton = ButtonStyle(
    padding: MaterialStateProperty.all(EdgeInsets.fromLTRB(50, 20, 50, 20)),
    minimumSize: MaterialStateProperty.all(Size(double.infinity - 20,
        30)), // double.infinity is the width and 30 is the height
  );

  static InputDecoration defaultTextFormFieldStyle(
      {String? labelTextStr = "",
      String? hintTextStr = "",
      IconData? icon,
      InkWell? suffixIcon}) {
    return InputDecoration(
      icon: icon != null
          ? Icon(
              icon,
              color: Colors.blue,
            )
          : null,
      labelText: labelTextStr,
      hintText: hintTextStr,
      suffixIcon: suffixIcon,
    );
  }
}
