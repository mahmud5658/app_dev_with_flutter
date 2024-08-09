import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmanager/ui/controller/sign_in_controller.dart';
import 'package:taskmanager/ui/screen/auth/email_verification_screen.dart';
import 'package:taskmanager/ui/screen/auth/signup_screen.dart';
import 'package:taskmanager/ui/screen/task/main_bottom_screen.dart';
import 'package:taskmanager/ui/utility/app_constant.dart';
import 'package:taskmanager/ui/utility/color.dart';
import 'package:taskmanager/ui/widgets/background_widgets.dart';
import 'package:taskmanager/ui/widgets/snack_bar_message.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final SignInController signInController = Get.find<SignInController>();

  bool _showPassword = false;

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
                    'Get started with',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    decoration: InputDecoration(
                        hintText: "Email",
                        hintStyle: TextStyle(color: Colors.grey.shade400)),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return "Enter your email";
                      } else {
                        if (AppConstant.emailRegExp.hasMatch(value!.trim()) ==
                            false) {
                          return 'Enter your valid email address';
                        }
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    controller: _passwordController,
                    obscureText: _showPassword == false,
                    decoration: InputDecoration(
                        hintText: "Password",
                        suffixIcon: IconButton(
                          onPressed: () {
                            _showPassword = !_showPassword;
                            if(mounted){
                              setState(() {
                                
                              });
                            }
                          },
                          icon: Icon(_showPassword
                              ? Icons.remove_red_eye
                              : Icons.visibility_off),
                        ),
                        hintStyle: TextStyle(color: Colors.grey.shade400)),
                    validator: (String? value) {
                      if (value?.isEmpty ?? true) {
                        return "Enter your password";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  GetBuilder<SignInController>(builder: (signController) {
                    return Visibility(
                      visible: signController.logInProgress == false,
                      replacement: const Center(
                        child: CircularProgressIndicator(),
                      ),
                      child: ElevatedButton(
                          onPressed: () {
                            _onTapNextButton();
                          },
                          child: const Icon(Icons.arrow_circle_right_outlined)),
                    );
                  }),
                  const SizedBox(
                    height: 36,
                  ),
                  Center(
                    child: Column(
                      children: [
                        TextButton(
                            onPressed: () {
                              _onTapForgotPassword();
                            },
                            child: const Text(
                              'Forgot Password?',
                            )),
                        RichText(
                          text: TextSpan(
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.8),
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.4),
                              text: "Don't have an account?",
                              children: [
                                TextSpan(
                                    style: const TextStyle(
                                        color: AppColor.themeColor),
                                    text: "Sign Up",
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = _onTapSignUpButton)
                              ]),
                        )
                      ],
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
    if (_formKey.currentState!.validate()) {
      final bool result = await signInController.logIn(
          _emailController.text.trim(), _passwordController.text);

      if (result) {
        Get.offAll(() => const BottomNavScreen());
      } else {
        if (mounted) {
          showSnackBarMessage(context, signInController.errorMessage);
        }
      }
    }
  }

  void _onTapSignUpButton() {
    Get.to(() => const SignUpScreen());
  }

  void _onTapForgotPassword() {
    Get.to(() => const EmailVerificationScreen());
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }
}
