import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/videos/repos/videos_repo.dart';

class VideoPostViewModel extends FamilyAsyncNotifier<void, String> {
  late final VideosRepository _repository;
  late final String _videoId;

  @override
  FutureOr<void> build(String arg) {
    _videoId = arg;
    _repository = ref.read(videosRepo);
  }

  Future<void> toggleLikeVideo() async {
    final user = ref.read(authRepo).user;
    await _repository.toggleLikeVideo(userId: user!.uid, videoId: _videoId);
  }

  Future<bool> isLikedVideo() async {
    final user = ref.read(authRepo).user;
    return _repository.isLikedVideo(
      userId: user!.uid,
      videoId: _videoId,
    );
  }
}

final videoPostProvider =
    AsyncNotifierProvider.family<VideoPostViewModel, void, String>(
  VideoPostViewModel.new,
);
