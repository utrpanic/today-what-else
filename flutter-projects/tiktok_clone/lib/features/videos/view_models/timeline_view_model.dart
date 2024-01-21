import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/videos/models/video_model.dart';
import 'package:tiktok_clone/features/videos/repos/videos_repo.dart';

class TimelineViewModel extends AsyncNotifier<List<VideoModel>> {
  late final VideosRepository _repository;
  List<VideoModel> _list = [];

  @override
  FutureOr<List<VideoModel>> build() async {
    _repository = ref.read(videosRepo);
    _list = await _fetchVideos(lastItemCreatedAt: null);
    return _list;
  }

  Future<List<VideoModel>> _fetchVideos({
    required int? lastItemCreatedAt,
  }) async {
    final result = await _repository.fetchVideos(
      lastItemCreatedAt: lastItemCreatedAt,
    );
    final videos = result.docs.map(
      (doc) => VideoModel.fromJson(doc.data()),
    );
    return videos.toList();
  }

  Future<void> fetchNextPage() async {
    final nextPage = await _fetchVideos(
      lastItemCreatedAt: _list.last.createdAt,
    );
    _list.addAll(nextPage);
    state = AsyncValue.data(_list);
  }
}

final timelineProvider =
    AsyncNotifierProvider<TimelineViewModel, List<VideoModel>>(
  TimelineViewModel.new,
);
