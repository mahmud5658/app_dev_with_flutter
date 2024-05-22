import 'package:flutter/material.dart';
import 'package:nnavigation/Screen/Settings.dart';
import 'package:nnavigation/Screen/home.dart';
import 'package:nnavigation/Screen/profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(),
        '/settings': (context) => const Settings(),
        '/profile': (context) => const Profile(),
      },
    );
  }
}
