import 'package:flutter/material.dart';
import 'package:taskmanager/utility/utility.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  String? email = '';

  @override
  void initState() {
    callUserData();
    super.initState();
  }

  callUserData() async {
    String? a = await readUserData('email');
    setState((){
      email = a!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(email!),
      ),
    );
  }
}
