import 'package:flutter/widgets.dart';

class VideoConfigData extends InheritedWidget {
  const VideoConfigData({
    super.key,
    required this.autoMute,
    required this.toggleMutted,
    required super.child,
  });

  final bool autoMute;
  final void Function() toggleMutted;

  static VideoConfigData of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<VideoConfigData>()!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}

class VideoConfig extends StatefulWidget {
  const VideoConfig({super.key, required this.child});

  final Widget child;

  @override
  State<VideoConfig> createState() => _VideoConfigState();
}

class _VideoConfigState extends State<VideoConfig> {
  bool autoMute = false;

  void toggleMutted() {
    setState(() {
      autoMute = !autoMute;
    });
  }

  @override
  Widget build(BuildContext context) {
    return VideoConfigData(
      autoMute: autoMute,
      toggleMutted: toggleMutted,
      child: widget.child,
    );
  }
}
