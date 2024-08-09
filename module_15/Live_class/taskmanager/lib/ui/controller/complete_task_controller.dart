import 'package:get/get.dart';
import 'package:taskmanager/data/model/network_response.dart';
import 'package:taskmanager/data/model/task_list_wraper_model.dart';
import 'package:taskmanager/data/model/task_model.dart';
import 'package:taskmanager/data/network_caller/network_caller.dart';
import 'package:taskmanager/data/utilities/url.dart';

class CompleteTaskController extends GetxController {
  bool isSuccess = false;
  bool _completeInProgress = false;
  bool get completeInProgress => _completeInProgress;
  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  List<TaskModel> _completeTaskList = [];
  List<TaskModel> get completeTaskList => _completeTaskList;

  Future<bool> getCompletedTask() async {
    _completeInProgress = true;
    update();
    NetworkResponse response =
        await NetworkCaller.getRequest(Urls.completedTask);

    if (response.isSuccess) {
      isSuccess = true;
      TaskListWraperModel taskListWraperModel =
          TaskListWraperModel.fromJson(response.responseData);
      _completeTaskList = taskListWraperModel.taskList ?? [];
    } else {
      _errorMessage = response.errorMessage ?? "failed please try again";
    }
    _completeInProgress = false;
    update();
    return true;
  }
}
