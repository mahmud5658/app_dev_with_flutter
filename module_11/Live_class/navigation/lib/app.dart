

import 'package:flutter/material.dart';
import 'package:navigation/screen/home_screen.dart';

class NavigationApp extends StatelessWidget {
  const NavigationApp({super.key});

  @override
  Widget build(BuildContext context) {
   return const MaterialApp(
     home: HomeScreen(),
   );
  }
}
