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
}
