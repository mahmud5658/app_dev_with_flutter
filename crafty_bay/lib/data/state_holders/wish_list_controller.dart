import 'package:crafty_bay/data/model/cart_list.dart';
import 'package:crafty_bay/data/model/network_server_response.dart';
import 'package:crafty_bay/data/model/wished_product.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utils/server_urls.dart';
import 'package:get/get.dart';
import 'package:crafty_bay/data/state_holders/token_controller.dart';
import 'package:crafty_bay/data/state_holders/profile_state.dart';

import '../model/cart.dart';
import '../model/wish_list.dart';

class WishListController extends GetxController {
  bool _loading = false;
  List<WishedProduct> _wishList = [];

  bool get loading => _loading;

  List<WishedProduct> get wishList => _wishList;

  Future<bool> getUserWishes() async {
    _loading = true;
    bool success;
    update();
    final String? accessToken =  await TokenController.getToken();
    if (accessToken!=null) {
      NetworkServerResponse networkServerResponse =
      await Get.find<NetworkCaller>()
          .getResponse(url: ServerURLSs.fetchWishList, token: accessToken);
      if(networkServerResponse.isSuccess){
        _loading = false;
        _wishList = WishList.fromJson(networkServerResponse.responseBody).products??[];
        success = true;
      }else{
        _loading = false;
        success = false;
      }
    }else{
      _loading = false;
      success =false;
    }
    update();
    return success;
  }
}
