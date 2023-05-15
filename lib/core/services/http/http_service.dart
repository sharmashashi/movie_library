abstract class HttpService {
  Future<Map<String, dynamic>> get(String endpoint,
      {Map<String, dynamic>? queryParameters});

  Future<void> post(
      {required String endpoint,
      required Map<String, String> headers,
      required Map<String, dynamic> body});
}
