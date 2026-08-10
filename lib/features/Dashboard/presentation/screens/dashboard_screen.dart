import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:supermarket/core/config/di/injection.dart';
import 'package:supermarket/core/presentation/translations/locale_keys.g.dart';
import 'package:supermarket/features/Address/presentation/blocs/addresses/addresses_bloc.dart';
import 'package:supermarket/features/Cart/presentation/blocs/cart_cubit/cart_cubit.dart';
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
  final CartCubit _cartCubit = getIt<CartCubit>();
  final AddressesBloc _addressesBloc = getIt<AddressesBloc>();
  void _goTo(int index) {
    widget._navigationShell.goBranch(
      index,
      initialLocation: index == widget._navigationShell.currentIndex,
    );
  }

  @override
  void initState() {
    super.initState();
    _cartCubit.getCart();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>.value(value: _homeCubit),
        BlocProvider<CartCubit>.value(value: _cartCubit),
        BlocProvider<AddressesBloc>.value(value: _addressesBloc),
      ],
      child: Scaffold(
        body: widget._navigationShell,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: widget._navigationShell.currentIndex,
          onTap: _goTo,
          items: [
            BottomNavigationBarItem(
              label: LocaleKeys.home.tr(context: context),
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home_rounded),
            ),
            BottomNavigationBarItem(
              label: LocaleKeys.browse.tr(context: context),
              icon: Icon(Icons.horizontal_split_rounded),
            ),
            BottomNavigationBarItem(
              label: LocaleKeys.cart.tr(context: context),
              icon: Icon(Icons.shopping_cart_outlined),
              activeIcon: Icon(Icons.shopping_cart_rounded),
            ),
            BottomNavigationBarItem(
              label: LocaleKeys.more.tr(context: context),
              icon: Icon(Icons.more_horiz_rounded),
            ),
          ],
        ),
      ),
    );
  }
}
