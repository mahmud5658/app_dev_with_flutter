import 'package:flutter/material.dart';
import 'package:namednavigation/model/student_model.dart';
import 'package:namednavigation/screen/home.dart';
import 'package:namednavigation/screen/profile.dart';

class SettingScreen extends StatelessWidget {
  static const String routeName = '/setting';
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, ProfileScreen.routeName,
                      arguments: Student(
                          name: 'Rakibul Hasan Akash', id: '221-15-5688'));
                },
                child: const Text('Profile')),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, HomeScreen.routeName, (route) => false);
                },
                child: const Text('Home')),
          ],
        ),
      ),
    );
  }
}
