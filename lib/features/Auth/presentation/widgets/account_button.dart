import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:gradient_ui/buttons/gradient_elevated_button.dart';
import 'package:supermarket/core/presentation/theme/colors.dart';
import 'package:supermarket/features/Auth/presentation/blocs/bloc/auth_bloc.dart';

enum ButtonState { idle, loading }

class AccountButton extends StatefulWidget {
  final VoidCallback onPress;
  final String label;
  final ButtonState? buttonState;
  const AccountButton({
    Key? key,
    required this.onPress,
    required this.label,
    this.buttonState,
  }) : super(key: key);

  @override
  State<AccountButton> createState() => _AccountButtonState();
}

class _AccountButtonState extends State<AccountButton> {
  ButtonState? buttonState;
  bool isAnimating = true;

  @override
  void initState() {
    buttonState = widget.buttonState ?? ButtonState.idle;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isStretched = isAnimating || buttonState == ButtonState.idle;
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          setState(() {
            buttonState = ButtonState.loading;
          });
        } else {
          setState(() {
            buttonState = ButtonState.idle;
          });
        }
      },
      child: Container(
        alignment: Alignment.center,
        child: AnimatedContainer(
          width: buttonState == ButtonState.idle
              ? MediaQuery.of(context).size.width
              : 80,
          duration: const Duration(milliseconds: 250),
          onEnd: () => setState(() => isAnimating = !isAnimating),
          curve: Curves.easeIn,
          child: 
          // isStretched
          //     ? GradientElevatedButton(
          //         gradient: AppColors.gradinat,
          //         child: Text(
          //           widget.label.toUpperCase(),
          //           style: TextStyle(
          //             color: Colors.white,
          //             fontSize: 18,
          //           ),
          //         ),
          //         onPressed: () {
          //           widget.onPress();
          //         },
          //         style: ButtonStyle(
          //           shape: MaterialStateProperty.all(RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(100),
          //           )),
          //           padding: MaterialStateProperty.all(
          //               EdgeInsets.symmetric(vertical: 14, horizontal: 35)),
          //         ),
          //       )
          //     : 
              Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: AppColors.gradinat
                  ),
                  padding: EdgeInsets.all(12),
                  child: Center(
                      child: CircularProgressIndicator(color: Colors.white)),
                ),
        ),
      ),
    );
  }
}
