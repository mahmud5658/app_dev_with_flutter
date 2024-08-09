import 'package:get/get.dart';
import 'package:taskmanager/data/model/network_response.dart';
import 'package:taskmanager/data/network_caller/network_caller.dart';
import 'package:taskmanager/data/utilities/url.dart';

class ResetPasswordController extends GetxController {
  bool _resetInProgress = false;
  bool get resetInProgress => _resetInProgress;
  bool isSuccess = false;
  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  Future<bool> resetPassword(email, otp, password) async {
    _resetInProgress = true;
    update();
    Map<String, dynamic> requestBody = {
      "email": email,
      "OTP": otp,
      "password": password,
    };

    NetworkResponse response =
        await NetworkCaller.postRequest(Urls.resetPassword, body: requestBody);

    if (response.isSuccess) {
      isSuccess = true;
    } else {
      _errorMessage =
          response.errorMessage ?? "password reset failed!Please try again";
    }
    _resetInProgress = false;
    update();

    return isSuccess;
  }
}
