import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/inbox/chats_screen.dart';
import 'package:tiktok_clone/features/videos/views/video_recording_screen.dart';

class NotificationsProvider extends FamilyAsyncNotifier<void, BuildContext> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  late final BuildContext _context;

  @override
  FutureOr<void> build(BuildContext arg) async {
    _context = arg;
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
      debugPrint("✅ I just got a message and I'm in the foreground");
      debugPrint(message.notification?.title);
    });
    // Background
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      if (_context.mounted) {
        _context.pushNamed(ChatsScreen.routeName);
      }
    });
    // Terminated
    final notification = await _messaging.getInitialMessage();
    if (notification != null && _context.mounted) {
      await _context.pushNamed(VideoRecordingScreen.routeName);
    }
  }

  Future<void> updateToken(String token) async {
    final user = ref.read(authRepo).user;
    await _db.collection('users').doc(user!.uid).update({'token': token});
  }
}

final notificationsProvider =
    AsyncNotifierProvider.family<NotificationsProvider, void, BuildContext>(
  NotificationsProvider.new,
);
