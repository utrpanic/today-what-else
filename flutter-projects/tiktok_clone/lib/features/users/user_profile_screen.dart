import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: const Text('니꼬'),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const FaIcon(
                FontAwesomeIcons.gear,
                size: Sizes.size20,
              ),
            ),
          ],
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              const CircleAvatar(
                radius: Sizes.size48,
                foregroundColor: Colors.teal,
                foregroundImage: NetworkImage(
                  'https://avatars.githubusercontent.com/u/3612017',
                ),
                child: Text('니꼬'),
              ),
              Gaps.v20,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    '@니꼬',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: Sizes.size18,
                    ),
                  ),
                  Gaps.h4,
                  FaIcon(
                    FontAwesomeIcons.solidCircleCheck,
                    size: Sizes.size16,
                    color: Colors.blue.shade500,
                  ),
                ],
              ),
              Gaps.v24,
              const SizedBox(
                height: Sizes.size48,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    UserInfoView(
                      name: 'Following',
                      value: '97',
                    ),
                    UserInfoDivider(),
                    UserInfoView(
                      name: 'Followers',
                      value: '10M',
                    ),
                    UserInfoDivider(),
                    UserInfoView(
                      name: 'Likes',
                      value: '194.3M',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

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
            fontSize: Sizes.size18,
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
