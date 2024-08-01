import 'package:flutter/material.dart';
import 'package:taskmanager/data/model/network_response.dart';
import 'package:taskmanager/data/model/task_list_wraper_model.dart';
import 'package:taskmanager/data/model/task_model.dart';
import 'package:taskmanager/data/network_caller/network_caller.dart';
import 'package:taskmanager/data/utilities/url.dart';
import 'package:taskmanager/ui/widgets/snack_bar_message.dart';
import 'package:taskmanager/ui/widgets/task_item.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({Key? key}) : super(key: key);

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  bool _inProgess = false;
  List<TaskModel> compeletedTaskList = [];

  @override
  void initState() {
    super.initState();
    _getCompletedTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 8, right: 8, left: 8),
        child: RefreshIndicator(
          onRefresh: () async {
            _getCompletedTask();
          },
          child: Visibility(
            visible: _inProgess == false,
            replacement: const Center(
              child: CircularProgressIndicator(),
            ),
            child: ListView.builder(
                itemCount: compeletedTaskList.length,
                itemBuilder: (context, index) {
                  return TaskItem(
                    taskModel: compeletedTaskList[index],
                  );
                }),
          ),
        ),
      ),
    );
  }

  Future<void> _getCompletedTask() async {
    if (mounted) {
      setState(() {
        _inProgess = true;
      });
    }
    NetworkResponse response =
        await NetworkCaller.getRequest(Urls.completedTask);

    if (response.isSuccess) {
      TaskListWraperModel taskListWraperModel =
          TaskListWraperModel.fromJson(response.responseData);
      compeletedTaskList = taskListWraperModel.taskList ?? [];
    } else {
      if (mounted) {
        showSnackBarMessage(
            context, response.errorMessage ?? 'Get completed task failed! try again');
      }
    }
    if (mounted) {
      setState(() {
        _inProgess = false;
      });
    }
  }
}
