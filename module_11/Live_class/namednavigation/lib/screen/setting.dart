import 'package:flutter/material.dart';
import 'package:namednavigation/screen/home.dart';
import 'package:namednavigation/screen/profile.dart';

class SettingScreen extends StatelessWidget {
  static const String routeName = '/setting';
  const SettingScreen({super.key, required this.name, required this.age});

  final String name;
  final int age;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as ScreenArgument;
    print(args.name);
    print(args.age);
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
                  Navigator.pushNamed(context, ProfileScreen.routeName,
                      arguments: ['Abdullah', 'Akash', 'Bappy']);
                },
                child: const Text('Profile'))
          ],
        ),
      ),
    );
  }
}

class ScreenArgument {
  final String name;
  final int age;

  ScreenArgument({required this.name,required this.age});
}
