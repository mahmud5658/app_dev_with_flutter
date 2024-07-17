import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:taskmanager/api/api_client.dart';
import 'package:taskmanager/style/style.dart';
import 'package:taskmanager/utility/utility.dart';

class PinVerificationScreen extends StatefulWidget {
  const PinVerificationScreen({super.key});

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
  Map<String, String> formValues = {"otp": ''};

  bool loading = false;

  inputOnChange(mapKey, textValue) {
    setState(() {
      formValues.update(mapKey, (value) => textValue);
    });
  }

  formOnSubmit() async {
    if (formValues['otp']!.length != 6) {
      errorToast('PIN Required!');
    } else {
      // Data Rest API
      setState(() {
        loading = true;
      });
      String? email = await readUserData('emailVerification');
      bool response = await verifyOtpRequest(email, formValues['otp']);
      if (response == true) {
        //navigate to dashboard page
        Navigator.pushNamed(
            // ignore: use_build_context_synchronously
            context,
            '/set_password');
      } else {
        setState(() {
          loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          screenBackground(context),
          Container(
              padding: const EdgeInsets.all(30),
              alignment: Alignment.center,
              child: loading
                  ? const CircularProgressIndicator(
                      color: colorGreen,
                    )
                  : SingleChildScrollView(
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
                          PinCodeTextField(
                            appContext: context,
                            length: 6,
                            pinTheme: appOTPStyle(),
                            animationType: AnimationType.fade,
                            animationDuration:
                                const Duration(milliseconds: 300),
                            enableActiveFill: true,
                            onCompleted: (v) {},
                            onChanged: (value) {
                              inputOnChange('otp', value);
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                              style: appButtonStyle(),
                              onPressed: () {
                                formOnSubmit();
                              },
                              child: successButtonChild('Verify'))
                        ],
                      ),
                    ))
        ],
      ),
    );
  }
}
