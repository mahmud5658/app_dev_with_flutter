import 'package:authapp/screen/auth/verify_code.dart';
import 'package:authapp/utils/utils.dart';
import 'package:authapp/widgets/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginWithPhoneScreen extends StatefulWidget {
  const LoginWithPhoneScreen({super.key});

  @override
  State<LoginWithPhoneScreen> createState() => _LoginWithPhoneScreenState();
}

class _LoginWithPhoneScreenState extends State<LoginWithPhoneScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            TextFormField(
              controller: _phoneNumberController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter your phone number'),
            ),
            const SizedBox(
              height: 30,
            ),
            Visibility(
              visible: _loading == false,
              replacement: const Center(
                child: CircularProgressIndicator(),
              ),
              child: RoundButton(
                  title: 'Login',
                  onTap: () async {
                    await _loginWithPhone(context);
                  }),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _loginWithPhone(BuildContext context) async {
    setState(() {
      _loading = true;
    });
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: _phoneNumberController.text.trim().toString(),
        verificationCompleted: (_) {
          setState(() {
            _loading = false;
          });
        },
        verificationFailed: (e) {
          Utils.toastMessage(e.code.toString());
          setState(() {
            _loading = false;
          });
        },
        codeSent: (String verificationId, int? token) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => VerifyScreen(
                        verificationId: verificationId,
                      )));
          setState(() {
            _loading = false;
          });
        },
        codeAutoRetrievalTimeout: (e) {
          Utils.toastMessage(e.toString());
          setState(() {
            _loading = false;
          });
        });
  }
}
