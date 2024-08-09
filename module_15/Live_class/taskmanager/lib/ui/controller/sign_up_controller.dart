import 'package:get/get.dart';
import 'package:taskmanager/data/model/network_response.dart';
import 'package:taskmanager/data/network_caller/network_caller.dart';
import 'package:taskmanager/data/utilities/url.dart';

class SignUpController extends GetxController {
  bool _signUpProgress = false;
  bool get signUpInProgress => _signUpProgress;
  bool isSuccess = false;
  String _errorMessage = '';
  String get errorMessage => _errorMessage;
  Future<bool> signUp(email, firstName, lastName, mobile, password) async {
    _signUpProgress = true;
    update();
    Map<String, dynamic> requestInput = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
      "password": password,
      "photo": ''
    };
    NetworkResponse response =
        await NetworkCaller.postRequest(Urls.registration, body: requestInput);

    if (response.isSuccess) {
      isSuccess = true;
    } else {
      _errorMessage =
          response.errorMessage ?? "signUp failed! please try again";
    }
    _signUpProgress = false;
    update();
    return isSuccess;
  }
}
