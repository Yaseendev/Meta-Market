import 'package:easy_localization/easy_localization.dart';
import 'package:email_validator/email_validator.dart';
import 'package:intl_phone_field/phone_number.dart' show PhoneNumber;
import 'package:supermarket/core/presentation/translations/locale_keys.g.dart';

final class Validators {
  static String? emailValidator(String? value) {
    return !EmailValidator.validate(value ?? '')
        ? LocaleKeys.emailInvalid.tr()
        : null;
  }

  static String? passwordValidator(String? value) {
    return (value?.trim().isNotEmpty ?? false)
        ? (value?.trim().length ?? 0) > 6
              ? null
              : LocaleKeys.passwordInvalid.tr()
        : LocaleKeys.fieldRequired.tr();
  }

  static String? confirmPasswordValidator(String? value, String? password) {
    return (value?.trim().isNotEmpty ?? false)
        ? value == password
              ? null
              : LocaleKeys.confirmPasswordInvalid.tr()
        : LocaleKeys.fieldRequired.tr();
  }

  static String? phoneNumberValidator(PhoneNumber? value) {
    final RegExp phoneValidate = RegExp(
      r'^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$',
    );
    return value != null &&
            value.number.trim().isNotEmpty &&
            !phoneValidate.hasMatch(value.completeNumber.trim())
        ? LocaleKeys.invalidPhoneNumber.tr()
        : null;
  }

  static String? requiredValidator(String? value) {
    return (value?.trim().isEmpty ?? true)
        ? LocaleKeys.fieldRequired.tr()
        : null;
  }
}
