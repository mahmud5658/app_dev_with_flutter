import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:taskmanager/data/model/network_response.dart';
import 'package:taskmanager/data/network_caller/network_caller.dart';
import 'package:taskmanager/data/utilities/url.dart';
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
  final TextEditingController _emailController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _verifyInProgress = false;

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
                  Visibility(
                    visible: _verifyInProgress == false,
                    replacement: const Center(
                      child: CircularProgressIndicator(),
                    ),
                    child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _verifyEmail();
                          }
                        },
                        child: const Icon(Icons.arrow_circle_right_outlined)),
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
    Navigator.pop(context);
  }

  void _onConfirmButton() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) =>  PinVerificationScreen(email: email,)));
  }

  Future<void> _verifyEmail() async {
    if (mounted) {
      setState(() {
        _verifyInProgress = true;
      });
    }
    email = _emailController.text.trim();
    NetworkResponse response = await NetworkCaller.getRequest(
        Urls.verifyEmail(_emailController.text.trim()));

    if (response.isSuccess) {
      _onConfirmButton();
      if (mounted) {
        showSnackBarMessage(context, "otp send to your email address");
      }
    } else {
      if (mounted) {
        showSnackBarMessage(
            context, response.errorMessage ?? 'email verify failed! Try again');
      }
    }
    if (mounted) {
      setState(() {
        _verifyInProgress = false;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
  }
}
