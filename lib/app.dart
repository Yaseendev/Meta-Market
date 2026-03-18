import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/core/config/di/injection.dart';
import 'package:supermarket/core/config/routing/router.dart';
import 'package:supermarket/features/Auth/presentation/blocs/bloc/auth_bloc.dart';
import 'core/presentation/theme/app_theme.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => getIt<AuthBloc>(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.getRouterConfig(),
        theme: AppTheme.themeData,
      ),
    );
  }
}
