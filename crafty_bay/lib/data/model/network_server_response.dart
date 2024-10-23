class NetworkServerResponse {
  NetworkServerResponse(
      {required this.isSuccess,
      required this.statusCode,
      this.responseBody,
      this.errorMessage = 'Something went wrong!'});

  final bool isSuccess;
  final int statusCode;
  dynamic responseBody;
  String? errorMessage;
}
