import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:supermarket/core/config/di/injection.dart';
import 'package:supermarket/features/Home/presentation/blocs/home/home_cubit.dart';

class DashboardScreen extends StatefulWidget {
  final StatefulNavigationShell _navigationShell;
  const DashboardScreen({
    super.key,
    required StatefulNavigationShell navigationShell,
  }) : _navigationShell = navigationShell;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final HomeCubit _homeCubit = getIt<HomeCubit>();
  void _goTo(int index) {
    widget._navigationShell.goBranch(
      index,
      initialLocation: index == widget._navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>.value(
      value: _homeCubit,
      child: Scaffold(
        body: widget._navigationShell,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: widget._navigationShell.currentIndex,
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
      ),
    );
  }
}
