import 'package:flutter/material.dart';
import 'package:taskmanager/data/model/network_response.dart';
import 'package:taskmanager/data/model/task_list_wraper_model.dart';
import 'package:taskmanager/data/model/task_model.dart';
import 'package:taskmanager/data/network_caller/network_caller.dart';
import 'package:taskmanager/data/utilities/url.dart';
import 'package:taskmanager/ui/widgets/snack_bar_message.dart';
import 'package:taskmanager/ui/widgets/task_item.dart';

class CancelTaskScreen extends StatefulWidget {
  const CancelTaskScreen({Key? key}) : super(key: key);

  @override
  State<CancelTaskScreen> createState() => _CancelTaskScreenState();
}

class _CancelTaskScreenState extends State<CancelTaskScreen> {
  bool _inProgess = false;
  List<TaskModel> canceledTaskList = [];

  @override
  void initState() {
    super.initState();
    _getCanceledTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 8, right: 8, left: 8),
        child: RefreshIndicator(
          onRefresh: () async {
            _getCanceledTask();
          },
          child: Visibility(
            visible: _inProgess == false,
            replacement: const Center(
              child: CircularProgressIndicator(),
            ),
            child: ListView.builder(
                itemCount: canceledTaskList.length,
                itemBuilder: (context, index) {
                  return TaskItem(
                    taskModel: canceledTaskList[index],
                  );
                }),
          ),
        ),
      ),
    );
  }

  Future<void> _getCanceledTask() async {
    if (mounted) {
      setState(() {
        _inProgess = true;
      });
    }
    NetworkResponse response =
        await NetworkCaller.getRequest(Urls.inProgressTask);

    if (response.isSuccess) {
      TaskListWraperModel taskListWraperModel =
          TaskListWraperModel.fromJson(response.responseData);
      canceledTaskList = taskListWraperModel.taskList ?? [];
    } else {
      if (mounted) {
        showSnackBarMessage(context,
            response.errorMessage ?? 'Get In Progress task failed! try again');
      }
    }
    if (mounted) {
      setState(() {
        _inProgess = false;
      });
    }
  }
}
