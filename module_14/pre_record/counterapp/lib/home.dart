import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int countNumber = 0;
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter App'),
      ),
      body: Center(
        child: Text('Counting number: ${countNumber.toString()}'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            countNumber++;

          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
