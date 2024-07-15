import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:taskmanager/style/style.dart';

class PinVerificationScreen extends StatefulWidget {
  const PinVerificationScreen({super.key});

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
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
                  'PIN Verification',
                  style: head1Text(colorDarkBlue),
                ),
                const SizedBox(
                  height: 1,
                ),
                Text(
                  'A 6 digit pin verification send to your phone number ',
                  style: head6Text(colorLightGray),
                ),
                const SizedBox(
                  height: 20,
                ),
                PinCodeTextField(appContext: context, length: 6,
                pinTheme: appOTPStyle(),
                animationType: AnimationType.fade,
                animationDuration:const  Duration(milliseconds: 300),
                enableActiveFill: true,
                onCompleted: (v){
                },
                onChanged: (value){
                },
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    style: appButtonStyle(),
                    onPressed: () {},
                    child: successButtonChild('Verify'))
              ],
            ),
          )
        ],
      ),
    );
  }
}