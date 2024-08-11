import 'package:calculator/home.dart';
import 'package:flutter/material.dart';

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.red, foregroundColor: Colors.white),
          inputDecorationTheme: const InputDecorationTheme(
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue)),
              enabledBorder: OutlineInputBorder(),
              errorBorder: OutlineInputBorder(),
              contentPadding: EdgeInsets.all(15))),
      home: const HomeScreen(),
    );
  }
}
