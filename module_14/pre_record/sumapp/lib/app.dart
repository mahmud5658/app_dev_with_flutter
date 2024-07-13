import 'package:flutter/material.dart';
import 'package:sumapp/home.dart';

class SumApp extends StatelessWidget {
  const SumApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}