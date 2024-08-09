import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmanager/ui/controller/sign_up_controller.dart';
import 'package:taskmanager/ui/screen/auth/signin_screen.dart';
import 'package:taskmanager/ui/utility/app_constant.dart';
import 'package:taskmanager/ui/utility/color.dart';
import 'package:taskmanager/ui/widgets/background_widgets.dart';
import 'package:taskmanager/ui/widgets/snack_bar_message.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final SignUpController signUpController = Get.find<SignUpController>();

  bool _showPassword = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                    'Join With Us',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
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
                    keyboardType: TextInputType.name,
                    controller: _firstNameController,
                    decoration: InputDecoration(
                        hintText: "First Name",
                        hintStyle: TextStyle(color: Colors.grey.shade400)),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return "Enter your First Name";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    controller: _lastNameController,
                    decoration: InputDecoration(
                        hintText: "Last Name",
                        hintStyle: TextStyle(color: Colors.grey.shade400)),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return "Enter your Last Name";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _mobileController,
                    decoration: InputDecoration(
                        hintText: "Mobile",
                        hintStyle: TextStyle(color: Colors.grey.shade400)),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return "Enter your mobile";
                      } else {
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
                            if (mounted) {
                              setState(() {
                                _showPassword = !_showPassword;
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
                  GetBuilder<SignUpController>(builder: (signUpController) {
                    return Visibility(
                      visible: signUpController.signUpInProgress == false,
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
                        RichText(
                          text: TextSpan(
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.8),
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.4),
                              text: "Have an account?",
                              children: [
                                TextSpan(
                                    style: const TextStyle(
                                        color: AppColor.themeColor),
                                    text: "Sign In",
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = _onTapSignInButton)
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
      final result = await signUpController.signUp(
        _emailController.text.trim(),
        _firstNameController.text.trim(),
        _lastNameController.text.trim(),
        _mobileController.text.trim(),
        _passwordController.text,
      );
      if (result) {
        if (mounted) {
          showSnackBarMessage(context, "Sign up successful");
          _clearTextField();
        } else {
          if (mounted) {
            showSnackBarMessage(context, signUpController.errorMessage);
          }
        }
      }
    }
  }

  void _clearTextField() {
    _emailController.clear();
    _firstNameController.clear();
    _lastNameController.clear();
    _mobileController.clear();
    _passwordController.clear();
  }

  void _onTapSignInButton() {
    Get.offAll(() => const LoginScreen());
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _mobileController.dispose();
    _passwordController.dispose();
  }
}
