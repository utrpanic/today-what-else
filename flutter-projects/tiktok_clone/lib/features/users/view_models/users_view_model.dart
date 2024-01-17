import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/users/models/user_profile_model.dart';
import 'package:tiktok_clone/features/users/repos/user_repo.dart';

class UsersViewModel extends AsyncNotifier<UserProfileModel> {
  late final UserRepository _userRepository;
  late final AuthenticationRepository _authenticationRepository;

  @override
  FutureOr<UserProfileModel> build() async {
    _userRepository = ref.read(userRepo);
    _authenticationRepository = ref.read(authRepo);
    if (_authenticationRepository.isLoggedIn) {
      final profile = await _userRepository.findProfile(
        _authenticationRepository.user!.uid,
      );
      if (profile != null) {
        return UserProfileModel.fromJson(profile);
      } else {
        return UserProfileModel.empty();
      }
    } else {
      return UserProfileModel.empty();
    }
  }

  Future<void> createProfile(UserCredential credential) async {
    if (credential.user == null) {
      throw Exception('Account not created');
    }
    state = const AsyncValue.loading();
    final profile = UserProfileModel(
      hasAvatar: false,
      bio: 'undefined',
      link: 'undefined',
      email: credential.user!.email ?? 'anon@anao.com',
      uid: credential.user!.uid,
      name: credential.user!.displayName ?? 'Anon',
    );
    state = AsyncValue.data(profile);
    await _userRepository.createProfile(profile);
  }

  Future<void> onAvatarUpload() async {
    if (state.value == null) return;
    state = AsyncValue.data(
      state.value!.copyWith(hasAvatar: true),
    );
    await _userRepository.updateUser(state.value!.uid, {
      'hasAvatar': true,
    });
  }

  Future<void> updateProfile({
    required String? bio,
    required String? link,
  }) async {
    if (state.value == null) return;
    state = AsyncValue.data(
      state.value!.copyWith(bio: bio, link: link),
    );
    await _userRepository.updateUser(state.value!.uid, {
      'bio': bio,
      'link': link,
    });
  }
}

final usersProvider = AsyncNotifierProvider<UsersViewModel, UserProfileModel>(
  UsersViewModel.new,
);
