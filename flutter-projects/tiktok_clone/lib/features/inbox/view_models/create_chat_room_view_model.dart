import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/inbox/models/chat_room_model.dart';
import 'package:tiktok_clone/features/inbox/models/chat_user_model.dart';
import 'package:tiktok_clone/features/inbox/repos/chat_rooms_repo.dart';
import 'package:tiktok_clone/features/users/repos/user_repo.dart';

class CreateChatRoomViewModel extends AsyncNotifier<void> {
  late final ChatRoomsRepository _chatRoomRepo;

  @override
  FutureOr<void> build() {
    _chatRoomRepo = ref.read(chatRoomsRepo);
  }

  Future<void> createChatRoom(ChatUserModel userB) async {
    final myId = ref.read(authRepo).user!.uid;
    final myProfile = await ref.read(userRepo).findProfile(myId);
    final doc = await _chatRoomRepo.findChatRoom(
      userAId: myProfile!.uid,
      userBId: userB.id,
    );
    if (doc != null) {
      final chatRoom = ChatRoomModel.fromJson(id: doc.id, json: doc.data());
      await _chatRoomRepo.updateChatRoom(
        chatRoom.copyWith(
          updatedAt: DateTime.now().millisecondsSinceEpoch,
        ),
      );
    } else {
      final chatRoom = ChatRoomModel(
        id: '',
        userA: ChatUserModel(
          id: myProfile.uid,
          name: myProfile.name,
          hasAvatar: myProfile.hasAvatar,
        ),
        userB: userB,
        updatedAt: DateTime.now().millisecondsSinceEpoch,
      );
      await _chatRoomRepo.createChatRoom(chatRoom);
    }
  }
}

final createChatRoomProvider =
    AsyncNotifierProvider<CreateChatRoomViewModel, void>(
  CreateChatRoomViewModel.new,
);
