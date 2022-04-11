import 'package:formz/formz.dart';

enum OtpValidationError { invalid }

class OtpValidation extends FormzInput<String, OtpValidationError> {
  const OtpValidation.pure([String value = '']) : super.pure(value);
  const OtpValidation.dirty([String value = '']) : super.dirty(value);

  static final _otpRegex =
  RegExp(r'(^(?:[+0]9)?[0-9]{5,10}$)');

  @override
  OtpValidationError validator(String value) {
    return _otpRegex.hasMatch(value ?? '')
        ? null
        : OtpValidationError.invalid;
  }
}