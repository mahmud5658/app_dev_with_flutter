import 'package:assignment/screen/home_activity.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Photo Gallery App',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home:  const MyHomePage(),
    );
  }
}