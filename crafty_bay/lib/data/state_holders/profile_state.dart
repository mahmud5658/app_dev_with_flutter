import 'package:crafty_bay/data/model/network_server_response.dart';
import 'package:crafty_bay/data/model/read_profile_data.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/state_holders/profile_info_cache_controller.dart';
import 'package:crafty_bay/data/state_holders/token_controller.dart';
import 'package:crafty_bay/data/utils/server_urls.dart';
import 'package:get/get.dart';

import '../model/profile.dart';

class ProfileState {
  static Future<bool> checkProfileState() async {
    bool profileExist;
    String? token = await TokenController.getToken();
    if (token != null) {
      NetworkServerResponse networkServerResponse =
          await Get.find<NetworkCaller>()
              .getResponse(url: ServerURLSs.readProfile, token: token);
      if (networkServerResponse.isSuccess &&
          networkServerResponse.responseBody["data"] != null &&
          networkServerResponse.responseBody["msg"] == 'success') {
        ProfileInfoCacheController.updateProfile(
          profileData:
              ReadProfileData.fromJson(networkServerResponse.responseBody)
                      .data ??
                  Profile(),
        );
        profileExist = true;
      } else {
        profileExist = false;
      }
    } else {
      profileExist = false;
    }
    return profileExist;
  }
}
