import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:to_do_list/app/core/utils/constants.dart';

class HttpClient extends http.BaseClient {
  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    debugPrint("$logTrace $runtimeType ${request.method} : ${request.url}\n");

    /// interceptor
    request.headers
        .putIfAbsent("content-type", () => "application/json; charset=utf-8");
    if (request.headers.containsKey("content-type")) {
      request.headers
          .update("content-type", (value) => "application/json; charset=utf-8");
    }
    return request.send();
  }
}
