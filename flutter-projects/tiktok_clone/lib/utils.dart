import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

bool isDarkMode(BuildContext context) {
  return MediaQuery.of(context).platformBrightness == Brightness.dark;
}

void showFirebaseErrorSnack(
  BuildContext context,
  Object error,
) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      action: SnackBarAction(
        label: 'OK',
        onPressed: () {},
      ),
      content: Text(
        (error as FirebaseException).message ?? 'Something went wrong.',
      ),
    ),
  );
}
