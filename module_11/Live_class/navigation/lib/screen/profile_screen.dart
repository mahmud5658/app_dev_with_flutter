import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
              ElevatedButton(onPressed: (){}, child: const Text("Profile")),
              const SizedBox(height: 18,),
              ElevatedButton(onPressed: (){}, child: const Text("Settings")),
            ],
          )
      ),
    );
  }
}
