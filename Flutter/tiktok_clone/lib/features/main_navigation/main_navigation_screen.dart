import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  final screens = [
    const Center(
      child: Text('Home'),
    ),
    const Center(
      child: Text('Search1'),
    ),
    const Center(
      child: Text('Search2'),
    ),
    const Center(
      child: Text('Search3'),
    ),
    const Center(
      child: Text('Search4'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onTap,
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        destinations: const [
          NavigationDestination(
            icon: FaIcon(
              FontAwesomeIcons.house,
              color: Colors.white,
            ),
            label: 'Home',
          ),
          NavigationDestination(
            icon: FaIcon(
              FontAwesomeIcons.magnifyingGlass,
              color: Colors.white,
            ),
            label: 'Search1',
          ),
          NavigationDestination(
            icon: FaIcon(
              FontAwesomeIcons.magnifyingGlass,
              color: Colors.white,
            ),
            label: 'Search2',
          ),
          NavigationDestination(
            icon: FaIcon(
              FontAwesomeIcons.magnifyingGlass,
              color: Colors.white,
            ),
            label: 'Search3',
          ),
          NavigationDestination(
            icon: FaIcon(
              FontAwesomeIcons.magnifyingGlass,
              color: Colors.white,
            ),
            label: 'Search4',
          ),
        ],
      ),
    );
  }

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
