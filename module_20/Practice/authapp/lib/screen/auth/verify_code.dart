import 'package:authapp/screen/posts/post_screen.dart';
import 'package:authapp/utils/utils.dart';
import 'package:authapp/widgets/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyScreen extends StatefulWidget {
  final String verificationId;
  const VerifyScreen({super.key, required this.verificationId});

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  String _pinCode = '';
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            PinCodeTextField(
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
                selectedColor: Colors.deepPurple,
              ),
              animationDuration: const Duration(milliseconds: 300),
              backgroundColor: Colors.transparent,
              enableActiveFill: true,
              appContext: context,
              onCompleted: (value) {},
              onChanged: (value) {
                if (mounted) {
                  setState(() {
                    _pinCode = value.toString();
                  });
                }
              },
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
                  title: 'Verify',
                  onTap: () async {
                    await _verifyCode();
                  }),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _verifyCode() async {
    setState(() {
      _loading = true;
    });
    final credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: _pinCode);
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      setState(() {
        _loading = false;
      });
      if (mounted) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const PostScreen()));
      }
    } catch (e) {
      Utils.toastMessage(e.toString());
      setState(() {
        _loading = false;
      });
    }
  }
}
