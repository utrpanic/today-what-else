import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/settings/settings_screen.dart';
import 'package:tiktok_clone/features/users/widgets/persistent_tab_bar.dart';
import 'package:tiktok_clone/features/users/widgets/user_info_divider.dart';
import 'package:tiktok_clone/features/users/widgets/user_info_view.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  void _onGearPressed() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => const SettingsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                title: const Text('니꼬'),
                actions: [
                  IconButton(
                    onPressed: _onGearPressed,
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
                    Gaps.v12,
                    FractionallySizedBox(
                      widthFactor: 0.33,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: Sizes.size12,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(Sizes.size4),
                        ),
                        child: const Text(
                          'Follow',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Gaps.v12,
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Sizes.size64,
                      ),
                      child: Text(
                        'All highlights and where to watch live matches on FIFA+',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Gaps.v12,
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.link,
                          size: Sizes.size12,
                        ),
                        Gaps.h4,
                        Text(
                          'https://nomadcoders.co',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Gaps.v8,
                  ],
                ),
              ),
              SliverPersistentHeader(
                delegate: PersistentTabBar(),
                pinned: true,
              ),
            ];
          },
          body: TabBarView(
            children: [
              GridView.builder(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                itemCount: 20,
                padding: EdgeInsets.zero,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: Sizes.size2,
                  mainAxisSpacing: Sizes.size2,
                  childAspectRatio: 9 / 16,
                ),
                itemBuilder: (context, index) => Stack(
                  children: [
                    AspectRatio(
                      aspectRatio: 9 / 16,
                      child: FadeInImage.assetNetwork(
                        fit: BoxFit.cover,
                        placeholder: 'assets/images/placeholder.jpg',
                        image:
                            'https://images.unsplash.com/photo-1647172084699-02ec43fa44a1?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxfDB8MXxyYW5kb218MHx8fHx8fHx8MTY5NDQwNDgxNA&ixlib=rb-4.0.3&q=80&w=1080',
                      ),
                    ),
                    if (index == 0)
                      Positioned(
                        top: Sizes.size4,
                        left: Sizes.size4,
                        child: Container(
                          padding: const EdgeInsets.all(Sizes.size4),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(Sizes.size4),
                          ),
                          child: const Text(
                            'Pinned',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    const Positioned(
                      bottom: Sizes.size4,
                      left: Sizes.size4,
                      child: Row(
                        children: [
                          FaIcon(
                            FontAwesomeIcons.play,
                            size: Sizes.size12,
                            color: Colors.white,
                          ),
                          Gaps.h4,
                          Text(
                            '4.1M',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Center(child: Text('Tab Two')),
            ],
          ),
        ),
      ),
    );
  }
}
