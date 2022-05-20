import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../repository/auth_repository.dart';
import '../validation/phone_number.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required AuthService authService})
      : _authService = authService,
        super((const LoginState())) {
    on<PhoneNoChanged>(_onPhoneNoChanged);
    on<SendOTP>(_sendOTP);
    on<ResendOTP>(_resendOTP);
    on<VerifyOTP>(_verifyOTP);
    on<OTPSent>(_otpSent);
    on<VerificationFailure>(_verificationFailure);
  }

  final AuthService _authService;

  // Mobile verification failed
  void mobileVerificationFailed() {
    add(VerificationFailure());
  }

  // Mobile Code sent
  void mobileCodeSent() {
    add(OTPSent());
  }

  // Emit Verification Failure
  FutureOr<void> _verificationFailure(
      VerificationFailure event, Emitter<LoginState> emit) {
    emit(state.copyWith(status: FormzStatus.submissionFailure));
  }

  //Emit OTP Sent
  FutureOr<void> _otpSent(OTPSent event, Emitter<LoginState> emit) {
    emit(state.copyWith(otpStatus: OTPStatus.sent));
  }

  FutureOr<void> _sendOTP(SendOTP event, Emitter<LoginState> emit) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        final mobileNo = '+91' + state.phoneNo.value;
        await _authService.sendOtp(
            mobileNo, mobileVerificationFailed, mobileCodeSent);
      } catch (_) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }

  FutureOr<void> _resendOTP(ResendOTP event, Emitter<LoginState> emit) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      final mobileNo = '+91' + state.phoneNo.value;
      await _authService.resendOTP(
          mobileNo, mobileVerificationFailed, mobileCodeSent);
    } catch (_) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

  FutureOr<void> _verifyOTP(VerifyOTP event, Emitter<LoginState> emit) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _authService.verifyOTP(event.otp);
      emit(state.copyWith(otpStatus: OTPStatus.success));
    } catch (_) {
      emit(state.copyWith(otpStatus: OTPStatus.wrong));
    }
  }

  FutureOr<void> _onPhoneNoChanged(
      PhoneNoChanged event, Emitter<LoginState> emit) {
    final _phoneNo = PhoneNoValidator.dirty(event.phoneNo);

    emit(state.copyWith(
      phoneNo: _phoneNo,
      status: Formz.validate([state.phoneNo, _phoneNo]),
    ));
  }
}
