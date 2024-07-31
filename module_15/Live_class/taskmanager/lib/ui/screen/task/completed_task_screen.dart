import 'package:flutter/material.dart';
import 'package:taskmanager/ui/widgets/task_item.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({Key? key}) : super(key: key);

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Padding(
        padding: const EdgeInsets.only(top: 8, right: 8, left: 8),
        child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return const TaskItem();
            }),
      ),
    );
  }
}
