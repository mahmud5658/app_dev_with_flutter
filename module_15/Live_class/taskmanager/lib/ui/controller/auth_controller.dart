import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskmanager/data/model/user_model.dart';

class AuthController {
  static String accessToken = '';
  static const String _accessTokenKey = 'access_token';
  static const String _userDataKey = 'user_data';
  static UserModel? userData ;

  static Future<void> saveUserAccessToken(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_accessTokenKey, token);
    accessToken = token;
  }

  static Future<String?> getUserAccessToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(_accessTokenKey);
  }

  static Future<void> saveUserData(UserModel userModel) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(
        _userDataKey, jsonEncode(userModel.toJson()));

    userData = userModel;
  }

  static Future<UserModel?> getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? data = sharedPreferences.getString(_userDataKey);
    if (data == null) {
      return null;
    }
    UserModel userModel = UserModel.fromJson(jsonDecode(data));
    return userModel;
  }

  static Future<bool> checkAuthState() async {
    String? token = await getUserAccessToken();
    if (token == null) {
      return false;
    }
    accessToken = token;
    userData = (await getUserData())!;
    return true;
  }

  static Future<void> clearAllData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }
}
