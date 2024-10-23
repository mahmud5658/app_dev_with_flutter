import 'package:crafty_bay/data/model/network_server_response.dart';
import 'package:crafty_bay/data/model/product_details_data.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utils/server_urls.dart';
import 'package:get/get.dart';
import '../model/product_details.dart';

class ProductDetailsController extends GetxController {
  bool _loading = false;
  String? _errorMessage;
  ProductDetailsData? _productDetailsData;

  ProductDetailsData? get productDetailsData => _productDetailsData;

  String? get errorMessage => _errorMessage;

  bool get loading => _loading;

  Future<bool> getProductDetails(String id) async {
    bool success;
    _loading = true;
    update();
    NetworkServerResponse networkServerResponse =
        await Get.find<NetworkCaller>()
            .getResponse(url: ServerURLSs.productDetailsUrl(id), token: '');
    if (networkServerResponse.isSuccess) {
      success = true;
      _errorMessage = null;
      _productDetailsData =
          ProductDetails.fromJson(networkServerResponse.responseBody)
              .productData
              ?.first;
      _loading = false;
    } else {
      _loading = false;
      _errorMessage = networkServerResponse.errorMessage;
      success = false;
    }
    update();
    return success;
  }
}
