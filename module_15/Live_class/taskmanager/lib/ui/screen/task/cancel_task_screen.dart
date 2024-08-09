import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmanager/ui/controller/cancel_task_controller.dart';
import 'package:taskmanager/ui/widgets/snack_bar_message.dart';
import 'package:taskmanager/ui/widgets/task_item.dart';

class CancelTaskScreen extends StatefulWidget {
  const CancelTaskScreen({Key? key}) : super(key: key);

  @override
  State<CancelTaskScreen> createState() => _CancelTaskScreenState();
}

class _CancelTaskScreenState extends State<CancelTaskScreen> {
  final CancelTaskController cancelTaskController =
      Get.find<CancelTaskController>();

  @override
  void initState() {
    super.initState();
    getCanceledTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 8, right: 8, left: 8),
        child: RefreshIndicator(onRefresh: () async {
          getCanceledTask();
        }, child:
            GetBuilder<CancelTaskController>(builder: (cancelTaskController) {
          return Visibility(
            visible: cancelTaskController.cancelInProgress == false,
            replacement: const Center(
              child: CircularProgressIndicator(),
            ),
            child: ListView.builder(
                itemCount: cancelTaskController.canceledTaskList.length,
                itemBuilder: (context, index) {
                  return TaskItem(
                    taskModel: cancelTaskController.canceledTaskList[index],
                    onUpdateTask: () {
                      getCanceledTask();
                    },
                  );
                }),
          );
        })),
      ),
    );
  }

  void getCanceledTask() async {
    final result = await cancelTaskController.getCanceledTask();
    if (result == false) {
      if (mounted) {
        showSnackBarMessage(context, cancelTaskController.errorMessage);
      }
    }
  }
}
