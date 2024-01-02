import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class UserInfoView extends StatelessWidget {
  const UserInfoView({
    super.key,
    required this.name,
    required this.value,
  });
  final String name;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Sizes.size16,
          ),
        ),
        Gaps.v4,
        Text(
          name,
          style: TextStyle(
            color: Colors.grey.shade500,
          ),
        ),
      ],
    );
  }
}
