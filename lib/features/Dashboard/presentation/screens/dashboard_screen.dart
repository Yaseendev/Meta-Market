import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DashboardScreen extends StatelessWidget {
  final StatefulNavigationShell _navigationShell;
  const DashboardScreen({
    super.key,
    required StatefulNavigationShell navigationShell,
  }) : _navigationShell = navigationShell;

  void _goTo(int index) {
    _navigationShell.goBranch(
      index,
      initialLocation: index == _navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _navigationShell.currentIndex,
        onTap: _goTo,
        items: [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home_rounded),
          ),
          BottomNavigationBarItem(
            label: 'Browse',
            icon: Icon(Icons.horizontal_split_rounded),
          ),
          BottomNavigationBarItem(
            label: 'Cart',
            icon: Icon(Icons.shopping_cart_rounded),
          ),
          BottomNavigationBarItem(
            label: 'More',
            icon: Icon(Icons.more_horiz_rounded),
          ),
        ],
      ),
    );
  }
}
