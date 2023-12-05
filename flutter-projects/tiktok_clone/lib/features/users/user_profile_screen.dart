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
    return DefaultTabController(
      length: 2,
      child: CustomScrollView(
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
                Container(
                  decoration: BoxDecoration(
                    border: Border.symmetric(
                      horizontal: BorderSide(
                        color: Colors.grey.shade200,
                        width: Sizes.size1,
                      ),
                    ),
                  ),
                  child: const TabBar(
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor: Colors.black,
                    labelPadding: EdgeInsets.symmetric(
                      vertical: Sizes.size12,
                    ),
                    labelColor: Colors.black,
                    tabs: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: Sizes.size12),
                        child: Icon(Icons.grid_4x4_rounded),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: Sizes.size12),
                        child: FaIcon(FontAwesomeIcons.heart),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: TabBarView(
                    children: [
                      GridView.builder(
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        itemCount: 20,
                        padding: const EdgeInsets.all(Sizes.size6),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: Sizes.size10,
                          mainAxisSpacing: Sizes.size10,
                          childAspectRatio: 9 / 20,
                        ),
                        itemBuilder: (context, index) => Column(
                          children: [
                            Container(
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Sizes.size4),
                              ),
                              child: AspectRatio(
                                aspectRatio: 9 / 16,
                                child: FadeInImage.assetNetwork(
                                  fit: BoxFit.cover,
                                  placeholder: 'assets/images/placeholder.jpg',
                                  image:
                                      'https://images.unsplash.com/photo-1647172084699-02ec43fa44a1?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxfDB8MXxyYW5kb218MHx8fHx8fHx8MTY5NDQwNDgxNA&ixlib=rb-4.0.3&q=80&w=1080',
                                ),
                              ),
                            ),
                            Gaps.v10,
                            const Text(
                              'This is a very long caption for my tictok that I upload just now currently.',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: Sizes.size12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Gaps.v5,
                            DefaultTextStyle(
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w600,
                              ),
                              child: Row(
                                children: [
                                  const CircleAvatar(
                                    radius: 12,
                                    backgroundImage: NetworkImage(
                                      'https://avatars.githubusercontent.com/u/5267524',
                                    ),
                                  ),
                                  Gaps.h4,
                                  const Expanded(
                                    child: Text(
                                      'My avatar is going to be very long.',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Gaps.h4,
                                  FaIcon(
                                    FontAwesomeIcons.heart,
                                    size: Sizes.size16,
                                    color: Colors.grey.shade600,
                                  ),
                                  Gaps.h2,
                                  const Text('2.5M'),
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
              ],
            ),
          ),
        ],
      ),
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
