import 'package:crafty_bay/data/model/create_profile_data.dart';
import 'package:get/get.dart';

import '../model/network_server_response.dart';
import '../services/network_caller.dart';
import '../utils/server_urls.dart';
import 'token_controller.dart';

class CreateProfileController extends GetxController{

  bool _loading = false;
  String? _errorMessage;


  bool get loading => _loading;

  String get errorMessage => _errorMessage ?? '';

  Future<bool> createProfile(CreateProfileData profileData) async {
    bool success;
    _loading = true;
    update();
    String? token = await TokenController.getToken();
    if(token!=null){
      final NetworkServerResponse networkServerResponse =
      await Get.find<NetworkCaller>().postResponse(url: ServerURLSs.createProfile, token: token,dataToPost: profileData.toJson());
      if (networkServerResponse.isSuccess) {
        success = true;
        _errorMessage = null;
        _loading = false;
        update();
      } else {
        success = false;
        _errorMessage = 'You need to login';
        _loading = false;
        update();
      }
    }else{
      success = false;
      _errorMessage = 'You need to login';
      _loading = false;
      update();
    }

    return success;
  }
}