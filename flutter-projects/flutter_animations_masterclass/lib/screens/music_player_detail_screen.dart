import 'package:flutter/material.dart';

class MusicPlayerDetailScreen extends StatefulWidget {
  const MusicPlayerDetailScreen({super.key, required this.index});

  final int index;

  @override
  State<MusicPlayerDetailScreen> createState() =>
      _MusicPlayerDetailScreenState();
}

class _MusicPlayerDetailScreenState extends State<MusicPlayerDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Intersteller'),
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
          CustomPaint(
            size: Size(size.width - 96, 8),
            painter: ProgressBar(
              progressValue: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}

class ProgressBar extends CustomPainter {
  ProgressBar({required this.progressValue});

  final double progressValue;

  @override
  void paint(Canvas canvas, Size size) {
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
      size.width * progressValue,
      size.height,
      const Radius.circular(8),
    );
    canvas.drawRRect(progressRRect, progressPaint);

    // thumb
    canvas.drawCircle(
      Offset(size.width * progressValue, size.height / 2),
      8,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
