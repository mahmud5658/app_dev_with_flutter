import 'package:flutter/material.dart';
import 'package:namednavigation/screen/home.dart';
import 'package:namednavigation/screen/profile.dart';

class SettinScreen extends StatelessWidget {
  static const String routeName = '/setting';
  const SettinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    print(args);
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
                  Navigator.pushNamedAndRemoveUntil(
                      context, HomeScreen.routeName, (route) => false);
                },
                child: const Text('Home')),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, ProfileScreen.routeName,arguments: ['Abdullah','Akash','Bappy']);
                },
                child: const Text('Profile'))
          ],
        ),
      ),
    );
  }
}
