import 'package:flutter/material.dart';
import 'package:github_user_explorer/features/users/presentation/pages/users_page.dart';

import '../../../../core/constants/constants.dart';
import 'favorites_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() =>
      _HomePageState();
}

class _HomePageState
    extends State<HomePage> {
  int currentIndex = 0;

  final pages = const [
    UsersPage(),
    FavoritesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],

      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.people),
            label: Constants.githubUsers,
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite),
            label: Constants.favoriteUsers,
          ),
        ],
      ),
    );
  }
}