import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/onboarding/interests_screen.dart';
import 'package:tiktok_clone/features/users/view_models/users_view_model.dart';
import 'package:tiktok_clone/utils.dart';

class SignUpViewModel extends AsyncNotifier<void> {
  late AuthenticationRepository _authRepo;

  @override
  FutureOr<void> build() {}

  Future<void> signUp(BuildContext context) async {
    state = const AsyncValue.loading();
    _authRepo = ref.read(authRepo);
    final form = ref.read(signUpForm);
    final users = ref.read(usersProvider.notifier);
    state = await AsyncValue.guard(() async {
      final userCredential = await _authRepo.emailSignUp(
        form['email'],
        form['password'],
      );
      await users.createAccount(userCredential);
    });
    if (state.hasError) {
      if (context.mounted) {
        showFirebaseErrorSnack(context, state.error!);
      }
    } else {
      if (context.mounted) {
        context.goNamed(InterestsScreen.routeName);
      }
    }
  }
}

final signUpForm = StateProvider<Map<String, String>>((ref) => {});

final signUpProvider = AsyncNotifierProvider<SignUpViewModel, void>(
  SignUpViewModel.new,
);
