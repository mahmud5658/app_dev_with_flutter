import 'package:get/get.dart';
import 'package:taskmanager/data/model/login_model.dart';
import 'package:taskmanager/data/model/network_response.dart';
import 'package:taskmanager/data/network_caller/network_caller.dart';
import 'package:taskmanager/data/utilities/url.dart';
import 'package:taskmanager/ui/controller/auth_controller.dart';

class SignInController extends GetxController {
  bool _logInProgress = false;
  bool get logInProgress => _logInProgress;
  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  Future<bool> logIn(email, password) async {
    bool isSuccess = false;
    _logInProgress = true;
    update();
    Map<String, dynamic> requestInput = {
      "email": email,
      "password": password,
    };
    NetworkResponse response =
        await NetworkCaller.postRequest(Urls.login, body: requestInput);

    if (response.isSuccess) {
      LoginModel loginModel = LoginModel.fromJson(response.responseData);

      await AuthController.saveUserAccessToken(loginModel.token!);
      await AuthController.saveUserData(loginModel.userModel!);
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage ?? "Login failed! please try again";
    }
    _logInProgress = false;
    update();
    return isSuccess;
  }
}
