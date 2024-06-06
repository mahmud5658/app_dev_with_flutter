import 'package:contact_list/utils/colors.dart';
import 'package:flutter/material.dart';

class ElevatedButtonStyle {
  static ElevatedButtonThemeData getElevatedButtonStyle() =>
      ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: appPrimaryColor,
              foregroundColor: whiteColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              textStyle:
                  const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)));
}
