import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:supermarket/core/config/constants/routes.dart';
import 'package:supermarket/core/presentation/animations/page_route_animations.dart';
import 'package:supermarket/features/Auth/presentation/blocs/bloc/auth_bloc.dart';
import 'package:supermarket/features/Auth/presentation/screens/login_screen.dart';
import 'package:supermarket/features/Dashboard/presentation/screens/dashboard_screen.dart';
import 'package:supermarket/features/Home/presentation/screens/home_screen.dart';
import 'package:supermarket/features/Onboarding/presentation/screens/splash_screen.dart';

class AppRouter {
  AppRouter._();

  static AppRouter I = AppRouter._();

  static GoRouter getRouterConfig() {
    final GoRouter router = GoRouter(
      initialLocation: AppRoutes.home,
      routes: [
        GoRoute(
          name: AppRoutes.splash,
          path: AppRoutes.splash,
          pageBuilder: (context, state) => PageAnimatedRoute(
            key: state.pageKey,
            screen: const SplashScreen(),
          ),
        ),
        GoRoute(
          name: AppRoutes.login,
          path: AppRoutes.login,
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: const LoginScreen(),
          ),
        ),
        StatefulShellRoute.indexedStack(
          pageBuilder: (context, state, navigationShell) => PageAnimatedRoute(
            key: state.pageKey,
            screen: DashboardScreen(
              navigationShell: navigationShell,
            ),
          ),
          branches: [
            StatefulShellBranch(
              routes: [
                GoRoute(
                  name: AppRoutes.home,
                  path: AppRoutes.home,
                  builder: (context, state) => const HomeScreen(),
                ),
                GoRoute(
                  name: AppRoutes.browse,
                  path: AppRoutes.browse,
                  builder: (context, state) => Container(),
                ),
                GoRoute(
                  name: AppRoutes.cart,
                  path: AppRoutes.cart,
                  builder: (context, state) => Container(),
                ),
                GoRoute(
                  name: AppRoutes.more,
                  path: AppRoutes.more,
                  builder: (context, state) => Container(),
                ),
              ],
            ),
          ],
        ),
      ],
      redirect: (context, state) {
        final authState = context.read<AuthBloc>().state;
        if (authState is AuthLoggedIn) {
          return AppRoutes.primary;
        } else if (authState is AuthLoggedOut) {
          return AppRoutes.login;
        }

        return null;
      },
    );
    return router;
  }
}
