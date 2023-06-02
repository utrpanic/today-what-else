import 'package:flutter/material.dart';

class ImplicitAnimationsScreen extends StatefulWidget {
  const ImplicitAnimationsScreen({super.key});

  @override
  State<ImplicitAnimationsScreen> createState() =>
      _ImplicitAnimationsScreenState();
}

class _ImplicitAnimationsScreenState extends State<ImplicitAnimationsScreen> {
  bool _visible = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Implicit Animations'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TweenAnimationBuilder(
              tween: ColorTween(
                begin: Colors.blue,
                end: Colors.red,
              ),
              duration: const Duration(seconds: 1),
              curve: Curves.bounceInOut,
              builder: (context, value, child) {
                return Image.network(
                  'https://upload.wikimedia.org/wikipedia/commons/4/4f/Dash%2C_the_mascot_of_the_Dart_programming_language.png',
                  color: value,
                  colorBlendMode: BlendMode.colorBurn,
                );
              },
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: _trigger,
              child: const Text('Go!'),
            )
          ],
        ),
      ),
    );
  }

  void _trigger() {
    setState(() {
      _visible = !_visible;
    });
  }
}
