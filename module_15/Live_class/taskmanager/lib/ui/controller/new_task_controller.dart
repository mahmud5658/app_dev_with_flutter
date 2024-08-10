import 'package:get/get.dart';
import 'package:taskmanager/data/model/network_response.dart';
import 'package:taskmanager/data/model/task_by_count_wrapper_model.dart';
import 'package:taskmanager/data/model/task_count_by_status_model.dart';
import 'package:taskmanager/data/model/task_list_wraper_model.dart';
import 'package:taskmanager/data/model/task_model.dart';
import 'package:taskmanager/data/network_caller/network_caller.dart';
import 'package:taskmanager/data/utilities/url.dart';

class NewTaskController extends GetxController {
  bool isSuccess = false;
  bool _newInProgress = false;
  bool get newInProgress => _newInProgress;
  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  List<TaskModel> _newTaskProgressTaskList = [];
  List<TaskModel> get newTaskProgressTaskList => _newTaskProgressTaskList;

  bool isSuccessCount = false;
  bool _newInProgressCount = false;
  bool get newInProgressCount => _newInProgressCount;
  String _errorMessageCount = '';
  String get errorMessageCount => _errorMessageCount;

  List<TaskCountByStatusModel> _newTaskProgressTaskListCount = [];
  List<TaskCountByStatusModel> get newTaskProgressTaskListCount =>
      _newTaskProgressTaskListCount;

  Future<bool> getNewTask() async {
    _newInProgress = true;
    update();
    NetworkResponse response = await NetworkCaller.getRequest(Urls.newTask);

    if (response.isSuccess) {
      isSuccess = true;
      TaskListWraperModel taskListWraperModel =
          TaskListWraperModel.fromJson(response.responseData);
      _newTaskProgressTaskList = taskListWraperModel.taskList ?? [];
    } else {
      _errorMessage = response.errorMessage ?? "failed try again";
    }
    _newInProgress = false;
    update();
    return isSuccess;
  }

  Future<bool> getTaskCountByStatus() async {
    _newInProgressCount = true;
    update();
    NetworkResponse response =
        await NetworkCaller.getRequest(Urls.taskStatusCount);

    if (response.isSuccess) {
      isSuccessCount = true;
      TaskCountByStatusWrapperModel taskCountByStatusWrapperModel =
          TaskCountByStatusWrapperModel.fromJson(response.responseData);
      _newTaskProgressTaskListCount =
          taskCountByStatusWrapperModel.taskCountByStatusList ?? [];
    } else {
      _errorMessageCount = response.errorMessage ?? "failed try again";
    }
    _newInProgressCount = false;
    update();
    return isSuccessCount;
  }
}
