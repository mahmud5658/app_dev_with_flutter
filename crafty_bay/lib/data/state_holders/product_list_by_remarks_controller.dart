import 'package:crafty_bay/data/model/network_server_response.dart';
import 'package:crafty_bay/data/model/product.dart';
import 'package:crafty_bay/data/model/product_list.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utils/server_urls.dart';
import 'package:get/get.dart';

class ProductListByRemarksController extends GetxController{
  bool _loading = false;
  String? _errorMessage;
  List<Product> _popularProductList = [];
  List<Product> _newProductList = [];
  List<Product> _specialProductList = [];
  List<Product> get popularProductList => _popularProductList;
  List<Product> get newProductList => _newProductList;
  List<Product> get specialProductList => _specialProductList;
  String? get errorMessage => _errorMessage;
  bool get loading => _loading;

  Future<bool> getProductListByRemarks() async{
    bool success;
    _loading = true;
    update();
    NetworkServerResponse popularProducts = await Get.find<NetworkCaller>().getResponse(url: ServerURLSs.popularProductList, token: '');
    NetworkServerResponse newProducts = await Get.find<NetworkCaller>().getResponse(url: ServerURLSs.newProductList, token: '');
    NetworkServerResponse specialProducts = await Get.find<NetworkCaller>().getResponse(url: ServerURLSs.specialProductList, token: '');
    if(popularProducts.isSuccess&&newProducts.isSuccess&&specialProducts.isSuccess){
      success =true;
      _errorMessage = null;
      _popularProductList= ProductList.fromJson(popularProducts.responseBody).products??[];
      _newProductList = ProductList.fromJson(newProducts.responseBody).products??[];
      _specialProductList=ProductList.fromJson(specialProducts.responseBody).products??[];
      _loading = false;
    }else{
      _loading = false;
      _errorMessage = popularProducts.errorMessage;
      success = false;
    }
    update();
    return success;
  }
}