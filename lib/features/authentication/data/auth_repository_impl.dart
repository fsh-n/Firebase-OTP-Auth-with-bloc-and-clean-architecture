import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/Logger/data_logger.dart';
import '../repository/auth_repository.dart';

/// Thrown during the otp verification process if a failure occurs.
class IncorrectOTP implements Exception {}

/// Thrown during the firebase phone verification process if a failure occurs.
class VerificationFailure implements Exception {}

/// Thrown during the logout process
class LogOutFailure implements Exception {}

class Auth implements AuthService {
  String _verificationId = '';
  int? _forceResendingToken;

  Auth({FirebaseAuth? firebaseAuth})
      : _auth = firebaseAuth ?? FirebaseAuth.instance;

  final FirebaseAuth _auth;

  @override
  Future<void> sendOtp(
      String phoneNo, Function() otpSendingFailed, Function() codeSent) async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        verificationCompleted: _onVerificationCompleted,
        verificationFailed: (FirebaseAuthException ex) {
          otpSendingFailed();
          _onVerificationFailed(ex);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
        },
        codeSent: (String verificationId, int? forceResendingToken) {
          _verificationId = verificationId;
          _forceResendingToken = forceResendingToken;
          codeSent(); // Inform Code Sent
        },
      );
    } catch (ex) {
      DefaultDataLogger.logException(ex.toString());
      rethrow;
    }
  }

  @override
  Future<void> resendOTP(
      String phoneNo, Function() otpSendingFailed, Function() codeSent) async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        forceResendingToken: _forceResendingToken,
        phoneNumber: phoneNo,
        verificationCompleted: _onVerificationCompleted,
        verificationFailed: (FirebaseAuthException ex) {
          otpSendingFailed();
          _onVerificationFailed(ex);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
        },
        codeSent: (String verificationId, int? forceResendingToken) {
          _verificationId = verificationId;
          _forceResendingToken = forceResendingToken;
          codeSent();
        },
      );
    } catch (ex) {
      DefaultDataLogger.logException(ex.toString());
      rethrow;
    }
  }

  // Verify OTP
  @override
  Future<void> verifyOTP(String otp) async {
    try {
      await _auth.signInWithCredential(PhoneAuthProvider.credential(
          verificationId: _verificationId, smsCode: otp));
    } on Exception catch (ex) {
      DefaultDataLogger.logException(ex.toString());
      throw IncorrectOTP();
    }
  }

  // Callbacks
  // On Verification Complete
  void _onVerificationCompleted(PhoneAuthCredential credential) async {
    // Auto Verification will work on android only not on ios
    // Sign the user in (or link) with the auto-generated credential
    await _auth.signInWithCredential(credential);
  }

  // On Verification Failed
  void _onVerificationFailed(FirebaseAuthException e) {
    DefaultDataLogger.logException(e.message);
  }

  @override
  Future<void> logOut() async {
    try {
      await Future.wait([
        _auth.signOut(),
      ]);
    } catch (_) {
      throw LogOutFailure();
    }
  }

  // Get Current Status of User
  @override
  bool get currentAuthStatus {
    return _auth.currentUser != null ? true : false;
  }
}
