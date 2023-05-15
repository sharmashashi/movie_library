import 'package:movie_library/core/configs/configs.dart';
import 'package:movie_library/core/services/http/http_service.dart';
import 'package:movie_library/features/fcm/repositories/fcm_repository.dart';

class FcmRepositoryImpl implements FcmRepository {
  final HttpService httpService;
  FcmRepositoryImpl(this.httpService);
  @override
  String get endpoint => Configs.firebaseFCMUrl;

  @override
  Future<void> sendNotification(
      {required Map<String, String> headers,
      required Map<String, dynamic> body}) async {
    await httpService.post(endpoint: endpoint, headers: headers, body: body);
  }
}
