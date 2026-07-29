import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:supermarket/core/config/constants/routes.dart';
import 'package:supermarket/features/Auth/presentation/blocs/bloc/auth_bloc.dart';
import '../widgets/splash_no_internet_widget.dart';
import '../widgets/splash_error_widget.dart';
import '../widgets/splash_loading_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthBloc>().add(CheckAuthState());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoggedIn) {
          return context.go(AppRoutes.home);
        } else if (state is AuthLoggedOut) {
          return context.go(AppRoutes.login);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthNoInternet)
              return const SplashNoInternetWidget();
            else if (state is AuthError)
              return SplashErrorWidget(
                errorMsg: state.msg,
                onTryAgain: () =>
                    context.read<AuthBloc>().add(CheckAuthState()),
              );
            return const SplashLoadingWidget();
          },
        ),
      ),
    );
  }
}
