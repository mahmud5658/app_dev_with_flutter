import 'package:flutter/material.dart';
import 'package:namednavigation/model/student_model.dart';
import 'package:namednavigation/screen/profile.dart';
import 'package:namednavigation/screen/setting.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, ProfileScreen.routeName,
                      arguments: Student(
                          name: 'Abdullah Al Mahmud', id: '221-15-5658'));
                },
                child: const Text('Profile')),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, SettingScreen.routeName);
                },
                child: const Text('Setting'))
          ],
        ),
      ),
    );
  }
}
