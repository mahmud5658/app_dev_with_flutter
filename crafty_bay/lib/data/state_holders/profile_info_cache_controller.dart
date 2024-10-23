import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/create_profile_data.dart';
import '../model/profile.dart';

class ProfileInfoCacheController {
  static Future<void> updateProfile(
      {required Profile profileData}) async {
    final SharedPreferences localCache = await SharedPreferences.getInstance();
    await localCache.setString('profileData', jsonEncode(profileData.toJson()));
  }

  static Future<Profile?> getProfile() async {
    final SharedPreferences localCache = await SharedPreferences.getInstance();
    String? profileData = localCache.getString('profileData');
    if(profileData==null){
      return null;
    }else{
      return Profile.fromJson(jsonDecode(profileData));
    }
  }
}
