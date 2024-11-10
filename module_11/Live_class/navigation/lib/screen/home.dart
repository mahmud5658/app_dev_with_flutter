import 'package:flutter/material.dart';
class HomeScreen extends StatelessWidget {
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
               Navigator.pushNamed(context, '/profile',arguments: {'Name':'Abdullah Al Mahmud'});
              },
              child: const Text("Profile")),
          const SizedBox(
            height: 18,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/profile');
              },
              child: const Text("Settings")),
        ],
      )),
    );
  }
}
