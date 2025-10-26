import 'package:flutter/material.dart';

import 'features/view_pets/presentation/pages/view_pets_page.dart';

class PetFinderApp extends StatefulWidget {
  const PetFinderApp({super.key});

  @override
  State<PetFinderApp> createState() => _PetFinderAppState();
}

class _PetFinderAppState extends State<PetFinderApp> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    ViewPetsPage(),
    FavoritesPage(),
    MessagesPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    const selectedColor = Color(0xFF1ABC9C); // أخضر تركواز زي زرار Get started
    const unselectedColor = Colors.grey;

    final List<IconData> icons = [
      Icons.home_rounded,
      Icons.favorite_rounded,
      Icons.chat_bubble_rounded,
      Icons.person_rounded,
    ];

    final List<String> labels = [
      'Home',
      'Favorites',
      'Messages',
      'Profile',
    ];

    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: selectedColor,
        unselectedItemColor: unselectedColor,
        selectedFontSize: 13,
        unselectedFontSize: 13,
        elevation: 10,
        items: List.generate(icons.length, (index) {
          final isSelected = _currentIndex == index;
          return BottomNavigationBarItem(
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              transitionBuilder: (child, anim) =>
                  ScaleTransition(scale: anim, child: child),
              child: Icon(
                icons[index],
                key: ValueKey('icon-$index-$isSelected'),
                color: isSelected ? selectedColor : unselectedColor,
              ),
            ),
            label: labels[index],
          );
        }),
      ),
    );
  }
}


class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});
  @override
  Widget build(BuildContext context) =>
      const Center(child: Text('Favorites Page'));
}

class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});
  @override
  Widget build(BuildContext context) =>
      const Center(child: Text('Messages Page'));
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) =>
      const Center(child: Text('Profile Page'));
}
