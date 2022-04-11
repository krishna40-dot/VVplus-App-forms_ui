// ignore_for_file: avoid_print

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:vvplus_app/domain/value_objects/Validators/Login_Page_Validators/phone_number_validator.dart';
import 'package:vvplus_app/domain/value_objects/Validators/Login_Page_Validators/otp_validator.dart';
part 'login_bloc_event.dart';
part 'login_bloc_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<PhoneNumberChanged>(_onPhoneNumberChanged);
    on<OtpChanged>(_onOtpChanged);
    on<PhoneNumberUnfocused>(_onPhoneNumberUnfocused);
    on<OtpUnfocused>(_onOtpUnfocused);
    on<FormSubmitted>(_onFormSubmitted);
  }

  @override
  void onTransition(Transition<LoginEvent, LoginState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  void _onPhoneNumberChanged(PhoneNumberChanged event, Emitter<LoginState> emit) {
    final email = PhoneNumberValidation.dirty(event.phone);
    emit(state.copyWith(
      phoneValid: email.valid ? email : PhoneNumberValidation.pure(event.phone),
      status: Formz.validate([email, state.otp]),
    ));
  }

  void _onOtpChanged(OtpChanged event, Emitter<LoginState> emit) {
    final password = OtpValidation.dirty(event.otp);
    emit(state.copyWith(
      otpValid: password.valid ? password : OtpValidation.pure(event.otp),
      status: Formz.validate([state.phoneNumber, password]),
    ));
  }

  void _onPhoneNumberUnfocused(PhoneNumberUnfocused event, Emitter<LoginState> emit) {
    final email = PhoneNumberValidation.dirty(state.phoneNumber.value);
    emit(state.copyWith(
      phoneValid: email,
      status: Formz.validate([email, state.otp]),
    ));
  }

  void _onOtpUnfocused(
      OtpUnfocused event,
      Emitter<LoginState> emit,
      ) {
    final password = OtpValidation.dirty(state.otp.value);
    emit(state.copyWith(
      otpValid: password,
      status: Formz.validate([state.phoneNumber, password]),
    ));
  }

  void _onFormSubmitted(FormSubmitted event, Emitter<LoginState> emit) async {
    final email = PhoneNumberValidation.dirty(state.phoneNumber.value);
    final password = OtpValidation.dirty(state.otp.value);
    emit(state.copyWith(
      phoneValid: email,
      otpValid: password,
      status: Formz.validate([email, password]),
    ));
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    }
  }
}