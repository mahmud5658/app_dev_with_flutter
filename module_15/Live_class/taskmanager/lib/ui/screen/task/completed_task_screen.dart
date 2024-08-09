import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmanager/ui/controller/complete_task_controller.dart';
import 'package:taskmanager/ui/widgets/snack_bar_message.dart';
import 'package:taskmanager/ui/widgets/task_item.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({Key? key}) : super(key: key);

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  final CompleteTaskController completeTaskController =
      Get.find<CompleteTaskController>();

  @override
  void initState() {
    super.initState();
    getCompleteTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 8, right: 8, left: 8),
        child: RefreshIndicator(onRefresh: () async {
          getCompleteTask();
        }, child: GetBuilder<CompleteTaskController>(
            builder: (completeTaskController) {
          return Visibility(
            visible: completeTaskController.completeInProgress == false,
            replacement: const Center(
              child: CircularProgressIndicator(),
            ),
            child: ListView.builder(
                itemCount: completeTaskController.completeTaskList.length,
                itemBuilder: (context, index) {
                  return TaskItem(
                    taskModel: completeTaskController.completeTaskList[index],
                    onUpdateTask: () {
                      getCompleteTask();
                    },
                  );
                }),
          );
        })),
      ),
    );
  }

  void getCompleteTask() async {
    final result = await completeTaskController.getCompletedTask();
    if (result == false) {
      if (mounted) {
        showSnackBarMessage(context, completeTaskController.errorMessage);
      }
    }
  }
}
