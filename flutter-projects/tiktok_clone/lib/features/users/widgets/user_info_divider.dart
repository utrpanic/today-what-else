import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class UserInfoDivider extends StatelessWidget {
  const UserInfoDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return VerticalDivider(
      width: Sizes.size32,
      thickness: Sizes.size1,
      color: Colors.grey.shade500,
      indent: Sizes.size12,
      endIndent: Sizes.size12,
    );
  }
}
