import 'package:flutter/material.dart';

class navigation {
  static void navigationMaterialRoute(BuildContext context,Widget screen){
    Navigator.push(context,MaterialPageRoute(builder: (context){return screen;}));
  }
  static void navigationBack(BuildContext context,Widget screen){
    Navigator.pop(context);
  }

}