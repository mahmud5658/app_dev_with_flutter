import 'dart:convert';
import 'package:taskmanager/style/style.dart';
import 'package:http/http.dart' as http;

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
    return true;
  } else {
    errorToast('Request failed! Try agian!!!');
    return false;
  }
}
