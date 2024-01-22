import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/inbox/models/message_model.dart';

class MessagesRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> sendMessage(String chatRoomId, MessageModel message) async {
    await _db
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('texts')
        .add(message.toJson());
  }

  Future<void> updateMessage(String chatRoomId, MessageModel message) async {
    await _db
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('texts')
        .doc(message.id)
        .update(message.toJson());
  }

  Future<void> deleteMessage(String chatRoomId, MessageModel message) async {
    await _db
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('texts')
        .doc(message.id)
        .delete();
  }
}

final messagesRepo = Provider<MessagesRepository>(
  (ref) => MessagesRepository(),
);
