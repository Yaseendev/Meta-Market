import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:supermarket/features/User/data/models/name_model.dart';

import '../blocs/bloc/auth_bloc.dart';
import '../screens/login_screen.dart';
import 'account_button.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String email = '';
  String firstName = '';
  String lastName = '';
  String password = '';
  String phone = '';
  bool passwordVisible = true;
  bool _validate = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100)),
                          hintText: 'First Name',
                          prefixIcon: Icon(Icons.person_outline_rounded),
                        ),
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        maxLines: 1,
                        onChanged: (value) => firstName = value,
                        validator: (value) {
                          return value!.trim().isEmpty
                              ? 'Name is required'
                              : null;
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100)),
                          hintText: 'Last Name',
                          prefixIcon: Icon(Icons.person_outline_rounded),
                        ),
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        maxLines: 1,
                        onChanged: (value) => lastName = value,
                        validator: (value) {
                          return value!.trim().isEmpty
                              ? 'Name is required'
                              : null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
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
                    return !EmailValidator.validate(
                            value ?? '') //TODO extract to a sparated file
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
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100)),
                    hintText: 'Confirm Password',
                    labelText: 'Confirm Password',
                    prefixIcon: const Icon(Icons.password),
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
                  obscureText: passwordVisible,
                  validator: (value) {
                    return value!.trim().isNotEmpty
                        ? value == password
                            ? null
                            : 'Passwords must be identical'
                        : 'This field is required';
                  },
                ),
                const SizedBox(height: 20),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: IntlPhoneField(
                    dropdownTextStyle: TextStyle(
                      color: Colors.black,
                    ),
                    invalidNumberMessage: 'Invalid Number',
                    autovalidateMode: AutovalidateMode.disabled,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(100)),
                      ),
                      hintText: 'Phone Number',
                      prefixIcon: const Icon(Icons.phone),
                      errorText: _validate ? null : 'Invalid phone number',
                    ),
                    pickerDialogStyle: PickerDialogStyle(
                      countryCodeStyle: TextStyle(
                        color: Colors.black,
                      ),
                      countryNameStyle: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    showDropdownIcon: true,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.phone,
                    onChanged: (value) => phone = value.completeNumber.trim(),
                    validator: (value) {
                      //TODO extact to separated class
                      print(value);
                      final RegExp phoneValidate = RegExp(
                          r'^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$');
                      return value != null &&
                              value.number.trim().isNotEmpty &&
                              !phoneValidate
                                  .hasMatch(value.completeNumber.trim())
                          ? 'Invalid phone number'
                          : null;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return AccountButton(
                      buttonState: state is AuthLoading
                          ? ButtonState.loading
                          : ButtonState.idle,
                      label: 'Sign Up',
                      onPress: () {
                        FocusScope.of(context).unfocus();
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(SingUpEvent(
                                email: email,
                                name:
                                    NameModel(first: firstName, last: lastName),
                                password: password,
                                phone: phone,
                              ));
                        }
                      },
                    );
                  },
                ),
              ],
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
                child: ElevatedButton.icon(
                  onPressed: () async {
                    // context.read<AccountBloc>().add(LoginWithGoogleEvent());
                  },
                  icon:
                      //     CircularProgressIndicator.adaptive(
                      //   backgroundColor: Colors.white,
                      // ),
                      Icon(
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
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(16)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    )),
                  ),
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
              // Navigator.of(context)
              //     .pushReplacement(MaterialPageRoute(
              //        settings: RouteSettings(name: '/primary'),
              //         builder: (_) =>
              //                 BlocProvider<SearchBloc>(
              //                   create: (context) =>
              //                       SearchBloc(),
              //               child: PrimaryScreen(),
              //             )));
            },
            child: Text('Continue as a visitor'),
            style: TextButton.styleFrom(
              splashFactory: NoSplash.splashFactory,
            ),
          ),
          SizedBox(height: 20),
          Text.rich(
            TextSpan(
              text: 'Already have an account?  ',
              children: [
                TextSpan(
                  text: 'Sign In',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (_) => LoginScreen()));
                    },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
