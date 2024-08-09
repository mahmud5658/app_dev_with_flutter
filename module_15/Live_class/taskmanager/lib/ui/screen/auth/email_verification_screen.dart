import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmanager/ui/controller/email_verification_controller.dart';
import 'package:taskmanager/ui/screen/auth/pin_verification_screen.dart';
import 'package:taskmanager/ui/utility/app_constant.dart';
import 'package:taskmanager/ui/utility/color.dart';
import 'package:taskmanager/ui/widgets/background_widgets.dart';
import 'package:taskmanager/ui/widgets/snack_bar_message.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({Key? key}) : super(key: key);

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  final EmailVerificationController emailVerificationController =
      Get.find<EmailVerificationController>();

  late final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
          child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 120,
                  ),
                  Text(
                    'Your Email Address',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    'A 6 digits pin verification pin send to your email address',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    validator: (value) {
                      if (value?.trim().isEmpty ?? true) {
                        return "Enter your email address";
                      } else {
                        if (AppConstant.emailRegExp.hasMatch(value!.trim()) ==
                            false) {
                          return "Enter your valid email address";
                        }
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                        hintText: "Email",
                        hintStyle: TextStyle(color: Colors.grey.shade400)),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  GetBuilder<EmailVerificationController>(
                      builder: (emailVerificationController) {
                    return Visibility(
                      visible:
                          emailVerificationController.verificationInProgress ==
                              false,
                      replacement: const Center(
                        child: CircularProgressIndicator(),
                      ),
                      child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _onTapNextButton();
                            }
                          },
                          child: const Icon(Icons.arrow_circle_right_outlined)),
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
        ),
      )),
    );
  }

  void _onTapNextButton() async {
    email = _emailController.text.trim();
    bool result = await emailVerificationController.verifyEmail(email);
    if (result) {
      Get.to(() => PinVerificationScreen(email: email));
    } else {
      if (mounted) {
        showSnackBarMessage(context, emailVerificationController.errorMessage);
      }
    }
  }

  void _onTapSignInButton() {
    Get.back();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
  }
}
