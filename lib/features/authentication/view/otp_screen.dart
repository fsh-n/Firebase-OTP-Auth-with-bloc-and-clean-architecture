import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';

import '../../../utils/textstyles.dart';
import '../bloc/login_bloc.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.otpStatus == OTPStatus.success) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(const SnackBar(
                content: Text('Login Successfull!'),
                backgroundColor: Colors.green,
              ));
          }
          if (state.otpStatus == OTPStatus.sent) {
            // Show Snackbar
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(const SnackBar(
                content: Text('OTP resend successfull!'),
                backgroundColor: Colors.green,
              ));
          }

          if (state.otpStatus == OTPStatus.wrong) {
            // Show Snackbar
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(const SnackBar(
                content: Text('Incorrect OTP!'),
                backgroundColor: Colors.red,
              ));
          }
        },
        child: SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(8.0),
              child: BlocBuilder<LoginBloc, LoginState>(
                  buildWhen: (previous, current) => previous.otp != current.otp,
                  builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 80,
                        ),
                        _OtpHeader(state),
                        _OtpInput(
                          state: state,
                        ),
                        const SizedBox(height: 44),
                        const Text(
                          'Didn’t receive code?',
                          style: TextStyles.actionTitle,
                        ),
                        TextButton(
                            onPressed: () =>
                                context.read<LoginBloc>().add(ResendOTP()),
                            child: const Text('Resend',
                                style: TextStyles.actionTitle)),
                      ],
                    );
                  }),
            ),
          ),
        ));
  }
}

class _OtpHeader extends StatelessWidget {
  final LoginState state;
  const _OtpHeader(this.state);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Verification',
            style: TextStyles.headingBlack,
          ),
          const SizedBox(height: 24),
          const Text(
            'Enter the code sent to the number',
            style: TextStyles.actionTitle,
          ),
          const SizedBox(height: 16),
          Text(
            "+91" + state.phoneNo.value,
            style: TextStyles.actionTitle,
          ),
          const SizedBox(height: 64)
        ],
      ),
    );
  }
}

// OTP Verification
class _OtpInput extends StatelessWidget {
  const _OtpInput({Key? key, required this.state}) : super(key: key);

  final LoginState state;

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    return Pinput(
      defaultPinTheme: defaultPinTheme,
      length: 6,
      focusedPinTheme: focusedPinTheme,
      submittedPinTheme: submittedPinTheme,
      onCompleted: (otp) => context.read<LoginBloc>().add(VerifyOTP(otp: otp)),
      errorText: state.otpStatus == OTPStatus.wrong ? 'Incorrect OTP!' : null,
    );
  }
}
