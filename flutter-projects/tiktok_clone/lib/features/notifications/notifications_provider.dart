import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';

class NotificationsProvider extends AsyncNotifier<void> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  @override
  FutureOr<void> build() async {
    final token = await _messaging.getToken();
    if (token == null) return;
    await updateToken(token);
    await initListeners();
    _messaging.onTokenRefresh.listen((newToken) async {
      await updateToken(newToken);
    });
  }

  Future<void> initListeners() async {
    final permission = await _messaging.requestPermission();
    if (permission.authorizationStatus == AuthorizationStatus.denied) {
      return;
    }
    // Foreground
    FirebaseMessaging.onMessage.listen((message) {
      print("✅ I just got a message and I'm in the foreground");
      print(message.notification?.title);
    });
    // Background
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print(message.data['screen']);
    });
    // Terminated
    final notification = await _messaging.getInitialMessage();
    if (notification != null) {
      print(notification.data['screen']);
    }
  }

  Future<void> updateToken(String token) async {
    final user = ref.read(authRepo).user;
    await _db.collection('users').doc(user!.uid).update({'token': token});
  }
}

final notificationsProvider =
    AsyncNotifierProvider<NotificationsProvider, void>(
  NotificationsProvider.new,
);
