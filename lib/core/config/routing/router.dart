import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:supermarket/core/config/constants/routes.dart';
import 'package:supermarket/core/config/di/injection.dart';
import 'package:supermarket/core/presentation/animations/page_route_animations.dart';
import 'package:supermarket/features/Address/presentation/blocs/addresses/addresses_bloc.dart';
import 'package:supermarket/features/Address/presentation/screens/address_screen.dart';
import 'package:supermarket/features/Address/presentation/screens/addresses_screen.dart';
import 'package:supermarket/features/Auth/presentation/screens/login_screen.dart';
import 'package:supermarket/features/Cart/presentation/blocs/cart_cubit/cart_cubit.dart';
import 'package:supermarket/features/Cart/presentation/screens/cart_screen.dart';
import 'package:supermarket/features/Categories/presentations/screens/categories_screen.dart';
import 'package:supermarket/features/Dashboard/presentation/screens/dashboard_screen.dart';
import 'package:supermarket/features/Home/presentation/screens/barcode_screen.dart';
import 'package:supermarket/features/Home/presentation/screens/home_screen.dart';
import 'package:supermarket/features/Onboarding/presentation/screens/splash_screen.dart';
import 'package:supermarket/features/Product/presentation/blocs/product/product_cubit.dart';
import 'package:supermarket/features/Product/presentation/screens/product_screen.dart';
import 'package:supermarket/features/Settings/presentation/screens/settings_screen.dart';
import 'package:supermarket/features/User/presentation/screens/profile_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: AppRoutes.splash,
  routes: [
    GoRoute(
      name: AppRoutes.splash,
      path: AppRoutes.splash,
      pageBuilder: (context, state) =>
          PageAnimatedRoute(key: state.pageKey, screen: const SplashScreen()),
    ),
    GoRoute(
      name: AppRoutes.login,
      path: AppRoutes.login,
      pageBuilder: (context, state) =>
          MaterialPage(key: state.pageKey, child: const LoginScreen()),
    ),
    StatefulShellRoute.indexedStack(
      pageBuilder: (context, state, navigationShell) => PageAnimatedRoute(
        key: state.pageKey,
        screen: DashboardScreen(navigationShell: navigationShell),
      ),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: AppRoutes.home,
              path: AppRoutes.home,
              builder: (context, state) => const HomeScreen(),
              routes: [
                GoRoute(
                  name: AppRoutes.scan,
                  path: AppRoutes.scan,
                  builder: (context, state) => BarcodeScreen(),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: AppRoutes.browse,
              path: AppRoutes.browse,
              builder: (context, state) => const CategoriesScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: AppRoutes.cart,
              path: AppRoutes.cart,
              builder: (context, state) => const CartScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: AppRoutes.more,
              path: AppRoutes.more,
              builder: (context, state) => SettingsScreen(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      name: AppRoutes.product,
      path: '${AppRoutes.product}/:id',
      pageBuilder: (context, state) => PageAnimatedRoute(
        key: state.pageKey,
        screen: MultiBlocProvider(
          providers: [
            BlocProvider<ProductCubit>.value(
              value: getIt<ProductCubit>(param1: state.pathParameters['id']),
            ),
            BlocProvider<CartCubit>.value(
              value: (state.extra as Map<String, dynamic>)['cart'] as CartCubit,
            ),
          ],
          child: ProductScreen(
            productName: (state.extra as Map<String, dynamic>)['name']
                .toString(),
          ),
        ),
      ),
    ),
    GoRoute(
      name: AppRoutes.profile,
      path: AppRoutes.profile,
      builder: (context, state) => ProfileScreen(),
    ),
    GoRoute(
      name: AppRoutes.addresses,
      path: AppRoutes.addresses,
      builder: (context, state) => BlocProvider<AddressesBloc>.value(
        value: state.extra as AddressesBloc,
        child: AddressesScreen(),
      ),
      routes: [
        GoRoute(
          name: AppRoutes.address,
          path: AppRoutes.address,
          builder: (context, state) => AddressScreen(),
        ),
      ],
    ),
  ],
);
