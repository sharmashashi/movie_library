import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:movie_library/core/configs/configs.dart';
import 'package:movie_library/core/services/http/http_service.dart';

final httpServiceProvider = Provider<HttpService>((ref) {
  return HttpServiceImpl();
});

class HttpServiceImpl implements HttpService {
  @override
  Future<Map<String, dynamic>> get(String endpoint,
      {Map<String, dynamic>? queryParameters}) async {
    final response = await http.get(
        Uri.parse(endpoint).replace(
          queryParameters: queryParameters,
        ),
        headers: {"Authorization": "Bearer ${Configs.authToken}"});

    if (response.statusCode != 200) {
      log(response.toString());
      throw const HttpException("Error loading!");
    }
    return jsonDecode(response.body);
  }

  @override
  Future<void> post(
      {required String endpoint,
      required Map<String, String> headers,
      required Map<String, dynamic> body}) async {
    final response = await http.post(Uri.parse(endpoint),
        headers: headers, body: jsonEncode(body));
    if (response.statusCode != 200) {
      log(response.body);
      throw const HttpException("Error sending notification!");
    } else if (response.statusCode == 200) {
      log("POST successful");
    }
  }
}
