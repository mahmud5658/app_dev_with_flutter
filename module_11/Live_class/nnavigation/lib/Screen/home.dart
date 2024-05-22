import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(onPressed: (){

            },
            child: const Text('Settings'),)
          ],
        ),
      ),
    );
  }
}