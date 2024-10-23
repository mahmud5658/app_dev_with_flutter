import 'package:crafty_bay/data/model/home_slider_list.dart';
import 'package:crafty_bay/data/model/network_server_response.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utils/server_urls.dart';
import 'package:get/get.dart';
import '../model/home_slider.dart';

class HomeSliderController extends GetxController {
  List<HomeSlider> _sliders = [];
  bool _loading = false;
  String? _errorMessage;

  List<HomeSlider> get sliders => _sliders;

  bool get loading => _loading;

  String get errorMessage => _errorMessage ?? '';

  Future<bool> getHomeSliders() async {
    bool success;
    _loading = true;
    update();
    final NetworkServerResponse networkServerResponse =
        await Get.find<NetworkCaller>()
            .getResponse(url: ServerURLSs.homeSliderListUrl, token: '');
    if (networkServerResponse.isSuccess) {
      success = true;
      _errorMessage = null;
      _sliders = HomeSliderList.fromJson(networkServerResponse.responseBody)
              .homeSliders ??
          [];
      _loading = false;
      update();
    } else {
      success = false;
      _errorMessage = networkServerResponse.errorMessage;
      _loading = false;
      update();
    }
    return success;
  }
}
