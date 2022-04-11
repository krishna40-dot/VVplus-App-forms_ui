part of 'login_page_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class PhoneNumberChanged extends LoginEvent {
  const PhoneNumberChanged({this.phone});

  final String phone;

  @override
  List<Object> get props => [phone];
}

class PhoneNumberUnfocused extends LoginEvent {}

class OtpChanged extends LoginEvent {
  const OtpChanged({this.otp});

  final String otp;

  @override
  List<Object> get props => [otp];
}

class OtpUnfocused extends LoginEvent {}

class FormSubmitted extends LoginEvent {}