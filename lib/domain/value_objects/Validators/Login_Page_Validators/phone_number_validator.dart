import 'package:formz/formz.dart';

enum PhoneNumberValidationError { invalid }

class PhoneNumberValidation extends FormzInput<String, PhoneNumberValidationError> {
  const PhoneNumberValidation.pure([String value = '']) : super.pure(value);
  const PhoneNumberValidation.dirty([String value = '']) : super.dirty(value);

  static final _phoneNumberRegex = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)',);

  @override
  PhoneNumberValidationError validator(String value) {
    return _phoneNumberRegex.hasMatch(value ?? '')
        ? null
        : PhoneNumberValidationError.invalid;
  }
}