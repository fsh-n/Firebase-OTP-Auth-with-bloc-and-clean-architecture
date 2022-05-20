import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../core/global_widgets.dart/buttons.dart';
import '../../../utils/colors.dart';
import '../../../utils/textstyles.dart';
import '../../../utils/widget_functions.dart';
import '../bloc/login_bloc.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.status.isSubmissionFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(const SnackBar(
                content: Text(
                    'Failed to send otp, please check your details again or contact support'),
                backgroundColor: Colors.redAccent,
              ));
          }
          if (state.otpStatus == OTPStatus.sent) {
            // Send to OTP verification
            Navigator.pushNamed(context, '/otp_screen');
          }
        },
        child: SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset("assets/images/login.png"),
                    Row(mainAxisAlignment: MainAxisAlignment.start,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const Text(
                            'OTP Verification',
                            style: BlackTextStyles.h1Heading,
                          ),
                        ]),
                    addVerticalSpace(16),
                    const Text(
                      'We will send you one time password on this mobile number',
                      style: GreyTextStyles.subTitleBold,
                    ),
                    addVerticalSpace(20),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            child: const Center(
                                child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text(
                                '+91',
                                style: BlackTextStyles.bodyTextNormal,
                              ),
                            )),
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppColors.boldGrey),
                            ),
                          ),
                          addHorizontalSpace(10),
                          const Expanded(child: _PhoneNoInput()),
                        ]),
                    addVerticalSpace(25),
                    const _SendOTPButton(),
                    addVerticalSpace(25),
                    RichText(
                        text: TextSpan(
                            text: 'By continuing you agree with our ',
                            style: GreyTextStyles.smallBodyTextBold,
                            children: <TextSpan>[
                          TextSpan(
                            text: 'terms and conditions',
                            style: BlackTextStyles.textButtonLink,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Open terms and condition page
                              },
                          ),
                        ]))
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

// Phone No
class _PhoneNoInput extends StatelessWidget {
  const _PhoneNoInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.phoneNo != current.phoneNo,
      builder: (context, state) {
        return TextField(
            keyboardType: TextInputType.phone,
            maxLength: 10,
            onChanged: (phoneNo) =>
                context.read<LoginBloc>().add(PhoneNoChanged(phoneNo)),
            decoration: InputDecoration(
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 1.0, color: Color.fromARGB(255, 69, 74, 78))),
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide:
                      BorderSide(width: 2.0, color: AppColors.lightGrey)),
              labelText: 'Mobile number',
              errorText: state.phoneNo.invalid ? 'invalid phone no' : null,
              labelStyle: BlackTextStyles.bodyTextNormal,

              // floatingLabelStyle: const TextStyle(
              //     color: AppColors.greenColor, fontWeight: FontWeight.w500)
            ));
      },
    );
  }
}

// Send OTP
class _SendOTPButton extends StatelessWidget {
  const _SendOTPButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : DarkGreenButton(
                onPress: state.status.isValidated
                    ? () {
                        context.read<LoginBloc>().add(SendOTP());
                      }
                    : null,
                width: size.width,
                height: 60,
                text: 'Get Started',
                textStyle: WhiteTextStyles.h1SubHeading);
      },
    );
  }
}
