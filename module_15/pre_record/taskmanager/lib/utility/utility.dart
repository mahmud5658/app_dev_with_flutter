import 'package:shared_preferences/shared_preferences.dart';

Future<void> writeUserData(userData) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  await prefs.setString('token', userData['token']);
  await prefs.setString('email', userData['data']['email']);
  await prefs.setString('firstName', userData['data']['firstName']);
  await prefs.setString('lastName', userData['data']['lastName']);
  await prefs.setString('mobile', userData['data']['mobile']);
  await prefs.setString('photo', userData['data']['photo']);
}



Future<void> writeEmail(email)async{
  final SharedPreferences prefs = await SharedPreferences.getInstance();
   await prefs.setString('emailVerification',email);

}
Future<void> writeOpt(otp) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('otpVerification', otp);

}
Future<String?> readUserData(key) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String? userData = await prefs.getString(key);
  return userData;
}
