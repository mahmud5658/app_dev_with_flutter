import 'package:shared_preferences/shared_preferences.dart';

class TokenController{
  static Future<void> updateToken({required String token})async{
    final SharedPreferences localCache = await SharedPreferences.getInstance();
    await localCache.setString('token', token);
  }

  static Future<String?> getToken() async{
    final SharedPreferences localCache = await SharedPreferences.getInstance();
    String? loginToken = localCache.getString('token');
    return loginToken;
  }
}