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

  late final _menuController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 1),
    reverseDuration: const Duration(milliseconds: 500),
  );
  final Curve _menuCurve = Curves.easeInOutCubic;

  late final Animation<double> _screenScale = Tween<double>(
    begin: 1,
    end: 0.7,
  ).animate(
    CurvedAnimation(
      parent: _menuController,
      curve: Interval(
        0,
        0.3,
        curve: _menuCurve,
      ),
    ),
  );

  late final Animation<Offset> _screenOffset = Tween(
    begin: Offset.zero,
    end: const Offset(0.5, 0),
  ).animate(
    CurvedAnimation(
      parent: _menuController,
      curve: Interval(
        0.5,
        1,
        curve: _menuCurve,
      ),
    ),
  );

  late final Animation<double> _closeButtonOpacity =
      Tween<double>(begin: 0, end: 1).animate(
    CurvedAnimation(
      parent: _menuController,
      curve: Interval(
        0.3,
        0.5,
        curve: _menuCurve,
      ),
    ),
  );

  late final List<Animation<Offset>> _menuAnimations = [
    for (var i = 0; i < _menus.length; i++)
      Tween(
        begin: const Offset(-1, 0),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _menuController,
          curve: Interval(
            0.5 + (0.1 * i),
            0.8 + (0.1 * i),
            curve: _menuCurve,
          ),
        ),
      ),
  ];

  late final Animation<Offset> _logOutSlide = Tween(
    begin: const Offset(-1, 0),
    end: Offset.zero,
  ).animate(
    CurvedAnimation(
      parent: _menuController,
      curve: Interval(
        0.8,
        1,
        curve: _menuCurve,
      ),
    ),
  );

  bool _dragging = false;

  final ValueNotifier<double> _volume = ValueNotifier<double>(0);

  late final size = MediaQuery.of(context).size;

  final List<Map<String, dynamic>> _menus = [
    {
      'icon': Icons.person,
      'title': 'Profile',
    },
    {
      'icon': Icons.notifications,
      'title': 'Notifications',
    },
    {
      'icon': Icons.settings,
      'title': 'Settings',
    },
  ];

  @override
  void dispose() {
    _progressController.dispose();
    _marqueeController.dispose();
    _menuController.dispose();
    super.dispose();
  }

  void _openMenu() {
    _menuController.forward();
  }

  void _closeMenu() {
    _menuController.reverse();
  }

  void _onPlayPauseTap() {
    if (_playPauseController.isCompleted) {
      _playPauseController.reverse();
    } else {
      _playPauseController.forward();
    }
  }

  void _toggleDragging() {
    _dragging = !_dragging;
    setState(() {});
  }

  void _onVolumeDragUpdate(DragUpdateDetails details) {
    _volume
      ..value += details.delta.dx
      ..value = _volume.value.clamp(0.0, size.width - 96);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            foregroundColor: Colors.white,
            backgroundColor: Colors.black,
            leading: FadeTransition(
              opacity: _closeButtonOpacity,
              child: IconButton(
                onPressed: _closeMenu,
                icon: const Icon(Icons.close),
              ),
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  for (var i = 0; i < _menus.length; i++) ...[
                    SlideTransition(
                      position: _menuAnimations[i],
                      child: Row(
                        children: [
                          Icon(
                            _menus[i]['icon'] as IconData,
                            color: Colors.grey.shade200,
                          ),
                          const SizedBox(width: 16),
                          Text(
                            _menus[i]['title'] as String,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey.shade200,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                  const Spacer(),
                  SlideTransition(
                    position: _logOutSlide,
                    child: const Row(
                      children: [
                        Icon(
                          Icons.logout,
                          color: Colors.red,
                        ),
                        SizedBox(width: 16),
                        Text(
                          'Log out',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
        SlideTransition(
          position: _screenOffset,
          child: ScaleTransition(
            scale: _screenScale,
            child: Scaffold(
              appBar: AppBar(
                title: const Text('Interstellar'),
                actions: [
                  IconButton(
                    onPressed: _openMenu,
                    icon: const Icon(Icons.menu),
                  ),
                ],
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
                            image:
                                AssetImage('assets/covers/${widget.index}.jpg'),
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
                          (musicDuration.inSeconds * _progressController.value)
                              .toInt();
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
                  const SizedBox(height: 32),
                  GestureDetector(
                    onHorizontalDragStart: (details) => _toggleDragging(),
                    onHorizontalDragUpdate: _onVolumeDragUpdate,
                    onHorizontalDragEnd: (details) => _toggleDragging(),
                    child: AnimatedScale(
                      scale: _dragging ? 1.2 : 1,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.bounceOut,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: ValueListenableBuilder(
                          valueListenable: _volume,
                          builder: (context, value, child) => CustomPaint(
                            size: Size(size.width - 96, 48),
                            painter: VolumePainter(volume: value),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
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

class VolumePainter extends CustomPainter {
  VolumePainter({required this.volume});

  final double volume;

  @override
  void paint(Canvas canvas, Size size) {
    final progress = volume;

    final bgPaint = Paint()..color = Colors.grey.shade300;
    final bgRect = Rect.fromLTRB(
      0,
      0,
      size.width,
      size.height,
    );
    canvas.drawRect(bgRect, bgPaint);

    final volumePaint = Paint()..color = Colors.grey.shade500;
    final volumeRect = Rect.fromLTRB(
      0,
      0,
      progress,
      size.height,
    );
    canvas.drawRect(volumeRect, volumePaint);
  }

  @override
  bool shouldRepaint(covariant VolumePainter oldDelegate) {
    return oldDelegate.volume != volume;
  }
}
