part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

// Phone No Changed
class PhoneNoChanged extends LoginEvent {
  final String phoneNo;
  const PhoneNoChanged(this.phoneNo);

  @override
  List<Object> get props => [phoneNo];
}

// Send OTP
class SendOTP extends LoginEvent {}

// Resend OTP
class ResendOTP extends LoginEvent {}

// OTP Sent
class OTPSent extends LoginEvent {}

// Mobile No Verification Failure
class VerificationFailure extends LoginEvent {}

// Verify OTP
class VerifyOTP extends LoginEvent {
  final String otp;

  const VerifyOTP({required this.otp});

  @override
  List<Object> get props => [otp];
}
