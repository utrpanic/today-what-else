import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/inbox/models/message_model.dart';
import 'package:tiktok_clone/features/inbox/repos/messages_repo.dart';

class MessagesViewModel extends FamilyAsyncNotifier<void, String> {
  late final MessagesRepository _repository;
  late final String _chatRoomId;

  @override
  FutureOr<void> build(String arg) {
    _repository = ref.read(messagesRepo);
    _chatRoomId = arg;
  }

  Future<void> sendMessage(String text) async {
    state = const AsyncValue.loading();
    final user = ref.read(authRepo).user;
    state = await AsyncValue.guard(() async {
      final message = MessageModel(
        id: '',
        text: text,
        userId: user!.uid,
        createdAt: DateTime.now().millisecondsSinceEpoch,
      );
      await _repository.sendMessage(_chatRoomId, message);
    });
  }

  Future<void> deleteMessage(MessageModel message) async {
    final now = DateTime.now();
    final messageCreatedAt = DateTime.fromMillisecondsSinceEpoch(
      message.createdAt,
    );
    if (now.isAfter(messageCreatedAt.add(const Duration(minutes: 2)))) {
      await _repository.updateMessage(
        _chatRoomId,
        message.copyWith(text: '[DELETED]'),
      );
    } else {
      await _repository.deleteMessage(_chatRoomId, message);
    }
  }
}

final messagesProvider =
    AsyncNotifierProvider.family<MessagesViewModel, void, String>(
  MessagesViewModel.new,
);

final chatProvider =
    StreamProvider.family.autoDispose<List<MessageModel>, String>(
  (ref, arg) {
    final db = FirebaseFirestore.instance;
    final chatRoomId = arg;
    return db
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('texts')
        .orderBy('createdAt')
        .snapshots()
        .map(
          (event) => event.docs
              .map(
                (doc) => MessageModel.fromJson(id: doc.id, json: doc.data()),
              )
              .toList()
              .reversed
              .toList(),
        );
  },
);
