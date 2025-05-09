import 'package:flutter/material.dart';
import 'package:flutter_animations_masterclass/screens/apple_watch_screen.dart';
import 'package:flutter_animations_masterclass/screens/container_transform_screen.dart';
import 'package:flutter_animations_masterclass/screens/explicit_animations_screen.dart';
import 'package:flutter_animations_masterclass/screens/fade_through_screen.dart';
import 'package:flutter_animations_masterclass/screens/implicit_animations_screen.dart';
import 'package:flutter_animations_masterclass/screens/music_player_screen.dart';
import 'package:flutter_animations_masterclass/screens/rive_screen.dart';
import 'package:flutter_animations_masterclass/screens/shared_axis_screen.dart';
import 'package:flutter_animations_masterclass/screens/swiping_cards_screen.dart';
import 'package:flutter_animations_masterclass/screens/wallet_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Animations'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                _goToPage(
                  context,
                  const ImplicitAnimationsScreen(),
                );
              },
              child: const Text('Implicit Animaions'),
            ),
            ElevatedButton(
              onPressed: () {
                _goToPage(
                  context,
                  const ExplicitAnimationsScreen(),
                );
              },
              child: const Text('Explicit Animaions'),
            ),
            ElevatedButton(
              onPressed: () {
                _goToPage(
                  context,
                  const AppleWatchScreen(),
                );
              },
              child: const Text('Apple Watch'),
            ),
            ElevatedButton(
              onPressed: () {
                _goToPage(
                  context,
                  const SwipingCardsScreen(),
                );
              },
              child: const Text('Swiping Cards'),
            ),
            ElevatedButton(
              onPressed: () {
                _goToPage(
                  context,
                  const MusicPlayerScreen(),
                );
              },
              child: const Text('Music Player'),
            ),
            ElevatedButton(
              onPressed: () {
                _goToPage(
                  context,
                  const RiveScreen(),
                );
              },
              child: const Text('Rive'),
            ),
            ElevatedButton(
              onPressed: () {
                _goToPage(
                  context,
                  const ContainerTransformScreen(),
                );
              },
              child: const Text('Container Transform'),
            ),
            ElevatedButton(
              onPressed: () {
                _goToPage(
                  context,
                  const SharedAxisScreen(),
                );
              },
              child: const Text('Shared Axis'),
            ),
            ElevatedButton(
              onPressed: () {
                _goToPage(
                  context,
                  const FadeThroughScreen(),
                );
              },
              child: const Text('Fade Through'),
            ),
            ElevatedButton(
              onPressed: () {
                _goToPage(
                  context,
                  const WalletScreen(),
                );
              },
              child: const Text('Wallet Screen'),
            ),
          ],
        ),
      ),
    );
  }

  void _goToPage(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => page,
      ),
    );
  }
}
