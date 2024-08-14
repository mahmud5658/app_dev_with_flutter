import 'package:authapp/screen/auth/login.dart';
import 'package:authapp/utils/utils.dart';
import 'package:authapp/widgets/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _registrationInProgress = false;

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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Sign Up'),
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
              visible: _registrationInProgress == false,
              replacement: const Center(
                child: CircularProgressIndicator(),
              ),
              child: RoundButton(
                title: 'Sign Up',
                onTap: () async {
                  await _registration();
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
                  text: "have an account?",
                  children: [
                    TextSpan(
                        style: const TextStyle(
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.4),
                        text: 'Log In',
                        recognizer: TapGestureRecognizer()
                          ..onTap = _onTapSignUpButton)
                  ]),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _registration() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _registrationInProgress = true;
      });
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailController.text.toString().trim(),
            password: _passwordController.text.toString());

        Utils.toastMessage('Registration completed');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Utils.toastMessage('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          Utils.toastMessage('The account already exists for that email.');
        }
      } catch (e) {
        Utils.toastMessage(e.toString());
      }
    }
    setState(() {
      _registrationInProgress = false;
    });
  }

  void _onTapSignUpButton() {
    if (mounted) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    }
  }
}
