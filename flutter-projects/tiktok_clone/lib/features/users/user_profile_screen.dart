import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/settings/settings_screen.dart';
import 'package:tiktok_clone/features/users/update_user_profile_screen.dart';
import 'package:tiktok_clone/features/users/view_models/users_view_model.dart';
import 'package:tiktok_clone/features/users/widgets/avatar.dart';
import 'package:tiktok_clone/features/users/widgets/persistent_tab_bar.dart';
import 'package:tiktok_clone/features/users/widgets/user_info_divider.dart';
import 'package:tiktok_clone/features/users/widgets/user_info_view.dart';

class UserProfileScreen extends ConsumerStatefulWidget {
  const UserProfileScreen({super.key, this.tab});

  final String? tab;

  @override
  UserProfileScreenState createState() => UserProfileScreenState();
}

class UserProfileScreenState extends ConsumerState<UserProfileScreen> {
  void _onPenToSquarePressed() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => const UpdateUserProfileScreen(),
      ),
    );
  }

  void _onGearPressed() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => const SettingsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(usersProvider).when(
          loading: () => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
          error: (error, stackTrace) => Center(
            child: Text(error.toString()),
          ),
          data: (data) => Scaffold(
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            body: SafeArea(
              child: DefaultTabController(
                initialIndex: widget.tab == 'likes' ? 1 : 0,
                length: 2,
                child: NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return [
                      SliverAppBar(
                        title: Text(data.name),
                        actions: [
                          IconButton(
                            onPressed: _onPenToSquarePressed,
                            icon: const FaIcon(
                              FontAwesomeIcons.penToSquare,
                              size: Sizes.size20,
                            ),
                          ),
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
                            Gaps.v20,
                            Avatar(
                              uid: data.uid,
                              name: data.name,
                              hasAvatar: data.hasAvatar,
                            ),
                            Gaps.v20,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '@${data.name}',
                                  style: const TextStyle(
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
                                  borderRadius:
                                      BorderRadius.circular(Sizes.size4),
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
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: Sizes.size64,
                              ),
                              child: Text(
                                data.bio,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Gaps.v12,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const FaIcon(
                                  FontAwesomeIcons.link,
                                  size: Sizes.size12,
                                ),
                                Gaps.h4,
                                Text(
                                  data.link,
                                  style: const TextStyle(
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
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
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
                                    borderRadius:
                                        BorderRadius.circular(Sizes.size4),
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
            ),
          ),
        );
  }
}
