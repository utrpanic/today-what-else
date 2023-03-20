import 'package:flutter/material.dart';

import 'constants/gaps.dart';

void main() {
  runApp(const TikTokApp());
}

class TikTokApp extends StatelessWidget {
  const TikTokApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tictok Clone',
      theme: ThemeData(
        primaryColor: const Color(0xffe9435a),
      ),
      home: Container(
        child: Row(children: const [
          Text('hello'),
          Gaps.h20,
          Text('hello'),
        ]),
      ),
    );
  }
}
