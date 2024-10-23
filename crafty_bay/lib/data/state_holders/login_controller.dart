import 'package:crafty_bay/data/model/network_server_response.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utils/server_urls.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  bool _loading = false;

  bool get loading => _loading;
  String? _errorMessage;

  String? get errorMessage => _errorMessage;
  String _serverMessage = '';

  String get serverMessage => _serverMessage;

  Future<bool> logIn({required String email}) async {
    _loading = true;
    update();
    bool success;
    NetworkServerResponse networkServerResponse =
        await Get.find<NetworkCaller>()
            .getResponse(url: ServerURLSs.logInUrl(email: email), token: '');
    if (networkServerResponse.isSuccess&&networkServerResponse.responseBody["msg"].toString()=="success") {
      _loading = false;
      success = true;
      _errorMessage = null;
      _serverMessage = networkServerResponse.responseBody["data"].toString();
    } else {
      _loading = false;
      success = false;
      _errorMessage = 'Something went wrong';
    }
    update();
    return success;
  }
}
