import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../blocs/bloc/auth_bloc.dart';
import '../screens/signup_screen.dart';
import 'account_button.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  bool passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100)),
                hintText: 'E-mail',
                prefixIcon: Icon(Icons.email_outlined),
              ),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              maxLines: 1,
              initialValue: email,
              onChanged: (value) => email = value,
              validator: (value) {
                return !EmailValidator.validate(value ?? '')
                    ? 'Please enter a valid email'
                    : null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100)),
                hintText: 'Password',
                // labelText: 'Password',
                prefixIcon: Icon(Icons.password),
                suffixIcon: passwordVisible
                    ? IconButton(
                        icon: const Icon(Icons.visibility),
                        onPressed: () => setState(() {
                          passwordVisible = false;
                        }),
                      )
                    : IconButton(
                        onPressed: () => setState(() {
                          passwordVisible = true;
                        }),
                        icon: const Icon(Icons.visibility_off),
                      ),
              ),
              keyboardType: TextInputType.visiblePassword,
              maxLines: 1,
              onChanged: (value) => password = value,
              obscureText: passwordVisible,
              validator: (value) {
                return value!.trim().isNotEmpty
                    ? value.trim().length > 6
                        ? null
                        : 'Password must be longer than 6 characters'
                    : 'This field is required';
              },
            ),
            const SizedBox(height: 20),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return AccountButton(
                  buttonState: state is AuthLoading
                      ? ButtonState.loading
                      : ButtonState.idle,
                  label: 'Login',
                  onPress: () {
                    FocusScope.of(context).unfocus();
                    if (_formKey.currentState!.validate()) {
                      context.read<AuthBloc>().add(LoginEvent(
                            email: email,
                            password: password,
                          ));
                    }
                  },
                );
              },
            ),
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                child: Text('Forgot Password?'),
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(child: Divider()),
                Text('  Or Continue With  '),
                Expanded(child: Divider()),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      return ElevatedButton.icon(
                        onPressed: () async {
                          context.read<AuthBloc>().add(GoogleAuthEvent());
                        },
                        icon: state is AuthGoogleLoading
                            ? CircularProgressIndicator.adaptive(
                                valueColor:
                                    const AlwaysStoppedAnimation(Colors.white),
                              )
                            : Icon(
                                FontAwesomeIcons.google,
                                color: Colors.white,
                              ),
                        label: Text(
                          'Google',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Color(0xFFE6242E)),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(16)),
                          shape:
                              MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          )),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      //context.read<AccountBloc>().add(LoginWithFacebookEvent());
                    },
                    icon: Icon(
                      FontAwesomeIcons.facebookF,
                      color: Colors.white,
                    ),
                    label: Text(
                      'Facebook',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xFF4267B2)),
                      padding: MaterialStateProperty.all(EdgeInsets.all(16)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      )),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                // BlocProvider<
                //     CategoriesBloc>(
                //   create: (context) =>
                //       CategoriesBloc(),
                // ),
                // BlocProvider<SearchBloc>(
                //   create: (context) =>
                //       SearchBloc(),
                //),
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    settings: RouteSettings(name: '/primary'),
                    builder: (_) => Container())); //FIXME
              },
              child: Text('Continue as a visitor'),
              style: TextButton.styleFrom(
                splashFactory: NoSplash.splashFactory,
              ),
            ),
            const SizedBox(height: 30),
            Text.rich(
              TextSpan(
                text: 'Don\'t have an account?  ',
                children: [
                  TextSpan(
                    text: 'Sign Up',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (_) => SignupScreen()));
                      },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
