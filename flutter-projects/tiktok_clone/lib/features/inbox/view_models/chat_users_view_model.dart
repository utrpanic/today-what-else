import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/inbox/models/chat_user_model.dart';
import 'package:tiktok_clone/features/users/models/user_profile_model.dart';
import 'package:tiktok_clone/features/users/repos/user_repo.dart';

class ChatUsersViewModel extends AsyncNotifier<List<ChatUserModel>> {
  late final UserRepository _usersRepo;

  @override
  FutureOr<List<ChatUserModel>> build() async {
    _usersRepo = ref.read(userRepo);
    return await _fetchChatUsers();
  }

  Future<List<ChatUserModel>> _fetchChatUsers() async {
    final result = await _usersRepo.fetchUsers();
    final users = result.docs.map(
      (doc) {
        final user = UserProfileModel.fromJson(id: doc.id, json: doc.data());
        return ChatUserModel(
          id: user.uid,
          name: user.name,
          hasAvatar: user.hasAvatar,
        );
      },
    );
    final myId = ref.read(authRepo).user!.uid;
    return users.where((element) => element.id != myId).toList();
  }
}

final chatUsersProvider =
    AsyncNotifierProvider<ChatUsersViewModel, List<ChatUserModel>>(
  ChatUsersViewModel.new,
);
