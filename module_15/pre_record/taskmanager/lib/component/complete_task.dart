import 'package:flutter/material.dart';
import 'package:taskmanager/api/api_client.dart';
import 'package:taskmanager/component/task_list_view.dart';
import 'package:taskmanager/style/style.dart';

class CompleteTaskList extends StatefulWidget {
  const CompleteTaskList({super.key});

  @override
  State<CompleteTaskList> createState() => _CompleteTaskListState();
}

class _CompleteTaskListState extends State<CompleteTaskList> {
  List taskItems = [];
  bool loading = true;

  @override
  void initState() {
    callData();
    super.initState();
  }

  callData() async {
    var data = await taskListRequest('Completed');
    setState(() {
      loading = false;
      taskItems = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: loading
              ? CircularProgressIndicator(
                  color: colorGreen,
                )
              : RefreshIndicator(
                  onRefresh: () async {
                    await callData();
                  },
                  child: taskList(taskItems))),
    );
  }
}
