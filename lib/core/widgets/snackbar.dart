import 'package:flutter/material.dart';

SnackBar customSnackbar(String title, String message, BuildContext context) {
  return SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      duration: const Duration(seconds: 4),
      elevation: 5,
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      action: SnackBarAction(
        label: 'OK',
        onPressed: () {
          ScaffoldMessenger.of(context).clearSnackBars();
        },
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(
            message,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ));
}
