import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/inbox/models/chat_room_model.dart';
import 'package:tiktok_clone/features/inbox/repos/chat_rooms_repo.dart';

class ChatRoomsViewModel extends AsyncNotifier<List<ChatRoomModel>> {
  late final ChatRoomsRepository _repository;

  @override
  FutureOr<List<ChatRoomModel>> build() async {
    _repository = ref.read(chatRoomsRepo);
    return await _fetchChatRooms();
  }

  Future<List<ChatRoomModel>> _fetchChatRooms() async {
    final myId = ref.read(authRepo).user!.uid;
    final result = await _repository.fetchChatRooms(myId);
    return result.docs
        .map(
          (doc) => ChatRoomModel.fromJson(id: doc.id, json: doc.data()),
        )
        .toList();
  }

  Future<void> refreshChatRooms() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(_fetchChatRooms);
  }

  Future<void> deleteChatRoom(String chatRoomId) async {
    await _repository.deleteChatRoom(chatRoomId);
  }
}

final chatRoomsProvider =
    AsyncNotifierProvider<ChatRoomsViewModel, List<ChatRoomModel>>(
  ChatRoomsViewModel.new,
);
