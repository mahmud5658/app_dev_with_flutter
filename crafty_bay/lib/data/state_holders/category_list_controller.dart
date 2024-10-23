import 'package:crafty_bay/data/model/category_list.dart';
import 'package:crafty_bay/data/model/network_server_response.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utils/server_urls.dart';
import 'package:get/get.dart';
import '../model/category.dart';

class CategoryListController extends GetxController {
  bool _loading = false;

  bool get loading => _loading;
  String? _errorMessage;

  String get errorMessage => _errorMessage ?? '';
  List<Category> _categoryList = [];

  List<Category> get categoryList => _categoryList;

  Future<bool> getCategoryList() async {
    _loading = true;
    update();
    bool success;
    NetworkServerResponse networkServerResponse =
        await Get.find<NetworkCaller>()
            .getResponse(url: ServerURLSs.categoryListUrl, token: '');
    if (networkServerResponse.isSuccess) {
      _errorMessage = null;
      _categoryList = CategoryList.fromJson(networkServerResponse.responseBody)
              .categories ??
          [];
      success = true;
      _loading = false;
    } else {
      _loading = false;
      success = false;
      _errorMessage = networkServerResponse.errorMessage;
    }
    update();
    return success;
  }
}
