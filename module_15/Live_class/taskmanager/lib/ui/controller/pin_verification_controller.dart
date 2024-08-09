import 'package:get/get.dart';
import 'package:taskmanager/data/model/network_response.dart';
import 'package:taskmanager/data/network_caller/network_caller.dart';
import 'package:taskmanager/data/utilities/url.dart';

class PinVerificationController extends GetxController {
  bool _pinInProgress = false;
  bool get pinInProgress => _pinInProgress;
  bool isSuccess = false;
  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  Future<bool> pinVerify(email, pin) async {
    _pinInProgress = true;
    update();
    NetworkResponse response =
        await NetworkCaller.getRequest(Urls.verifyOtp(email, pin));

    if (response.isSuccess) {
      isSuccess = true;
    } else {
      _errorMessage =
          response.errorMessage ?? "Pin verification failed! please try again";
    }
    return isSuccess;
  }
}
