import 'dart:async';
import 'dart:developer';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_library/core/services/fcm/fcm.dart';
import 'package:movie_library/screens/home.dart';

void main() {
  runZonedGuarded(() async {
    await dotenv.load(fileName: '.env');
    await initFirebaseServices();
    runApp(const MyApp());
  }, (error, stack) {
    log("ERROR", error: error, stackTrace: stack);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Movie Library',
        theme: FlexColorScheme.light(scheme: FlexScheme.purpleM3).toTheme,
        darkTheme: FlexColorScheme.dark(scheme: FlexScheme.purpleM3).toTheme,
        home: const Home(),
      ),
    );
  }
}
