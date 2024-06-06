import 'package:contact_list/utils/colors.dart';
import 'package:flutter/material.dart';

class AppbarStyle {
  static AppBarTheme getAppBarTheme() => const AppBarTheme(
      backgroundColor: appPrimaryColor,
      foregroundColor: whiteColor,
      titleTextStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.bold));
}
