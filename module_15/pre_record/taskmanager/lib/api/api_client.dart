import 'dart:convert';
import 'package:taskmanager/style/style.dart';
import 'package:http/http.dart' as http;
import 'package:taskmanager/utility/utility.dart';

var baseUrl = "https://task.teamrabbil.com/api/v1";
var requestHeader = {'Content-Type': 'application/json'};

Future<bool> loginRequest(formValues) async {
  var url = Uri.parse("$baseUrl/login");
  var postBody = jsonEncode(formValues);

  var response = await http.post(url, headers: requestHeader, body: postBody);
  var resultCode = response.statusCode;
  var resultBody = jsonDecode(response.body);
  if (resultCode == 200 && resultBody['status'] == 'success') {
    successToast("Request Success");
    await writeUserData(resultBody);
    return true;
  } else {
    errorToast('Request failed! Try agian!!!');
    return false;
  }
}

Future<bool> registrationRequest(formValues) async {
  var url = Uri.parse("$baseUrl/registration");
  var postBody = jsonEncode(formValues);
  var response = await http.post(url, headers: requestHeader, body: postBody);
  var resultCode = response.statusCode;
  var resultBody = jsonDecode(response.body);
  if (resultCode == 200 && resultBody['status'] == 'success') {
    successToast("Request Success");
    return true;
  } else {
    errorToast('Request failed! Try agian!!!');
    return false;
  }
}

Future<bool> verifyEmailRequest(email) async {
  var url = Uri.parse("$baseUrl/RecoverVerifyEmail/$email");
  var response = await http.get(url, headers: requestHeader);
  var resultCode = response.statusCode;
  var resultBody = jsonDecode(response.body);
  if (resultCode == 200 && resultBody['status'] == 'success') {
    await writeEmail(email);
    successToast("Request Success");
    return true;
  } else {
    errorToast('Request failed! Try agian!!!');
    return false;
  }
}

Future<bool> verifyOtpRequest(email, otp) async {
  var url = Uri.parse("$baseUrl/RecoverVerifyOTP/$email/$otp");
  var response = await http.get(
    url,
    headers: requestHeader,
  );
  var resultCode = response.statusCode;
  var resultBody = jsonDecode(response.body);
  if (resultCode == 200 && resultBody['status'] == 'success') {
    await writeOpt(otp);
    successToast("Request Success");
    return true;
  } else {
    errorToast('Request failed! Try agian!!!');
    return false;
  }
}
Future<bool> setPasswordRequest(formValues) async {
  var url = Uri.parse("$baseUrl/RecoverResetPass");
  var postBody = jsonEncode(formValues);
  var response = await http.post(url, headers: requestHeader, body: postBody);
  var resultCode = response.statusCode;
  var resultBody = jsonDecode(response.body);
  if (resultCode == 200 && resultBody['status'] == 'success') {
    successToast("Request Success");
    return true;
  } else {
    errorToast('Request failed! Try agian!!!');
    return false;
  }
}
