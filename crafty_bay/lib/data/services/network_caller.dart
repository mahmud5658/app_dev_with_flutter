import 'dart:convert';
import 'package:crafty_bay/data/model/network_server_response.dart';
import 'package:http/http.dart';

class NetworkCaller {
  Future<NetworkServerResponse> getResponse({required String url, required String token}) async {
    try {
      Uri uri = Uri.parse(url);
      final Response response = await get(
        uri,
        headers: {'token': token},
      );
      if (response.statusCode == 200) {
        return NetworkServerResponse(
            isSuccess: true,
            statusCode: 200,
            responseBody: jsonDecode(response.body),
            errorMessage: null);
      } else {
        return NetworkServerResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      return NetworkServerResponse(
          isSuccess: false, statusCode: -1, errorMessage: e.toString());
    }
  }

  Future<NetworkServerResponse> postResponse(
      {required String url, required String token, Map<String, dynamic>? dataToPost}) async {
    try {
      Uri uri = Uri.parse(url);
      final encodedBody = jsonEncode(dataToPost);
      final Response response = await post(uri,
          headers: {'token': token, 'content-type': 'application/json'},
          body: encodedBody);
      if (response.statusCode == 200) {
        return NetworkServerResponse(
            isSuccess: true, statusCode: 200, errorMessage: null);
      } else {
        return NetworkServerResponse(
            isSuccess: false, statusCode: response.statusCode);
      }
    } catch (e) {
      return NetworkServerResponse(
          isSuccess: false, statusCode: -1, errorMessage: e.toString());
    }
  }
}
