import 'package:crafty_bay/data/model/add_to_cart.dart';
import 'package:crafty_bay/data/model/network_server_response.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/state_holders/token_controller.dart';
import 'package:crafty_bay/data/state_holders/profile_state.dart';
import 'package:crafty_bay/data/utils/server_urls.dart';
import 'package:get/get.dart';

class CreateCartController extends GetxController {
  bool _loading = false;

  bool get loading => _loading;

  Future<bool> createCart(AddToCart cart) async {
    _loading = true;
    update();
    final String? accessToken =  await TokenController.getToken();
    if (accessToken!=null) {
      NetworkServerResponse networkServerResponse = await Get.find<
          NetworkCaller>().postResponse(
          url: ServerURLSs.createCart, token: accessToken, dataToPost:cart.toJson());
      if(networkServerResponse.isSuccess){
        _loading = false;
        update();
        return true;
      }else{
        _loading = false;
        update();
        return false;
      }
    } else {
      _loading = false;
      update();
      return false;
    }
  }
}