import 'package:flutter/material.dart';
import 'package:todo/home.dart';

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List',
      home: HomePage(),
    );
  }
}