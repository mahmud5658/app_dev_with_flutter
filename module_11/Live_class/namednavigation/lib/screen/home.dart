import 'package:flutter/material.dart';
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
                  Navigator.pushNamed(context, SettinScreen.routeName,
                      arguments: {'name': 'Abdullah Al Mahmud'});
                },
                child: const Text('Settings')),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, ProfileScreen.routeName,
                      arguments: 'Rafat');
                },
                child: const Text('Profile'))
          ],
        ),
      ),
    );
  }
}
