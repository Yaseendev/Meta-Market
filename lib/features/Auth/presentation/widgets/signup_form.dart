import 'package:easy_localization/easy_localization.dart' as e;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:supermarket/core/presentation/constants/ui_spaces.dart';
import 'package:supermarket/core/presentation/translations/locale_keys.g.dart';
import 'package:supermarket/core/services/validators.dart';
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
                            borderRadius: BorderRadius.circular(100),
                          ),
                          hintText: LocaleKeys.firstName.tr(context: context),
                          prefixIcon: Icon(Icons.person_outline_rounded),
                        ),
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        maxLines: 1,
                        onChanged: (value) => firstName = value,
                        validator: (value) {
                          return (value?.trim().isEmpty ?? true)
                              ? LocaleKeys.nameRequired.tr(context: context)
                              : null;
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          hintText: LocaleKeys.lastName.tr(context: context),
                          prefixIcon: Icon(Icons.person_outline_rounded),
                        ),
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        maxLines: 1,
                        onChanged: (value) => lastName = value,
                        validator: (value) {
                          return (value?.trim().isEmpty ?? true)
                              ? LocaleKeys.nameRequired.tr(context: context)
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
                      borderRadius: BorderRadius.circular(100),
                    ),
                    hintText: LocaleKeys.email.tr(context: context),
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  maxLines: 1,
                  initialValue: email,
                  onChanged: (value) => email = value,
                  validator: Validators.emailValidator,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    hintText: LocaleKeys.password.tr(context: context),
                    labelText: LocaleKeys.password.tr(context: context),
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
                  validator: Validators.passwordValidator,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    hintText: LocaleKeys.confirmPassword.tr(context: context),
                    labelText: LocaleKeys.confirmPassword.tr(context: context),
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
                  validator: (value) =>
                      Validators.confirmPasswordValidator(value, password),
                ),
                const SizedBox(height: 20),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: IntlPhoneField(
                    dropdownTextStyle: TextStyle(color: Colors.black),
                    invalidNumberMessage: LocaleKeys.invalidNumber.tr(
                      context: context,
                    ),
                    autovalidateMode: AutovalidateMode.disabled,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(100),
                        ),
                      ),
                      hintText: LocaleKeys.phoneNumber.tr(context: context),
                      prefixIcon: const Icon(Icons.phone),
                      errorText: _validate
                          ? null
                          : LocaleKeys.invalidPhoneNumber.tr(context: context),
                    ),
                    pickerDialogStyle: PickerDialogStyle(
                      countryCodeStyle: TextStyle(color: Colors.black),
                      countryNameStyle: TextStyle(color: Colors.black),
                    ),
                    style: TextStyle(color: Colors.black),
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    showDropdownIcon: true,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.phone,
                    onChanged: (value) => phone = value.completeNumber.trim(),
                    validator: (value) {
                      return Validators.phoneNumberValidator(value);
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
                      label: LocaleKeys.signUp.tr(context: context),
                      onPress: () {
                        FocusScope.of(context).unfocus();
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(
                            SingUpEvent(
                              email: email,
                              name: NameModel(first: firstName, last: lastName),
                              password: password,
                              phone: phone,
                            ),
                          );
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
              Text('  ${LocaleKeys.orContinueWith.tr(context: context)}  '),
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
                      Icon(FontAwesomeIcons.google, color: Colors.white),
                  label: Text(
                    'Google',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Color(0xFFE6242E),
                    ),
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.all(16),
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    //context.read<AccountBloc>().add(LoginWithFacebookEvent());
                  },
                  icon: Icon(FontAwesomeIcons.facebookF, color: Colors.white),
                  label: Text(
                    'Facebook',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Color(0xFF4267B2),
                    ),
                    padding: MaterialStateProperty.all(EdgeInsets.all(16)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: UIMetrics.lg),
          Text.rich(
            TextSpan(
              text: '${LocaleKeys.haveAccount.tr(context: context)}  ',
              children: [
                TextSpan(
                  text: LocaleKeys.signIn.tr(context: context),
                  style: TextStyle(color: Theme.of(context).primaryColor),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => LoginScreen()),
                      );
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
