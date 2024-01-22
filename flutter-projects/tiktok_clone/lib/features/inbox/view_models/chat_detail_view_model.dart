import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/inbox/models/chat_room_model.dart';
import 'package:tiktok_clone/features/inbox/repos/chat_rooms_repo.dart';

class ChatDetailViewModel extends FamilyAsyncNotifier<ChatRoomModel, String> {
  late final ChatRoomsRepository _repository;
  late String _chatRoomId;

  @override
  FutureOr<ChatRoomModel> build(String arg) async {
    _repository = ref.read(chatRoomsRepo);
    _chatRoomId = arg;
    return _fetchChatRoom(_chatRoomId);
  }

  Future<ChatRoomModel> _fetchChatRoom(String chatRoomId) async {
    final result = await _repository.fetchChatRoom(chatRoomId);
    return ChatRoomModel.fromJson(id: result.id, json: result.data()!);
  }
}

final chatDetailProvider =
    AsyncNotifierProvider.family<ChatDetailViewModel, ChatRoomModel, String>(
  ChatDetailViewModel.new,
);
