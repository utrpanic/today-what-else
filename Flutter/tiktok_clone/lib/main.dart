import 'package:flutter/material.dart';
import 'package:tiktok_clone/screens/sign_up/sign_up_screen.dart';

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
      home: const SignUpScreen(),
    );
  }
}
