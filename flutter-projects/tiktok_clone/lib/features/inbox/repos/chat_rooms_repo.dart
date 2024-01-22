import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/inbox/models/chat_room_model.dart';

class ChatRoomsRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createChatRoom(ChatRoomModel chatRoom) async {
    await _db.collection('chat_rooms').add(chatRoom.toJson());
  }

  Future<QuerySnapshot<Map<String, dynamic>>> fetchChatRooms(String uid) async {
    return _db
        .collection('chat_rooms')
        .where('userA.id == $uid || userB.id == $uid')
        .get();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> fetchChatRoom(
    String chatRoomId,
  ) async {
    return _db.collection('chat_rooms').doc(chatRoomId).get();
  }

  Future<QueryDocumentSnapshot<Map<String, dynamic>>?> findChatRoom({
    required String userAId,
    required String userBId,
  }) async {
    final result = await _db
        .collection('chat_rooms')
        .where(
          '(userA.id == $userAId && userB.id == $userBId) || (userA.id == $userBId && userB.id == $userAId)',
        )
        .get();
    if (result.docs.isEmpty) {
      return null;
    } else {
      return result.docs.first;
    }
  }

  Future<void> updateChatRoom(ChatRoomModel chatRoom) async {
    await _db
        .collection('chat_rooms')
        .doc(chatRoom.id)
        .update(chatRoom.toJson());
  }

  Future<void> deleteChatRoom(String chatRoomId) async {
    await _db.collection('chat_rooms').doc(chatRoomId).delete();
  }
}

final chatRoomsRepo = Provider<ChatRoomsRepository>(
  (ref) => ChatRoomsRepository(),
);
