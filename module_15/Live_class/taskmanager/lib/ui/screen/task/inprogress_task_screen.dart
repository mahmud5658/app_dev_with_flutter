import 'package:flutter/material.dart';
import 'package:taskmanager/data/model/network_response.dart';
import 'package:taskmanager/data/model/task_list_wraper_model.dart';
import 'package:taskmanager/data/model/task_model.dart';
import 'package:taskmanager/data/network_caller/network_caller.dart';
import 'package:taskmanager/data/utilities/url.dart';
import 'package:taskmanager/ui/widgets/snack_bar_message.dart';
import 'package:taskmanager/ui/widgets/task_item.dart';

class InProgressTaskScreen extends StatefulWidget {
  const InProgressTaskScreen({Key? key}) : super(key: key);

  @override
  State<InProgressTaskScreen> createState() => _InProgressTaskScreenState();
}

class _InProgressTaskScreenState extends State<InProgressTaskScreen> {
  bool _inProgess = false;
  List<TaskModel> inProgressTaskList = [];

  @override
  void initState() {
    super.initState();
    _getInProgressTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 8, right: 8, left: 8),
        child: RefreshIndicator(
          onRefresh: () async {
            _getInProgressTask();
          },
          child: Visibility(
            visible: _inProgess == false,
            replacement: const Center(
              child: CircularProgressIndicator(),
            ),
            child: ListView.builder(
                itemCount: inProgressTaskList.length,
                itemBuilder: (context, index) {
                  return TaskItem(
                    taskModel: inProgressTaskList[index],
                    onUpdateTask: () {
                      _getInProgressTask();
                    },
                  );
                }),
          ),
        ),
      ),
    );
  }

  Future<void> _getInProgressTask() async {
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
      inProgressTaskList = taskListWraperModel.taskList ?? [];
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
