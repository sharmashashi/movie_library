import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_library/core/services/fcm/fcm.dart';
import 'package:movie_library/features/fcm/widget/fcm.dart';
import 'package:movie_library/features/now_playing/widget/now_playing.dart';
import 'package:movie_library/features/popular/widget/popular.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    onMessageHandler(context);
    return Scaffold(
      floatingActionButton: const FcmFloatingButton(),
      body: SafeArea(
        bottom: false,
        right: false,
        left: false,
        child: ListView(
          children: const [
            NowPlaying(),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Popular(),
            )
          ],
        ),
      ),
    );
  }
}
