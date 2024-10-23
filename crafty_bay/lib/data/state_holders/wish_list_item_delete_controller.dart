import 'package:crafty_bay/data/model/network_server_response.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/state_holders/token_controller.dart';
import 'package:crafty_bay/data/utils/server_urls.dart';
import 'package:get/get.dart';

class WishListItemDeleteController extends GetxController {
  bool _loading = false;

  bool get loading => _loading;

  Future<bool> delete({required String productId}) async {
    _loading =true;
    update();
    late bool success;
    String token = await TokenController.getToken() ?? '';
    NetworkServerResponse networkServerResponse =
        await Get.find<NetworkCaller>().getResponse(
            url: ServerURLSs.deleteFromWishList(productId: productId),
            token: token);
    if(networkServerResponse.isSuccess&&networkServerResponse.responseBody["msg"].toString() == "success"){
      _loading = false;
      success = true;
    }else{
      _loading = false;
      success = false;
    }
    update();
    return success;
  }
}
