import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:supermarket/core/config/constants/images.dart';
import 'package:supermarket/core/presentation/constants/ui_spaces.dart';
import '../blocs/splash_bloc/splash_bloc.dart';

class SplashNoInternetWidget extends StatelessWidget {
  const SplashNoInternetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: SvgPicture.asset(
            AppImages.noInternet,
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width * .8,
            //height: MediaQuery.of(context).size.height * .4,
          ),
        ),
        SizedBox(height: UISpaces.sm),
        Text(
          'No internet Connection',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
            //fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(height: UISpaces.sm),
        ElevatedButton(
          onPressed: () {
            context.read<SplashBloc>().add(CheckAppState());
          },
          child: Text('Try Again'),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(
              horizontal: 32,
              vertical: 12,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(UISpaces.radius),
            ),
          ),
        ),
      ],
    );
  }
}
