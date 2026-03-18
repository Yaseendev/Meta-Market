import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/features/Auth/presentation/blocs/bloc/auth_bloc.dart';
import '../blocs/splash_bloc/splash_bloc.dart';
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
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        context.read<AuthBloc>().add(CheckAuthState());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<SplashBloc, SplashState>(
        builder: (context, state) {
          if (state is SplashNoInternet)
            return const SplashNoInternetWidget();
          else if (state is SplashError)
            return SplashErrorWidget(
              errorMsg: state.msg,
              onTryAgain: () => context.read<SplashBloc>().add(CheckAppState()),
            );
          return const SplashLoadingWidget();
        },
      ),
    );
  }
}
