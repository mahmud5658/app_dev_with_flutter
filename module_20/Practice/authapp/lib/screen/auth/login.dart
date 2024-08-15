import 'package:authapp/screen/auth/login_with_phone.dart';
import 'package:authapp/screen/auth/sign_up.dart';
import 'package:authapp/screen/posts/post_scree.dart';
import 'package:authapp/utils/utils.dart';
import 'package:authapp/widgets/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _loginInProgress = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (_) {
        SystemNavigator.pop();
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Login'),
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email_outlined)),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock_outline)),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter password';
                          }
                          return null;
                        },
                      ),
                    ],
                  )),
              const SizedBox(
                height: 50,
              ),
              Visibility(
                visible: _loginInProgress == false,
                replacement: const Center(
                  child: CircularProgressIndicator(),
                ),
                child: RoundButton(
                  title: 'Login',
                  onTap: () async {
                    await _login();
                  },
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              RichText(
                text: TextSpan(
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.4),
                    text: "Don't have an account?",
                    children: [
                      TextSpan(
                          style: const TextStyle(
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.4),
                          text: 'Sign Up',
                          recognizer: TapGestureRecognizer()
                            ..onTap = _onTapSignUpButton)
                    ]),
              ),
              const SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginWithPhoneScreen()));
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black),
                  ),
                  child: const Center(
                    child: Text(
                      'Login with phone',
                      style: TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _loginInProgress = true;
      });
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _emailController.text.toString(),
            password: _passwordController.text.toString());
        Utils.toastMessage('Successfully loged in');
        if (mounted) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const PostScreen()),
              (route) => false);
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Utils.toastMessage('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          Utils.toastMessage('Wrong password provided for that user.');
        } else {
          Utils.toastMessage(e.code);
        }
      }
      setState(() {
        _loginInProgress = false;
      });
    }
  }

  void _onTapSignUpButton() {
    if (mounted) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const SignUpScreen()));
    }
  }
}
