import 'package:crafty_bay/data/model/network_server_response.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/state_holders/token_controller.dart';
import 'package:crafty_bay/data/state_holders/profile_state.dart';
import 'package:crafty_bay/data/utils/server_urls.dart';
import 'package:get/get.dart';

class WishlistAdditionController extends GetxController {
  bool _loading = false;

  bool get loading => _loading;

  Future<bool> addToWishList({required String productId}) async {
    _loading = true;
    bool success;
    update();
    final String? accessToken = await TokenController.getToken();
    if (accessToken != null) {
      NetworkServerResponse networkServerResponse =
          await Get.find<NetworkCaller>().getResponse(
              url: ServerURLSs.addToWishList(productId: productId),
              token: accessToken);
      if (networkServerResponse.isSuccess &&
          networkServerResponse.responseBody["msg"].toString() == "success") {
        _loading = false;
        success = true;
      } else {
        _loading = false;
        success = false;
      }
    } else {
      _loading = false;
      success = false;
    }
    update();
    return success;
  }
}
