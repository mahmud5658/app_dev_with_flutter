import 'package:authapp/screen/splash.dart';
import 'package:flutter/material.dart';

class AuthApp extends StatelessWidget {
  const AuthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white
        )
      ),
      home: const SplashScreen(),
    );
  }
}
