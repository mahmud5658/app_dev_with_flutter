import 'package:flutter/material.dart';
import 'package:taskmanager/ui/widgets/task_item.dart';

class CancelTaskScreen extends StatefulWidget {
  const CancelTaskScreen({Key? key}) : super(key: key);

  @override
  State<CancelTaskScreen> createState() => _CancelTaskScreenState();
}

class _CancelTaskScreenState extends State<CancelTaskScreen> {
  @override
  Widget build(BuildContext context) {
  return Scaffold(
     body: Padding(
        padding: const EdgeInsets.only(top: 8,right: 8,left: 8),
        child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return const TaskItem();
            }),
      ),
    );
  }
}