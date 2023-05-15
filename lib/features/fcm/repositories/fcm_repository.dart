import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_library/core/services/http/http_service_impl.dart';
import 'package:movie_library/features/fcm/repositories/fcm_repository_impl.dart';

final fcmRepositoryProvider = Provider<FcmRepository>(
    (ref) => FcmRepositoryImpl(ref.read(httpServiceProvider)));

abstract class FcmRepository {
  Future<void> sendNotification(
      {required Map<String, String> headers,
      required Map<String, dynamic> body});
  String get endpoint;
}
