import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/screen/setting.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center(
        child: Column(
          children: [
            TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text('Go to home')),
            TextButton(
                onPressed: () {
                  Get.off(() => const SettingScrren());
                },
                child: const Text('Go to Settings')),
          ],
        ),
      ),
    );
  }
}
