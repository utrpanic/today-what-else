import 'dart:async';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/features/users/view_models/users_view_model.dart';
import 'package:tiktok_clone/features/videos/models/video_model.dart';
import 'package:tiktok_clone/features/videos/repos/videos_repo.dart';

class UploadVideoViewModel extends AsyncNotifier<void> {
  late final VideosRepository _repository;

  @override
  FutureOr<void> build() {
    _repository = ref.read(videosRepo);
  }

  Future<void> uploadVideo(BuildContext context, File video) async {
    final userProfile = ref.read(usersProvider).value;
    if (userProfile != null) {
      state = const AsyncValue.loading();
      state = await AsyncValue.guard(() async {
        final task = await _repository.uploadVideoFile(
          video,
          userProfile.uid,
        );
        if (task.metadata != null) {
          await _repository.saveVideo(
            VideoModel(
              id: '',
              creatorUid: userProfile.uid,
              creatorName: userProfile.name,
              title: 'From Flutter',
              description: 'Hell yeah!',
              fileUrl: await task.ref.getDownloadURL(),
              thumbnailUrl: '',
              createdAt: DateTime.now().millisecondsSinceEpoch,
              likes: 0,
              comments: 0,
            ),
          );
          if (context.mounted) {
            context
              ..pop()
              ..pop();
          }
        }
      });
    }
  }
}

final uploadVideoProivder = AsyncNotifierProvider<UploadVideoViewModel, void>(
  UploadVideoViewModel.new,
);
