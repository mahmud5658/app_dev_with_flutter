import 'package:crafty_bay/data/model/cart_list.dart';
import 'package:crafty_bay/data/model/network_server_response.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utils/server_urls.dart';
import 'package:get/get.dart';
import 'package:crafty_bay/data/state_holders/token_controller.dart';
import 'package:crafty_bay/data/state_holders/profile_state.dart';

import '../model/cart.dart';

class CartListController extends GetxController {
  bool _loading = false;
  List<Cart> _carts = [];
  int _totalPrice = 0;
  int get totalPrice => _totalPrice;

  bool get loading => _loading;

  List<Cart> get carts => _carts;

  Future<bool> getCarts() async {
    _loading = true;
    bool success;
    update();
    final String? accessToken =  await TokenController.getToken();
    if (accessToken!=null) {
      NetworkServerResponse networkServerResponse =
          await Get.find<NetworkCaller>()
              .getResponse(url: ServerURLSs.fetchCarts, token: accessToken);
      if(networkServerResponse.isSuccess){
        _loading = false;
        _carts = CartList.fromJson(networkServerResponse.responseBody).data??[];
        _totalPrice = 0;
        for (Cart cart in _carts) {
          _totalPrice += int.parse(cart.price ?? '0');
        }
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
