import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:supermarket/core/config/constants/images.dart';
import 'package:supermarket/core/presentation/constants/ui_spaces.dart';

class SplashErrorWidget extends StatelessWidget {
  final String errorMsg;
  final VoidCallback onTryAgain;
  const SplashErrorWidget({
  super.key,
  required this.errorMsg,
  required this.onTryAgain,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: SvgPicture.asset(
            AppImages.error,
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width * .8,
            //height: MediaQuery.of(context).size.height * .4,
          ),
        ),
        SizedBox(height: UISpaces.sm),
        Text(
          errorMsg,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
            //fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(height: UISpaces.sm),
        ElevatedButton(
          onPressed: onTryAgain,
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
