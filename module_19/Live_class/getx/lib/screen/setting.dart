import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/screen/home.dart';

class SettingScrren extends StatelessWidget {
  const SettingScrren({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Center(
        child: Column(
          children: [
            TextButton(
                onPressed: () {
                  Get.offAll(() => const HomeScreen());
                },
                child: const Text('Go to home')),
            TextButton(onPressed: () {}, child: const Text('Go to Profile')),
          ],
        ),
      ),
    );
  }
}
