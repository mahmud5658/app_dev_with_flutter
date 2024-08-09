import 'package:get/get.dart';
import 'package:taskmanager/data/model/network_response.dart';
import 'package:taskmanager/data/model/task_list_wraper_model.dart';
import 'package:taskmanager/data/model/task_model.dart';
import 'package:taskmanager/data/network_caller/network_caller.dart';
import 'package:taskmanager/data/utilities/url.dart';

class InProgressTaskController extends GetxController {
  bool isSuccess = false;
  bool _inProgress = false;
  bool get inProgress => _inProgress;
  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  List<TaskModel> _inProgressTaskList = [];
  List<TaskModel> get inProgressTaskList => _inProgressTaskList;

  Future<bool> getInProgressTask() async {
    _inProgress = true;
    update();
    NetworkResponse response =
        await NetworkCaller.getRequest(Urls.inProgressTask);

    if (response.isSuccess) {
      isSuccess = true;
      TaskListWraperModel taskListWraperModel =
          TaskListWraperModel.fromJson(response.responseData);
      _inProgressTaskList = taskListWraperModel.taskList ?? [];
    } else {
      _errorMessage = response.errorMessage ?? "failed try again";
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
