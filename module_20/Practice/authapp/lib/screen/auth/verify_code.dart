import 'package:authapp/utils/utils.dart';
import 'package:authapp/widgets/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyScreen extends StatefulWidget {
  final String verificationId;
  const VerifyScreen({super.key, required this.verificationId});

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
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
                  title: 'Verify',
                  onTap: () async {
                    await _verifyCode(context);
                  }),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _verifyCode(BuildContext context) async {

  }
}

