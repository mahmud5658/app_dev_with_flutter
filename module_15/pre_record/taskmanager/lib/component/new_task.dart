import 'package:flutter/material.dart';
import 'package:taskmanager/api/api_client.dart';
import 'package:taskmanager/component/task_list_view.dart';
import 'package:taskmanager/style/style.dart';

class NewTaskList extends StatefulWidget {
  const NewTaskList({super.key});

  @override
  State<NewTaskList> createState() => _NewTaskListState();
}

class _NewTaskListState extends State<NewTaskList> {
  List taskItems = [];
  bool loading = true;

  @override
  void initState() {
    callData();
    super.initState();
  }

  callData() async {
    var data = await taskListRequest('New');
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
