import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:taskmanager/ui/screen/auth/login_screen.dart';
import 'package:taskmanager/ui/utility/color.dart';
import 'package:taskmanager/ui/widgets/background_widgets.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordControlller = TextEditingController();

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
                  decoration: InputDecoration(
                      hintText: "New Password",
                      hintStyle: TextStyle(color: Colors.grey.shade400)),
                ),
                const SizedBox(height: 8,),
                TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  controller: _confirmPasswordControlller,
                  decoration: InputDecoration(
                      hintText: "Confirm Password",
                      hintStyle: TextStyle(color: Colors.grey.shade400)),
                ),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                    onPressed: () {
                      _onConfirmButton();
                    },
                    child: const Text('Confirm')),
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

  void _onTapSignInButton() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false);
  }

  void _onConfirmButton() {
    // Navigator.push(context,
    //     MaterialPageRoute(builder: (context) => const PinVerificationScreen()));
  }

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
  }
}
