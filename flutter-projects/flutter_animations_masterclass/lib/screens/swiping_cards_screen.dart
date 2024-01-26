import 'dart:math';

import 'package:flutter/material.dart';

class SwipingCardsScreen extends StatefulWidget {
  const SwipingCardsScreen({super.key});

  @override
  State<SwipingCardsScreen> createState() => _SwipingCardsScreenState();
}

class _SwipingCardsScreenState extends State<SwipingCardsScreen>
    with SingleTickerProviderStateMixin {
  late final size = MediaQuery.of(context).size;
  late final _position = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
    lowerBound: (size.width + 100) * -1,
    upperBound: size.width + 100,
    value: 0,
  );

  late final Tween<double> _rotation = Tween(
    begin: -15,
    end: 15,
  );

  late final Tween<double> _scale = Tween(
    begin: 0.8,
    end: 1,
  );

  late final Tween<double> _cancelOpacity = Tween(
    begin: 1,
    end: 0,
  );
  late final Tween<double> _okOpacity = Tween(
    begin: 1,
    end: 0,
  );

  int _index = 1;

  @override
  void dispose() {
    _position.dispose();
    super.dispose();
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    _position.value += details.delta.dx;
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    final bound = size.width - 200;
    if (_position.value.abs() >= bound) {
      final factor = _position.value.isNegative ? -1 : 1;
      _animateMoveOut(factor: factor);
    } else {
      _animateReset();
    }
  }

  void _animateMoveOut({required int factor}) {
    late final dropZone = size.width + 100;
    _position
        .animateTo(dropZone * factor, curve: Curves.easeOut)
        .whenComplete(() {
      _position.value = 0;
      setState(() {
        _index += 1;
      });
    });
  }

  void _animateReset() {
    _position.animateTo(0, curve: Curves.easeOut);
  }

  void _onCancelPressed() {
    _animateMoveOut(factor: -1);
  }

  void _onOkPressed() {
    _animateMoveOut(factor: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Swiping Cards'),
      ),
      body: AnimatedBuilder(
        animation: _position,
        builder: (context, child) {
          final angle = _rotation.transform(
                (_position.value + (size.width / 2)) / size.width,
              ) *
              pi /
              180;
          final scale = _scale
              .transform(
                (_position.value.abs() + (size.width / 2)) / size.width,
              )
              .clamp(0.0, 1.0);
          final cancelOpacity = _cancelOpacity
              .transform(
                (_position.value * -1) / size.width,
              )
              .clamp(0.0, 1.0);
          final okOpacity = _okOpacity
              .transform(
                _position.value / size.width,
              )
              .clamp(0.0, 1.0);
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 48),
              SizedBox(
                width: size.width * 0.8,
                height: size.height * 0.5,
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Positioned(
                      child: Transform.scale(
                        scale: scale,
                        child: Card(index: (_index + 1) % 5),
                      ),
                    ),
                    Positioned(
                      child: GestureDetector(
                        onHorizontalDragUpdate: _onHorizontalDragUpdate,
                        onHorizontalDragEnd: _onHorizontalDragEnd,
                        child: Transform.translate(
                          offset: Offset(_position.value, 0),
                          child: Transform.rotate(
                            angle: angle,
                            child: Card(index: _index % 5),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircluarButton(
                    iconData: Icons.close,
                    iconColor: Colors.red,
                    iconOpacity: cancelOpacity,
                    onPressed: _onCancelPressed,
                  ),
                  const SizedBox(width: 24),
                  CircluarButton(
                    iconData: Icons.check,
                    iconColor: Colors.green,
                    iconOpacity: okOpacity,
                    onPressed: _onOkPressed,
                  ),
                ],
              ),
              const Spacer(),
            ],
          );
        },
      ),
    );
  }
}

class Card extends StatelessWidget {
  const Card({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(10),
      clipBehavior: Clip.hardEdge,
      child: SizedBox(
        width: size.width * 0.8,
        height: size.height * 0.5,
        child: Image.asset(
          'assets/covers/$index.jpg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class CircluarButton extends StatelessWidget {
  const CircluarButton({
    super.key,
    required this.iconData,
    required this.iconColor,
    required this.iconOpacity,
    required this.onPressed,
  });

  final IconData iconData;
  final Color iconColor;
  final double iconOpacity;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      shape: const CircleBorder(
        side: BorderSide(
          color: Colors.white,
          width: 4,
        ),
      ),
      clipBehavior: Clip.hardEdge,
      child: Container(
        width: 64,
        height: 64,
        color: iconColor.withOpacity(1 - iconOpacity),
        child: IconButton(
          icon: Icon(iconData),
          color: iconOpacity == 1
              ? iconColor
              : Colors.white.withOpacity(1 - iconOpacity),
          iconSize: 36,
          onPressed: onPressed,
        ),
      ),
    );
  }
}
