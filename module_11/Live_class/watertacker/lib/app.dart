import 'package:flutter/material.dart';
import 'package:watertacker/home.dart';

class WaterTacker extends StatelessWidget {
  const WaterTacker({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
        )
      ),
      home: const HomeScreen(),
    );
  }
}
