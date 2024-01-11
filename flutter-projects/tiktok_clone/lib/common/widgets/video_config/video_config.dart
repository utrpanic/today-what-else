import 'package:flutter/foundation.dart';

class VideoConfig extends ChangeNotifier {
  bool isMuted = false;
  bool isAutoplay = false;

  void toggleIsMuted() {
    isMuted = !isMuted;
    notifyListeners();
  }

  void toggleIsAutoplay() {
    isAutoplay = !isAutoplay;
    notifyListeners();
  }
}
