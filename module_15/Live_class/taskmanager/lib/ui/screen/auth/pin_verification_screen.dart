import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:taskmanager/ui/controller/pin_verification_controller.dart';
import 'package:taskmanager/ui/screen/auth/signin_screen.dart';
import 'package:taskmanager/ui/screen/auth/reset_password_screen.dart';
import 'package:taskmanager/ui/utility/color.dart';
import 'package:taskmanager/ui/widgets/background_widgets.dart';
import 'package:taskmanager/ui/widgets/snack_bar_message.dart';

class PinVerificationScreen extends StatefulWidget {
  const PinVerificationScreen({
    Key? key,
    required this.email,
  }) : super(key: key);

  final String email;

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
  final PinVerificationController pinVerificationController =
      Get.find<PinVerificationController>();
  String _pinCode = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
          child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 120,
                ),
                Text(
                  'Pin Verification',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  'A 6 digits pin verification pin has been send to your email address',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(
                  height: 24,
                ),
                _buildPinCodeTextField(context),
                const SizedBox(
                  height: 16,
                ),
                GetBuilder<PinVerificationController>(
                    builder: (pinVerificationController) {
                  return Visibility(
                    visible: pinVerificationController.pinInProgress == false,
                    replacement: const Center(
                      child: CircularProgressIndicator(),
                    ),
                    child: ElevatedButton(
                        onPressed: () {
                          _onTapNextButton();
                        },
                        child: const Text('Verify')),
                  );
                }),
                const SizedBox(
                  height: 36,
                ),
                Center(
                  child: RichText(
                    text: TextSpan(
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.8),
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.4),
                        text: "Have an account?",
                        children: [
                          TextSpan(
                              style:
                                  const TextStyle(color: AppColor.themeColor),
                              text: "Sign In",
                              recognizer: TapGestureRecognizer()
                                ..onTap = _onTapSignInButton)
                        ]),
                  ),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }

  PinCodeTextField _buildPinCodeTextField(BuildContext context) {
    return PinCodeTextField(
      length: 6,
      obscureText: false,
      animationType: AnimationType.fade,
      keyboardType: TextInputType.number,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5),
        fieldHeight: 50,
        fieldWidth: 40,
        activeFillColor: Colors.white,
        selectedFillColor: Colors.white,
        inactiveFillColor: Colors.white,
        selectedColor: AppColor.themeColor,
      ),
      animationDuration: const Duration(milliseconds: 300),
      backgroundColor: Colors.transparent,
      enableActiveFill: true,
      appContext: context,
      onCompleted: (value) {},
      onChanged: (value) {
        if (mounted) {
          setState(() {
            _pinCode = value;
          });
        }
      },
    );
  }
  void _onTapNextButton() async {
    final result =
        await pinVerificationController.pinVerify(widget.email, _pinCode);
    if (result) {
      Get.to(() => ResetPasswordScreen(email: widget.email, otp: _pinCode));
    } else {
      if (mounted) {
        showSnackBarMessage(context, pinVerificationController.errorMessage);
      }
    }
  }
  void _onTapSignInButton() {
    Get.offAll(() => const LoginScreen());
  }
}
