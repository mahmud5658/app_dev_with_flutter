import 'dart:convert';
import 'package:crud/style/style.dart';
import 'package:http/http.dart' as http;

Future<bool> productDeleteRequest(id) async {
  var URL = Uri.parse('https://crud.teamrabbil.com/api/v1/DeleteProduct/' + id);
   var postHeader = {"Content-Type": "application/json"};
  var response = await http.get(URL,headers: postHeader);
  var resultCode = response.statusCode;
  var resultBody = jsonDecode(response.body);
  if (resultCode == 200 && resultBody['status'] == 'success') {
    successToast('Request success');
    return true;
  } else {
    errorToast('Request fail! try again');
    return false;
  }
}

Future<List> productGridViewRequest() async {
  var URL = Uri.parse('https://crud.teamrabbil.com/api/v1/ReadProduct/');
  var postHeader = {"Content-Type": "application/json"};
  var response = await http.get(URL, headers: postHeader);
  var resultCode = response.statusCode;
  var resultBody = jsonDecode(response.body);
  if (resultCode == 200 && resultBody['status'] == 'success') {
    successToast('Request success');
    return resultBody['data'];
  } else {
    errorToast('Request fail! try again');
    return [];
  }
}

Future<bool> productCreateRequest(formValues) async {
  var URL = Uri.parse('https://crud.teamrabbil.com/api/v1/CreateProduct');

  var postBody = jsonEncode(formValues);

  var postHeader = {"Content-Type": "application/json"};

  var response = await http.post(URL, headers: postHeader, body: postBody);
  var resultCode = response.statusCode;
  var resultBody = jsonDecode(response.body);

  if (resultCode == 200 && resultBody['status'] == "success") {
    successToast('Request Success');
    return true;
  } else {
    errorToast('Request fail! try again');
    return false;
  }
}

Future<bool> productUpdateRequest(formValues,id) async {
  var URL = Uri.parse('https://crud.teamrabbil.com/api/v1/UpdateProduct/'+id);

  var postBody = jsonEncode(formValues);

  var postHeader = {"Content-Type": "application/json"};

  var response = await http.post(URL, headers: postHeader, body: postBody);
  var resultCode = response.statusCode;
  var resultBody = jsonDecode(response.body);

  if (resultCode == 200 && resultBody['status'] == "success") {
    successToast('Request Success');
    return true;
  } else {
    errorToast('Request fail! try again');
    return false;
  }
}
