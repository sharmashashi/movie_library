import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:movie_library/features/fcm/providers/fcm_provider.dart';

class FcmFloatingButton extends ConsumerWidget {
  const FcmFloatingButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fcmNotifier = ref.read(fcmProvider.notifier);
    return FloatingActionButton.extended(
      onPressed: () {
        fcmNotifier.sendNotification();
      },
      label: const Text('Send Test Notification'),
    );
  }
}
