import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/utils.dart';

class LoginViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _repository;

  @override
  FutureOr<void> build() {
    _repository = ref.read(authRepo);
  }

  Future<void> login(
    BuildContext context,
    String? email,
    String? password,
  ) async {
    if (email == null || password == null) {
      throw Exception('Email and password must not be null');
    }
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async => _repository.signIn(
        email,
        password,
      ),
    );
    if (state.hasError) {
      if (context.mounted) {
        showFirebaseErrorSnack(context, state.error!);
      }
    } else {
      if (context.mounted) {
        context.go('/home');
      }
    }
  }
}

final loginProvider = AsyncNotifierProvider<LoginViewModel, void>(
  LoginViewModel.new,
);
