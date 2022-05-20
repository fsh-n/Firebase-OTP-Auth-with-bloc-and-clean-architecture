part of 'login_bloc.dart';

enum OTPStatus { initial, sent, resent, wrong, success }

class LoginState extends Equatable {
  final PhoneNoValidator phoneNo;
  final FormzStatus status;
  final String otp;
  final OTPStatus otpStatus;

  const LoginState(
      {this.phoneNo = const PhoneNoValidator.pure(),
      this.status = FormzStatus.pure,
      this.otpStatus = OTPStatus.initial,
      this.otp = ''});

  LoginState copyWith(
      {FormzStatus? status,
      PhoneNoValidator? phoneNo,
      OTPStatus? otpStatus,
      String? otp}) {
    return LoginState(
        status: status ?? this.status,
        phoneNo: phoneNo ?? this.phoneNo,
        otpStatus: otpStatus ?? this.otpStatus,
        otp: otp ?? this.otp);
  }

  @override
  List<Object> get props => [phoneNo, status, otp, otpStatus];
}
