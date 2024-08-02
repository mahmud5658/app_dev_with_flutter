import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:taskmanager/data/model/network_response.dart';
import 'package:taskmanager/data/network_caller/network_caller.dart';
import 'package:taskmanager/data/utilities/url.dart';
import 'package:taskmanager/ui/screen/auth/signin_screen.dart';
import 'package:taskmanager/ui/utility/color.dart';
import 'package:taskmanager/ui/widgets/background_widgets.dart';
import 'package:taskmanager/ui/widgets/snack_bar_message.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key, required this.email, required this.opt})
      : super(key: key);

  final String email;
  final String opt;

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordControlller =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _showPassword = false;
  bool _resetInProgress = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
          child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 120,
                  ),
                  Text(
                    'Set Password',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    'Minimum length password 8 character with Letter and number combination',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    controller: _passwordController,
                    obscureText: _showPassword == false,
                    decoration: InputDecoration(
                        hintText: "New Password",
                        suffixIcon: IconButton(
                          onPressed: () {
                            if (mounted) {
                              _showPassword = !_showPassword;
                              setState(() {});
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
                    height: 8,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    controller: _confirmPasswordControlller,
                    obscureText: _showPassword == false,
                    decoration: InputDecoration(
                        hintText: "Confirm Password",
                        suffixIcon: IconButton(
                          onPressed: () {
                            if (mounted) {
                              _showPassword = !_showPassword;
                              setState(() {});
                            }
                          },
                          icon: Icon(_showPassword
                              ? Icons.remove_red_eye
                              : Icons.visibility_off),
                        ),
                        hintStyle: TextStyle(color: Colors.grey.shade400)),
                    validator: (String? value) {
                      if (value != _passwordController.text) {
                        return "confrim password not match";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Visibility(
                    visible: _resetInProgress == false,
                    replacement: const Center(
                      child: CircularProgressIndicator(),
                    ),
                    child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {}
                          
                          _resetPassword();
                        },
                        child: const Text('Confirm')),
                  ),
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

  void _onTapSignInButton() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false);
  }

  void _onConfirmButton() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  Future<void> _resetPassword() async {
    if (mounted) {
      setState(() {
        _resetInProgress = true;
      });
    }
    Map<String, dynamic> requestBody = {
      "email": widget.email,
      "OTP": widget.opt,
      "password": _passwordController.text
    };

    NetworkResponse response =
        await NetworkCaller.postRequest(Urls.resetPassword, body: requestBody);

    if (response.isSuccess) {
      _onConfirmButton();
      if (mounted) {
        showSnackBarMessage(context, "Password reset successfull");
      }
    } else {
      if (mounted) {
        showSnackBarMessage(context,
            response.errorMessage ?? 'password reset failed!! try again');
      }
    }
    if (mounted) {
      setState(() {
        _resetInProgress = true;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
  }
}
