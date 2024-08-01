import 'package:flutter/material.dart';
import 'package:taskmanager/data/model/network_response.dart';
import 'package:taskmanager/data/model/task_by_count_wrapper_model.dart';
import 'package:taskmanager/data/model/task_count_by_status_model.dart';
import 'package:taskmanager/data/model/task_list_wraper_model.dart';
import 'package:taskmanager/data/model/task_model.dart';
import 'package:taskmanager/data/network_caller/network_caller.dart';
import 'package:taskmanager/data/utilities/url.dart';
import 'package:taskmanager/ui/screen/task/add_new_task_screen.dart';
import 'package:taskmanager/ui/widgets/snack_bar_message.dart';
import 'package:taskmanager/ui/widgets/task_item.dart';
import 'package:taskmanager/ui/widgets/task_summary_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({Key? key}) : super(key: key);

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool _inProgess = false;
  bool _taskCountProgress = false;

  List<TaskModel> newTaskList = [];
  List<TaskCountByStatusModel> taskCountByStatuslist = [];

  @override
  void initState() {
    super.initState();
    _getNewTask();
    _getTaskCountByStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 8, right: 8, left: 8),
        child: Column(
          children: [
            _buildSummarySection(),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  _getNewTask();
                  _getTaskCountByStatus();
                },
                child: Visibility(
                  visible: _inProgess == false,
                  replacement: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: ListView.builder(
                    itemCount: newTaskList.length,
                    itemBuilder: (context, index) {
                      return TaskItem(
                        taskModel: newTaskList[index],
                        onUpdateTask: () {
                          _getNewTask();
                          _getTaskCountByStatus();
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        onPressed: () async {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddNewTaskScreen()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildSummarySection() {
    return Visibility(
      visible: _taskCountProgress == false,
      replacement: const Center(
        child: CircularProgressIndicator(),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
            children: taskCountByStatuslist.map((e) {
          return TaskSummaryCard(
            title: (e.sId ?? 'Unknown').toUpperCase(),
            count: e.sum.toString(),
          );
        }).toList()),
      ),
    );
  }

  Future<void> _getNewTask() async {
    if (mounted) {
      setState(() {
        _inProgess = true;
      });
    }
    NetworkResponse response = await NetworkCaller.getRequest(Urls.newTask);

    if (response.isSuccess) {
      TaskListWraperModel taskListWraperModel =
          TaskListWraperModel.fromJson(response.responseData);
      newTaskList = taskListWraperModel.taskList ?? [];
    } else {
      if (mounted) {
        showSnackBarMessage(
            context, response.errorMessage ?? 'Get New task failed! try again');
      }
    }
    if (mounted) {
      setState(() {
        _inProgess = false;
      });
    }
  }

  Future<void> _getTaskCountByStatus() async {
    if (mounted) {
      setState(() {
        _taskCountProgress = true;
      });
    }
    NetworkResponse response =
        await NetworkCaller.getRequest(Urls.taskStatusCount);

    if (response.isSuccess) {
      TaskCountByStatusWrapperModel taskCountByStatusWrapperModel =
          TaskCountByStatusWrapperModel.fromJson(response.responseData);
      taskCountByStatuslist =
          taskCountByStatusWrapperModel.taskCountByStatusList ?? [];
    } else {
      if (mounted) {
        showSnackBarMessage(
            context,
            response.errorMessage ??
                'Get  task count by status failed! try again');
      }
    }
    if (mounted) {
      setState(() {
        _taskCountProgress = false;
      });
    }
  }
}
