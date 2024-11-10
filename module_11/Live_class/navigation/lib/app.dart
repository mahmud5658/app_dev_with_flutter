import 'package:flutter/material.dart';
import 'package:navigation/screen/home.dart';
import 'package:navigation/screen/profile.dart';
import 'package:navigation/screen/setting.dart';

class NavigationApp extends StatelessWidget {
  const NavigationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    initialRoute: '/',
        routes: {
      '/': (context) => const HomeScreen(),
      '/profile': (context) => const ProfileScreen(),
      '/setting': (context) => const SettingScreen()
    });
  }
}
