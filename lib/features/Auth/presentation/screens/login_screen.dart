import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/core/config/constants/constants.dart';
import 'package:supermarket/core/config/constants/images.dart';
import 'package:supermarket/core/presentation/dialogs/dialogs.dart';
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
          //TODO: LoadUserData + Go to home screen
          print('Logged in |)');
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: kAppPadding2,
              vertical: 8,
            ),
            child: Column(
              children: [
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
                const SizedBox(height: kAppPadding2),
                Expanded(child: LoginForm()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
