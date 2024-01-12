import 'package:shared_preferences/shared_preferences.dart';

class PlaybackConfigRepository {
  PlaybackConfigRepository(this._preferences);

  static const String _muted = 'muted';
  static const String _autoplay = 'autoplay';

  final SharedPreferences _preferences;

  // ignore: avoid_positional_boolean_parameters
  Future<void> setMute(bool value) async {
    await _preferences.setBool(_muted, value);
  }

  // ignore: avoid_positional_boolean_parameters
  Future<void> setAutoplay(bool value) async {
    await _preferences.setBool(_autoplay, value);
  }

  bool isMuted() {
    return _preferences.getBool(_muted) ?? false;
  }

  bool isAutoplay() {
    return _preferences.getBool(_autoplay) ?? false;
  }
}
