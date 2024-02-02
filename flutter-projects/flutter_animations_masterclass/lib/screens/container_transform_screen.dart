import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class ContainerTransformScreen extends StatefulWidget {
  const ContainerTransformScreen({super.key});

  @override
  State<ContainerTransformScreen> createState() =>
      _ContainerTransformScreenState();
}

class _ContainerTransformScreenState extends State<ContainerTransformScreen> {
  bool _isGrid = false;

  void _toggleGrid() {
    _isGrid = !_isGrid;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Container Transform'),
        actions: [
          IconButton(
            onPressed: _toggleGrid,
            icon: const Icon(Icons.grid_4x4),
          ),
        ],
      ),
      body: _isGrid
          ? GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 1 / 1.3,
              ),
              itemCount: 10,
              itemBuilder: (context, index) => OpenContainer(
                transitionDuration: const Duration(seconds: 1),
                closedBuilder: (context, action) => Column(
                  children: [
                    Image.asset(
                      'assets/covers/${index % 5}.jpg',
                    ),
                    const SizedBox(height: 8),
                    const Text('Dune Soundtrack'),
                    const Text(
                      'Hans Zimmer',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                openBuilder: (context, action) => DetailScreen(
                  image: index % 5,
                ),
              ),
            )
          : ListView.separated(
              itemBuilder: (context, index) => OpenContainer(
                openElevation: 0,
                closedElevation: 0,
                transitionDuration: const Duration(seconds: 1),
                openBuilder: (context, action) => DetailScreen(
                  image: index % 5,
                ),
                closedBuilder: (context, action) => ListTile(
                  leading: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/covers/${index % 5}.jpg'),
                      ),
                    ),
                  ),
                  title: const Text('Dune Soundtrack'),
                  subtitle: const Text('Hans Zimmer'),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey.shade400,
                  ),
                ),
              ),
              separatorBuilder: (context, index) => Divider(
                color: Colors.grey.shade200,
              ),
              itemCount: 10,
            ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.image});

  final int image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Screen'),
      ),
      body: Column(
        children: [
          Image.asset('assets/covers/$image.jpg'),
          const Text(
            'Detail Screen',
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
