import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:supermarket/core/config/constants/images.dart';
import 'package:supermarket/core/config/constants/routes.dart';
import 'package:supermarket/core/config/di/injection.dart';
import 'package:supermarket/core/presentation/constants/ui_spaces.dart';
import 'package:supermarket/core/presentation/dialogs/dialogs.dart';
import 'package:supermarket/features/User/presentation/blocs/profile/profile_cubit.dart';
import '../blocs/bloc/auth_bloc.dart';
import '../widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthNoInternet) {
          showNoInternetSnackBar(context);
        } else if (state is AuthError) {
          showErrorSnackBar(context, state.msg);
        } else if (state is AuthLoggedIn) {
          getIt<ProfileCubit>().loadUser();
          context.go(AppRoutes.home);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: UIMetrics.md,
              vertical: 8,
            ),
            child: Column(
              children: [
                const SizedBox(height: UIMetrics.sm),
                Column(
                  children: [
                    Image.asset(
                      AppImages.logoTransparent,
                      height: MediaQuery.of(context).size.height * .2,
                      fit: BoxFit.fill,
                    ),
                    Text(
                      'Welcome to Meta Market',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: UIMetrics.lg),
                Expanded(child: LoginForm()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
