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
    final dropZone = size.width + 100;
    debugPrint('${_position.value.abs()}');
    debugPrint('$bound');
    if (_position.value.abs() >= bound) {
      if (_position.value.isNegative) {
        _position.animateTo(dropZone * -1).whenComplete(
              _whenAnimationComplete,
            );
      } else {
        _position.animateTo(dropZone).whenComplete(
              _whenAnimationComplete,
            );
      }
    } else {
      _position.animateTo(0, curve: Curves.easeOut);
    }
  }

  void _whenAnimationComplete() {
    _position.value = 0;
    setState(() {
      _index += 1;
    });
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
          final scale = _scale.transform(
            (_position.value.abs() + (size.width / 2)) / size.width,
          );
          return Stack(
            alignment: Alignment.topCenter,
            children: [
              Positioned(
                top: 100,
                child: Transform.scale(
                  scale: scale,
                  child: Card(index: (_index + 1) % 5),
                ),
              ),
              Positioned(
                top: 100,
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
