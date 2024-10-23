import 'package:crafty_bay/data/model/network_server_response.dart';
import 'package:crafty_bay/data/model/product.dart';
import 'package:crafty_bay/data/model/product_list.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utils/server_urls.dart';
import 'package:get/get.dart';

class ProductListByCategoriesController extends GetxController{
  bool _loading = false;
  String? _errorMessage;
  List<Product> _productList = [];
  List<Product> get productList => _productList;
  String? get errorMessage => _errorMessage;
  bool get loading => _loading;

  Future<bool> getProductListByCategory(String id) async{
    bool success;
    _loading = true;
    update();
    NetworkServerResponse networkServerResponse = await Get.find<NetworkCaller>().getResponse(url: ServerURLSs.productListByCategoryUrl(id), token: '');
    if(networkServerResponse.isSuccess){
      success =true;
      _errorMessage = null;
      _productList=ProductList.fromJson(networkServerResponse.responseBody).products??[];
      _loading = false;
    }else{
      _loading = false;
      _errorMessage = networkServerResponse.errorMessage;
      success = false;
    }
    update();
    return success;
  }
}