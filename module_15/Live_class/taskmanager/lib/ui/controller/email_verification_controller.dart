import 'package:get/get.dart';
import 'package:taskmanager/data/model/network_response.dart';
import 'package:taskmanager/data/network_caller/network_caller.dart';
import 'package:taskmanager/data/utilities/url.dart';

class EmailVerificationController extends GetxController {
  bool _verifyInProgress = false;
  bool isSuccess = false;
  bool get verificationInProgress => _verifyInProgress;
  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  Future<bool> verifyEmail(email) async {
    _verifyInProgress = true;
    update();
    NetworkResponse response =
        await NetworkCaller.getRequest(Urls.verifyEmail(email));

    if (response.isSuccess) {
      isSuccess = true;
    } else {
       _errorMessage =  response.errorMessage ?? "email verification failed! please try again";
    }

    _verifyInProgress = false;
    update();
    return isSuccess;
  }
}
