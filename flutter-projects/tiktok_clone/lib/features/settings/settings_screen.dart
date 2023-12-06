import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('설정'),
      ),
      body: ListWheelScrollView(
        itemExtent: 44,
        children: [
          const CloseButton(),
          FractionallySizedBox(
            widthFactor: 1,
            child: Container(
              color: Colors.teal,
              alignment: Alignment.center,
              child: const Text(
                'Pick me',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          const CupertinoActivityIndicator(),
          const CircularProgressIndicator(),
          const CircularProgressIndicator.adaptive(),
        ],
      ),
    );
  }
}
