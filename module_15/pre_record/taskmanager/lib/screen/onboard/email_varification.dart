import 'package:flutter/material.dart';
import 'package:taskmanager/style/style.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          screenBackground(context),
          Container(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your Email Address',
                  style: head1Text(colorDarkBlue),
                ),
                const SizedBox(
                  height: 1,
                ),
                Text(
                  'A 6 digit pin verification send to your email address ',
                  style: head6Text(colorLightGray),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: appInputDecoration('Email'),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    style: appButtonStyle(),
                    onPressed: () {},
                    child: successButtonChild('Next'))
              ],
            ),
          )
        ],
      ),
    );
  }
}