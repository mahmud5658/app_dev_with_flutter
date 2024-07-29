import 'package:flutter/material.dart';
import 'package:taskmanager/api/api_client.dart';
import 'package:taskmanager/component/task_list_view.dart';
import 'package:taskmanager/style/style.dart';

class CancelTaskList extends StatefulWidget {
  const CancelTaskList({super.key});

  @override
  State<CancelTaskList> createState() => _CancelTaskListState();
}

class _CancelTaskListState extends State<CancelTaskList> {
  List taskItems = [];
  bool loading = true;

  @override
  void initState() {
    callData();
    super.initState();
  }

  callData() async {
    var data = await taskListRequest('Canceled');
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
                  onRefresh: () async{
                    await callData();
                  },
                  child: taskList(taskItems))),
    );
  }
}
