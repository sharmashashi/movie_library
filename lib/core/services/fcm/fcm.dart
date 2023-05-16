import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:movie_library/core/widgets/snackbar.dart';
import 'package:movie_library/firebase_options.dart';

Future<void> initFirebaseServices() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.instance.requestPermission();
}

onMessageHandler(BuildContext context) {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    try {
      ScaffoldMessenger.of(context).showSnackBar(customSnackbar(
          message.notification!.title!, message.data['message'], context));
    } catch (_) {
      throw Exception("Error showing notification message!");
    }
  });
}
