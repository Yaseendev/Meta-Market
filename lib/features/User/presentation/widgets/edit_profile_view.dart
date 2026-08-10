import 'package:easy_localization/easy_localization.dart'as ea;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:supermarket/core/config/di/injection.dart';
import 'package:supermarket/core/presentation/blocs/base_states/base_state.dart';
import 'package:supermarket/core/presentation/constants/ui_spaces.dart';
import 'package:supermarket/core/presentation/dialogs/dialogs.dart';
import 'package:supermarket/core/presentation/translations/locale_keys.g.dart';
import 'package:supermarket/core/presentation/widgets/app_button.dart';
import 'package:supermarket/core/services/validators.dart';
import 'package:supermarket/features/User/domain/entities/app_user.dart';
import 'package:supermarket/features/User/presentation/blocs/edit_profile/edit_profile_cubit.dart';

class EditProfileView extends StatefulWidget {
  final AppUser user;
  final ValueChanged<AppUser> onEdited;
  const EditProfileView(this.user, {super.key, required this.onEdited});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  late final GlobalKey<FormState> _formKey;
  late final EditProfileCubit _editProfileCubit;
  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _editProfileCubit = getIt<EditProfileCubit>(param1: widget.user);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditProfileCubit, BaseState<AppUser>>(
      bloc: _editProfileCubit,
      listener: (context, state) {
        if (state.isFailure) {
          showErrorSnackBar(context, state.failure?.message);
        } else if (state.isSuccess) {
          if (state.item != null) {
            widget.onEdited(state.item!);
          }
        }
      },
      child: ListView(
        children: [
          const SizedBox(height: UIMetrics.lg),
          const CircleAvatar(child: Icon(Icons.person_outline_rounded)),
          const SizedBox(height: UIMetrics.lg),
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
                        initialValue: widget.user.name.first,
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
                        onChanged: _editProfileCubit.setFirstName,
                        validator: (value) {
                          return (value?.trim().isEmpty ?? true)
                              ? LocaleKeys.nameRequired.tr(context: context)
                              : null;
                        },
                      ),
                    ),
                    const SizedBox(width: UIMetrics.sm),
                    Expanded(
                      child: TextFormField(
                        initialValue: widget.user.name.last,
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
                        onChanged: _editProfileCubit.setLastName,
                        validator: (value) {
                          return (value?.trim().isEmpty ?? true)
                              ? LocaleKeys.nameRequired.tr(context: context)
                              : null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: UIMetrics.md),
                TextFormField(
                  initialValue: widget.user.email,
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
                  onChanged: _editProfileCubit.setEmail,
                  validator: Validators.emailValidator,
                ),
                const SizedBox(height: UIMetrics.md),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: IntlPhoneField(
                    initialValue: widget.user.phoneNumber,
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
                      errorText: LocaleKeys.invalidPhoneNumber.tr(
                        context: context,
                      ),
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
                    onChanged: (value) =>
                        _editProfileCubit.setPhone(value.completeNumber.trim()),
                    validator: (value) {
                      return Validators.phoneNumberValidator(value);
                    },
                  ),
                ),
                const SizedBox(height: 20),
                BlocBuilder<EditProfileCubit, BaseState<AppUser>>(
                  bloc: _editProfileCubit,
                  builder: (context, state) {
                    return AppButton(
                      title: LocaleKeys.saveChanges.tr(context: context),
                      onPress: _editProfileCubit.editProfile,
                      isLoading: state.isLoading,
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
