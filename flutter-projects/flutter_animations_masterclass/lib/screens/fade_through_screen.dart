import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class FadeThroughScreen extends StatefulWidget {
  const FadeThroughScreen({super.key});

  @override
  State<FadeThroughScreen> createState() => _FadeThroughScreenState();
}

class _FadeThroughScreenState extends State<FadeThroughScreen> {
  var _index = 0;

  void _onNewDestination(int newIndex) {
    _index = newIndex;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fade Through'),
      ),
      body: PageTransitionSwitcher(
        transitionBuilder: (child, primaryAnimation, secondaryAnimation) =>
            FadeThroughTransition(
          animation: primaryAnimation,
          secondaryAnimation: secondaryAnimation,
          child: child,
        ),
        child: [
          const NavigationPage(
            key: ValueKey(0),
            text: 'Profile',
            icon: Icons.person,
          ),
          const NavigationPage(
            key: ValueKey(1),
            text: 'Notifications',
            icon: Icons.notifications,
          ),
          const NavigationPage(
            key: ValueKey(2),
            text: 'Settings',
            icon: Icons.settings,
          ),
        ][_index],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: _onNewDestination,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
          NavigationDestination(
            icon: Icon(Icons.notifications_none),
            selectedIcon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

class NavigationPage extends StatelessWidget {
  const NavigationPage({super.key, required this.text, required this.icon});

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            Icon(
              icon,
              size: 24,
            ),
            const SizedBox(height: 16),
            Text(
              text,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
