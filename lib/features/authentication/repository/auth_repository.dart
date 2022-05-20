abstract class AuthService {
  bool get currentAuthStatus;

  Future<void> sendOtp(
      String phoneNo, Function() otpSendingFailed, Function() codeSent);

  Future<void> resendOTP(
      String phoneNo, Function() otpSendingFailed, Function() codeSent);

  Future<void> verifyOTP(String otp);

  Future<void> logOut();
}
