part of 'login_page_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    this.phoneNumber = const PhoneNumberValidation.pure(),
    this.otp = const OtpValidation.pure(),
    this.status = FormzStatus.pure,
  });

  final PhoneNumberValidation phoneNumber;
  final OtpValidation otp;
  final FormzStatus status;

  LoginState copyWith({
    PhoneNumberValidation phoneValid,
    OtpValidation otpValid,
    FormzStatus status,
  }) {
    return LoginState(
      phoneNumber: phoneValid ?? phoneNumber,
      otp: otpValid ?? otp,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [phoneNumber, otp, status];
}