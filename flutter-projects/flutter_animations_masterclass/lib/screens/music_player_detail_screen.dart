import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';

class MusicPlayerDetailScreen extends StatefulWidget {
  const MusicPlayerDetailScreen({super.key, required this.index});

  final int index;

  @override
  State<MusicPlayerDetailScreen> createState() =>
      _MusicPlayerDetailScreenState();
}

class _MusicPlayerDetailScreenState extends State<MusicPlayerDetailScreen>
    with TickerProviderStateMixin {
  final musicDuration = const Duration(minutes: 1);
  late final _progressController = AnimationController(
    vsync: this,
    duration: musicDuration,
  )..repeat(reverse: true);

  late final _marqueeController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 5),
  )..repeat(reverse: true);

  late final Animation<Offset> _marqueeAnimation = Tween<Offset>(
    begin: const Offset(0.1, 0),
    end: const Offset(-0.6, 0),
  ).animate(_marqueeController);

  late final _playPauseController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 300),
  );

  @override
  void dispose() {
    _progressController.dispose();
    _marqueeController.dispose();
    super.dispose();
  }

  void _onPlayPauseTap() {
    if (_playPauseController.isCompleted) {
      _playPauseController.reverse();
    } else {
      _playPauseController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Interstellar'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 32),
          Align(
            alignment: Alignment.center,
            child: Hero(
              tag: widget.index,
              child: Container(
                width: 350,
                height: 350,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 10,
                      spreadRadius: 2,
                      offset: const Offset(0, 5),
                    ),
                  ],
                  image: DecorationImage(
                    image: AssetImage('assets/covers/${widget.index}.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 48),
          AnimatedBuilder(
            animation: _progressController,
            builder: (context, child) {
              final elapsed =
                  (musicDuration.inSeconds * _progressController.value).toInt();
              final left = musicDuration.inSeconds - elapsed;
              return Column(
                children: [
                  CustomPaint(
                    size: Size(size.width - 96, 8),
                    painter: ProgressBar(
                      progressValue: _progressController.value,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 48),
                    child: Row(
                      children: [
                        Text(
                          _formatedTime(elapsed),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          _formatedTime(left),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 16),
          const Text(
            'Interstellar',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SlideTransition(
              position: _marqueeAnimation,
              child: const Text(
                'A film by Christopher Nolan - Original Motion Picture Soundtrack',
                textAlign: TextAlign.center,
                maxLines: 1,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: _onPlayPauseTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedIcon(
                  icon: AnimatedIcons.pause_play,
                  progress: _playPauseController,
                  size: 64,
                ),
                // Lottie.asset(
                //   width: 128,
                //   height: 128,
                //   'assets/animations/lottie-play-pause.json',
                //   controller: _playPauseController,
                //   onLoaded: (composition) {
                //     _playPauseController.duration = composition.duration;
                //   },
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatedTime(int secondsValue) {
    final minutes = secondsValue ~/ 60;
    final seconds = secondsValue % 60;
    final minutesString = minutes.toString().padLeft(2, '0');
    final secondsString = seconds.toString().padLeft(2, '0');
    return '$minutesString:$secondsString';
  }
}

class ProgressBar extends CustomPainter {
  ProgressBar({required this.progressValue});

  final double progressValue;

  @override
  void paint(Canvas canvas, Size size) {
    final progress = size.width * progressValue;
    // background bar
    final trackPaint = Paint()
      ..color = Colors.grey.shade300
      ..style = PaintingStyle.fill;
    final trackRRect = RRect.fromLTRBR(
      0,
      0,
      size.width,
      size.height,
      const Radius.circular(8),
    );
    canvas.drawRRect(trackRRect, trackPaint);

    // progress bar
    final progressPaint = Paint()
      ..color = Colors.grey.shade500
      ..style = PaintingStyle.fill;
    final progressRRect = RRect.fromLTRBR(
      0,
      0,
      progress,
      size.height,
      const Radius.circular(8),
    );
    canvas.drawRRect(progressRRect, progressPaint);

    // thumb
    final thumbOffset = Offset(progress, size.height / 2);
    canvas.drawCircle(thumbOffset, 8, progressPaint);
  }

  @override
  bool shouldRepaint(covariant ProgressBar oldDelegate) {
    return oldDelegate.progressValue != progressValue;
  }
}
