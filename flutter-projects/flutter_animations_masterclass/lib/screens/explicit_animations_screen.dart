import 'package:flutter/material.dart';

class ExplicitAnimationsScreen extends StatefulWidget {
  const ExplicitAnimationsScreen({super.key});

  @override
  State<ExplicitAnimationsScreen> createState() =>
      _ExplicitAnimationsScreenState();
}

class _ExplicitAnimationsScreenState extends State<ExplicitAnimationsScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 1),
  )
    ..addListener(() {
      _range.value = _animationController.value;
    })
    ..addStatusListener((status) {
      debugPrint('status: $status');
    });

  final ValueNotifier<double> _range = ValueNotifier(0);

  bool _looping = false;

  late final Animation<Decoration> _decoration = DecorationTween(
    begin: BoxDecoration(
      color: Colors.amber,
      borderRadius: BorderRadius.circular(20),
    ),
    end: BoxDecoration(
      color: Colors.red,
      borderRadius: BorderRadius.circular(120),
    ),
  ).animate(_curve);

  late final Animation<double> _rotation = Tween<double>(
    begin: 0,
    end: 1,
  ).animate(_curve);

  late final Animation<double> _scale = Tween<double>(
    begin: 1.0,
    end: 1.1,
  ).animate(_curve);

  late final Animation<Offset> _position = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(0, -0.2),
  ).animate(_curve);

  late final CurvedAnimation _curve = CurvedAnimation(
    parent: _animationController,
    curve: Curves.elasticOut,
    reverseCurve: Curves.elasticIn,
  );

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('build()');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explicit Animations'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SlideTransition(
            position: _position,
            child: ScaleTransition(
              scale: _scale,
              child: RotationTransition(
                turns: _rotation,
                child: DecoratedBoxTransition(
                  decoration: _decoration,
                  child: const SizedBox(
                    width: 320,
                    height: 320,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 48),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _play,
                child: const Text('Play'),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: _pause,
                child: const Text('Pause'),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: _rewind,
                child: const Text('Rewind'),
              ),
            ],
          ),
          const SizedBox(height: 48),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ValueListenableBuilder(
                valueListenable: _range,
                builder: (context, value, child) {
                  return Slider(
                    value: _range.value,
                    onChanged: _onChanged,
                  );
                },
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: _toggleLooping,
                child: Text(
                  _looping ? 'Stop looping' : 'Start looping',
                ),
              ),
            ],
          )
        ],
      )),
    );
  }

  void _play() {
    _animationController.forward();
  }

  void _pause() {
    _animationController.stop();
  }

  void _rewind() {
    _animationController.reverse();
  }

  void _onChanged(double value) {
    _animationController.value = value;
  }

  void _toggleLooping() {
    if (_looping) {
      _animationController.stop();
    } else {
      _animationController.repeat(reverse: true);
    }
    setState(() {
      _looping = !_looping;
    });
  }
}
