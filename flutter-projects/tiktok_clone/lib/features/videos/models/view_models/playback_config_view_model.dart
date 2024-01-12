import 'package:flutter/material.dart';
import 'package:tiktok_clone/features/videos/models/playback_config_model.dart';
import 'package:tiktok_clone/features/videos/models/repos/playback_config_repo.dart';

class PlaybackConfigViewModel extends ChangeNotifier {
  PlaybackConfigViewModel(this._repository);

  final PlaybackConfigRepository _repository;

  late final PlaybackConfigModel _model = PlaybackConfigModel(
    muted: _repository.isMuted(),
    autoplay: _repository.isAutoplay(),
  );

  bool get muted => _model.muted;
  bool get autoplay => _model.autoplay;

  // ignore: avoid_positional_boolean_parameters
  void setMuted(bool value) {
    _repository.setMute(value);
    _model.muted = value;
    notifyListeners();
  }

  // ignore: avoid_positional_boolean_parameters
  void setAutoplay(bool value) {
    _repository.setAutoplay(value);
    _model.autoplay = value;
    notifyListeners();
  }
}
