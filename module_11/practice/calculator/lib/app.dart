import 'package:calculator/Screen/home.dart';
import 'package:flutter/material.dart';

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return   MaterialApp(
      debugShowCheckedModeBanner:  false,
      theme: ThemeData.dark(),
      home: const HomeScreen(),
    );
  }
}