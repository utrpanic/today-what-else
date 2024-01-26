import 'dart:math';

import 'package:flutter/material.dart';

class AppleWatchScreen extends StatefulWidget {
  const AppleWatchScreen({super.key});

  @override
  State<AppleWatchScreen> createState() => _AppleWatchScreenState();
}

class _AppleWatchScreenState extends State<AppleWatchScreen>
    with SingleTickerProviderStateMixin {
  late final _animationController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 1),
  )..forward();
  late final _curve = CurvedAnimation(
    parent: _animationController,
    curve: Curves.bounceOut,
  );
  late Animation<double> _redProgress = Tween(
    begin: 0.005,
    end: max(0.005, Random().nextDouble() * 2.0),
  ).animate(_curve);
  late Animation<double> _greenProgress = Tween(
    begin: 0.005,
    end: max(0.005, Random().nextDouble() * 2.0),
  ).animate(_curve);
  late Animation<double> _blueProgress = Tween(
    begin: 0.005,
    end: max(0.005, Random().nextDouble() * 2.0),
  ).animate(_curve);

  void _animateValues() {
    setState(() {
      _redProgress = Tween(
        begin: _redProgress.value,
        end: Random().nextDouble() * 2.0,
      ).animate(_curve);
      _greenProgress = Tween(
        begin: _greenProgress.value,
        end: Random().nextDouble() * 2.0,
      ).animate(_curve);
      _blueProgress = Tween(
        begin: _blueProgress.value,
        end: Random().nextDouble() * 2.0,
      ).animate(_curve);
    });
    _animationController.forward(from: 0);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
        title: const Text('Apple Watch'),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _curve,
          builder: (context, child) {
            return CustomPaint(
              painter: AppleWatchPainter(
                redProgress: _redProgress.value,
                greenProgress: _greenProgress.value,
                blueProgress: _blueProgress.value,
              ),
              size: const Size(320, 320),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _animateValues,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

class AppleWatchPainter extends CustomPainter {
  AppleWatchPainter({
    required this.redProgress,
    required this.greenProgress,
    required this.blueProgress,
  });

  final double redProgress;
  final double greenProgress;
  final double blueProgress;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    const strokeWidth = 25.0;
    const strokeSpace = 5.0;
    const startingAngle = -0.5 * pi;
    // draw red
    final recCirclePaint = Paint()
      ..color = Colors.red.shade400.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    final redCircleRadius = size.width / 2;
    canvas.drawCircle(center, redCircleRadius, recCirclePaint);
    // draw green
    final greenCirclePaint = Paint()
      ..color = Colors.green.shade400.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    final greenCircleRadius = redCircleRadius - strokeWidth - strokeSpace;
    canvas.drawCircle(center, greenCircleRadius, greenCirclePaint);
    // draw blue
    final blueCirclePaint = Paint()
      ..color = Colors.blue.shade400.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    final blueCircleRadius = greenCircleRadius - strokeWidth - strokeSpace;
    canvas.drawCircle(center, blueCircleRadius, blueCirclePaint);
    // draw red arc
    final redArcRect = Rect.fromCircle(center: center, radius: redCircleRadius);
    final redArcPaint = Paint()
      ..color = Colors.red.shade400
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 25;
    canvas.drawArc(
      redArcRect,
      startingAngle,
      redProgress * pi,
      false,
      redArcPaint,
    );
    // draw green arc
    final greenArcRect =
        Rect.fromCircle(center: center, radius: greenCircleRadius);
    final greenArcPaint = Paint()
      ..color = Colors.green.shade400
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 25;
    canvas.drawArc(
      greenArcRect,
      startingAngle,
      greenProgress * pi,
      false,
      greenArcPaint,
    );
    // draw blue arc
    final blueArcRect =
        Rect.fromCircle(center: center, radius: blueCircleRadius);
    final blueArcPaint = Paint()
      ..color = Colors.blue.shade400
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 25;
    canvas.drawArc(
      blueArcRect,
      startingAngle,
      blueProgress * pi,
      false,
      blueArcPaint,
    );
  }

  @override
  bool shouldRepaint(covariant AppleWatchPainter oldDelegate) {
    return oldDelegate.redProgress != redProgress;
  }
}
