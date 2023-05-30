import 'package:flutter/material.dart';

import '../../constants/sizes.dart';

class DiscoverScreen extends StatelessWidget {
  DiscoverScreen({super.key});

  final tabs = [
    'Top',
    'Users',
    'Videos',
    'Sounds',
    'LIVE',
    'Show',
    'Brand',
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
          appBar: AppBar(
            elevation: 1,
            title: const Text('Discover'),
            bottom: TabBar(
              splashFactory: NoSplash.splashFactory,
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size16,
              ),
              isScrollable: true,
              labelStyle: const TextStyle(
                  fontWeight: FontWeight.w600, fontSize: Sizes.size16),
              indicatorColor: Colors.black,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey.shade500,
              tabs: [
                for (var tab in tabs)
                  Tab(
                    text: tab,
                  )
              ],
            ),
          ),
          body: TabBarView(
            children: [
              for (var tab in tabs)
                Center(
                  child: Text(
                    tab,
                    style: const TextStyle(
                      fontSize: 28,
                    ),
                  ),
                )
            ],
          )),
    );
  }
}
