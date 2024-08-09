import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmanager/ui/controller/in_progress_task_controller.dart';
import 'package:taskmanager/ui/widgets/snack_bar_message.dart';
import 'package:taskmanager/ui/widgets/task_item.dart';

class InProgressTaskScreen extends StatefulWidget {
  const InProgressTaskScreen({Key? key}) : super(key: key);

  @override
  State<InProgressTaskScreen> createState() => _InProgressTaskScreenState();
}

class _InProgressTaskScreenState extends State<InProgressTaskScreen> {
  final InProgressTaskController inProgressTaskController =
      Get.find<InProgressTaskController>();

  @override
  void initState() {
    super.initState();
    getInProgress();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 8, right: 8, left: 8),
        child: RefreshIndicator(
          onRefresh: () async {
            getInProgress();
          },
          child: GetBuilder<InProgressTaskController>(
              builder: (inProgressTaskController) {
            return Visibility(
              visible: inProgressTaskController.inProgress == false,
              replacement: const Center(
                child: CircularProgressIndicator(),
              ),
              child: ListView.builder(
                  itemCount: inProgressTaskController.inProgressTaskList.length,
                  itemBuilder: (context, index) {
                    return TaskItem(
                      taskModel:
                          inProgressTaskController.inProgressTaskList[index],
                      onUpdateTask: () {
                        getInProgress();
                      },
                    );
                  }),
            );
          }),
        ),
      ),
    );
  }

  void getInProgress() async {
    final result = await inProgressTaskController.getInProgressTask();
    if (result == false) {
      if (mounted) {
        showSnackBarMessage(context, inProgressTaskController.errorMessage);
      }
    }
  }
}
