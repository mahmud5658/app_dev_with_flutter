import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmanager/ui/controller/new_task_controller.dart';
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
  final NewTaskController newTaskController = Get.find<NewTaskController>();

  @override
  void initState() {
    super.initState();
    initCall();
  }

  void initCall() {
    getNewTask();
    getNewTaskCount();
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
              child: RefreshIndicator(onRefresh: () async {
                initCall();
              }, child:
                  GetBuilder<NewTaskController>(builder: (newTaskController) {
                return Visibility(
                  visible: newTaskController.newInProgress == false,
                  replacement: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: ListView.builder(
                    itemCount: newTaskController.newTaskProgressTaskList.length,
                    itemBuilder: (context, index) {
                      return TaskItem(
                        taskModel:
                            newTaskController.newTaskProgressTaskList[index],
                        onUpdateTask: () {
                          initCall();
                        },
                      );
                    },
                  ),
                );
              })),
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
    return GetBuilder<NewTaskController>(builder: (newTaskController) {
      return Visibility(
        visible: newTaskController.newInProgressCount == false,
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              children: newTaskController.newTaskProgressTaskListCount.map((e) {
            return TaskSummaryCard(
              title: (e.sId ?? 'Unknown').toUpperCase(),
              count: e.sum.toString(),
            );
          }).toList()),
        ),
      );
    });
  }

  void getNewTask() async {
    final result = await newTaskController.getNewTask();
    if (result == false) {
      if (mounted) {
        showSnackBarMessage(context, newTaskController.errorMessage);
      }
    }
  }

  void getNewTaskCount() async {
    final result = await newTaskController.getTaskCountByStatus();
    if (result == false) {
      if (mounted) {
        showSnackBarMessage(context, newTaskController.errorMessageCount);
      }
    }
  }
}
