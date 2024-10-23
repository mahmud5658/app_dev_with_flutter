import 'package:crafty_bay/data/model/network_server_response.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/state_holders/cart_list_controller.dart';
import 'package:crafty_bay/data/state_holders/token_controller.dart';
import 'package:crafty_bay/data/state_holders/profile_state.dart';
import 'package:crafty_bay/data/state_holders/wish_list_controller.dart';
import 'package:crafty_bay/data/utils/server_urls.dart';
import 'package:get/get.dart';

class PinVerifyController extends GetxController {
  bool _loading = false;

  bool get loading => _loading;
  String? _errorMessage;

  bool _profileExist = false;
  bool get profileExist => _profileExist;

  String? get errorMessage => _errorMessage;
  String _serverMessage = '';

  String get serverMessage => _serverMessage;

  Future<bool> verify({required String email, required String oTP}) async {
    _loading = true;
    update();
    bool success;
    NetworkServerResponse networkServerResponse =
        await Get.find<NetworkCaller>()
            .getResponse(url: ServerURLSs.authUrl(email: email, oTP: oTP), token: '');
    if (networkServerResponse.isSuccess&&networkServerResponse.responseBody["msg"].toString()=="success") {
      await TokenController.updateToken(token: networkServerResponse.responseBody["data"].toString());
      _serverMessage = networkServerResponse.responseBody["msg"].toString();
      success = true;
      _profileExist = await ProfileState.checkProfileState();
      Get.find<CartListController>().getCarts();
      Get.find<WishListController>().getUserWishes();
      _loading = false;
      _errorMessage = null;
    } else {
      _loading = false;
      success = false;
      _errorMessage = networkServerResponse.errorMessage??'Something went wrong';
    }
    update();
    return success;
  }
}
