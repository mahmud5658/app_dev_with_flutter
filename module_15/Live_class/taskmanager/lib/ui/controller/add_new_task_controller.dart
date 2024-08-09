import 'package:get/get.dart';
import 'package:taskmanager/data/model/network_response.dart';
import 'package:taskmanager/data/network_caller/network_caller.dart';
import 'package:taskmanager/data/utilities/url.dart';

class AddNewTaskController extends GetxController {
  bool isSuccess = false;
  bool _addInProgress = false;
  bool get addInProgress => _addInProgress;
  String _errorMessage = '';
  String get errorMessage => _errorMessage;
  Future<bool> addNewTask(title, description) async {
    _addInProgress = true;
    update();
    Map<String, dynamic> requestData = {
      "title": title,
      "description": description,
      "status": "New"
    };
    NetworkResponse response =
        await NetworkCaller.postRequest(Urls.createTask, body: requestData);

    if (response.isSuccess) {
      isSuccess = true;
    } else {
      _errorMessage =
          response.errorMessage ?? "add new task failed! please try again";
    }
    _addInProgress = false;
    update();
    return isSuccess;
  }
}
