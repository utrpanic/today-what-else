import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class VideoButton extends StatelessWidget {
  const VideoButton({
    super.key,
    required this.icon,
    required this.text,
    Color? iconColor,
  }) : _iconColor = iconColor ?? Colors.white;

  final IconData icon;
  final String text;
  final Color _iconColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FaIcon(
          icon,
          color: _iconColor,
          size: Sizes.size40,
        ),
        Gaps.v5,
        Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
