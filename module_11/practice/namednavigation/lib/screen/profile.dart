import 'package:flutter/material.dart';
import 'package:namednavigation/screen/home.dart';
import 'package:namednavigation/screen/setting.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = '/profile';
  const ProfileScreen({super.key, required this.name, required this.id});
  final String name;
  final String id;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, SettingScreen.routeName);
                },
                child: const Text('Setting')),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, HomeScreen.routeName, (route) => false);
                },
                child: const Text('Home')),
            const SizedBox(
              height: 20,
            ),
            Text('Name: ${widget.name}'),
            Text('ID: ${widget.id}')
          ],
        ),
      ),
    );
  }
}
