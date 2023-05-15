import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:movie_library/core/configs/configs.dart';
import 'package:movie_library/features/fcm/repositories/fcm_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'fcm_provider.g.dart';

@riverpod
class Fcm extends _$Fcm {
  @override
  void build() {}

  Future<void> sendNotification() async {
    await Future.delayed(const Duration(seconds: 2));
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'key=${Configs.serverKey}',
    };
    final Map<String, dynamic> notification = {
      'title': 'Hello',
      'body': 'This is a test message',
    };

    final Map<String, dynamic> body = {
      'notification': notification,
      'priority': 'high',
      'data': {'message': 'This is a test notification!'},
      'to': await FirebaseMessaging.instance.getToken(),
    };
    ref
        .read(fcmRepositoryProvider)
        .sendNotification(headers: headers, body: body);
  }
}
