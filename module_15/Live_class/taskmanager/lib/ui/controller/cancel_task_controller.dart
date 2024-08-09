import 'package:get/get.dart';
import 'package:taskmanager/data/model/network_response.dart';
import 'package:taskmanager/data/model/task_list_wraper_model.dart';
import 'package:taskmanager/data/model/task_model.dart';
import 'package:taskmanager/data/network_caller/network_caller.dart';
import 'package:taskmanager/data/utilities/url.dart';

class CancelTaskController extends GetxController {
  bool isSuccess = false;
  bool _cancelInProgress = false;
  bool get cancelInProgress => _cancelInProgress;
  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  List<TaskModel> _canceledTaskList = [];
  List<TaskModel> get canceledTaskList => _canceledTaskList;

  Future<bool> getCanceledTask() async {
    _cancelInProgress = true;
    update();
    NetworkResponse response = await NetworkCaller.getRequest(Urls.cancelTask);

    if (response.isSuccess) {
      isSuccess = true;
      TaskListWraperModel taskListWraperModel =
          TaskListWraperModel.fromJson(response.responseData);
      _canceledTaskList = taskListWraperModel.taskList ?? [];
    } else {
      _errorMessage =
          response.errorMessage ?? "cancel task load failed! please try again";
    }

    _cancelInProgress = false;
    update();
    return isSuccess;
  }
}
