import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:supermarket/core/config/constants/constants.dart';
import 'package:supermarket/core/config/constants/images.dart';
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
        const SizedBox(height: kAppPadding),
        Text(
          'No internet Conncetion',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
            //fontWeight: FontWeight.bold
          ),
        ),
        const SizedBox(height: kAppPadding),
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
              borderRadius: BorderRadius.circular(kAppRadius),
            ),
          ),
        ),
      ],
    );
  }
}
