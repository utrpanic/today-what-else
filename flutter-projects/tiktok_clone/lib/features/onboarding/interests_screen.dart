import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/onboarding/tutorial_screen.dart';
import 'package:tiktok_clone/features/onboarding/widgets/interest_button.dart';

const interests = [
  'Daily Life',
  'Comedy',
  'Entertainment',
  'Animals',
  'Food',
  'Beauty & Style',
  'Drama',
  'Learning',
  'Talent',
  'Sports',
  'Auto',
  'Family',
  'Fitness & Health',
  'DIY & Life Hacks',
  'Arts & Crafts',
  'Dance',
  'Outdoors',
  'Oddly Satisfying',
  'Home & Garden',
  'Daily Life',
  'Comedy',
  'Entertainment',
  'Animals',
  'Food',
  'Beauty & Style',
  'Drama',
  'Learning',
  'Talent',
  'Sports',
  'Auto',
  'Family',
  'Fitness & Health',
  'DIY & Life Hacks',
  'Arts & Crafts',
  'Dance',
  'Outdoors',
  'Oddly Satisfying',
  'Home & Garden',
];

class InterestsScreen extends StatefulWidget {
  const InterestsScreen({super.key});

  static const String routeName = 'interests';
  static const String routeURL = '/tutorial';

  @override
  State<InterestsScreen> createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _showTitle = false;

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AnimatedOpacity(
          opacity: _showTitle ? 1 : 0,
          duration: const Duration(milliseconds: 200),
          child: const Text('Choose your interests'),
        ),
      ),
      body: Scrollbar(
        controller: _scrollController,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Padding(
            padding: const EdgeInsets.only(
              left: Sizes.size24,
              right: Sizes.size24,
              bottom: Sizes.size16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gaps.v32,
                const Text(
                  'Choose your interests',
                  style: TextStyle(
                    fontSize: Sizes.size40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gaps.v20,
                const Text(
                  'Get better video recommendations',
                  style: TextStyle(
                    fontSize: Sizes.size20,
                  ),
                ),
                Gaps.v64,
                Wrap(
                  runSpacing: 15,
                  spacing: 15,
                  children: [
                    for (final interest in interests)
                      InterestButton(interest: interest),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          bottom: Sizes.size40,
          top: Sizes.size16,
          left: Sizes.size24,
          right: Sizes.size24,
        ),
        child: GestureDetector(
          onTap: _onNextTap,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: Sizes.size20),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: const Text(
              'Next',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: Sizes.size16,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onScroll() {
    if (_scrollController.offset > 110) {
      if (_showTitle) return;
      setState(() {
        _showTitle = true;
      });
    } else {
      if (!_showTitle) return;
      setState(() {
        _showTitle = false;
      });
    }
  }

  void _onNextTap() {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (_) => const TutorialScreen(),
      ),
    );
  }
}
