import 'package:flutter/material.dart';

class VideoTimelineScreen extends StatefulWidget {
  const VideoTimelineScreen({super.key});

  @override
  State<VideoTimelineScreen> createState() => _VideoTimelineScreenState();
}

class _VideoTimelineScreenState extends State<VideoTimelineScreen> {
  List<Color> colors = [
    Colors.blue,
    Colors.red,
    Colors.yellow,
    Colors.teal,
  ];
  int _itemCount = 4;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.vertical,
      onPageChanged: _onPageChanged,
      itemCount: colors.length,
      itemBuilder: (context, index) {
        return Container(
          color: colors[index],
          child: Center(
            child: Text(
              'Screen $index',
              style: const TextStyle(fontSize: 64),
            ),
          ),
        );
      },
    );
  }

  void _onPageChanged(int page) {
    if (page == _itemCount - 1) {
      _itemCount += 4;
      colors.addAll([
        Colors.blue,
        Colors.red,
        Colors.yellow,
        Colors.teal,
      ]);
      setState(() {});
    }
  }
}
