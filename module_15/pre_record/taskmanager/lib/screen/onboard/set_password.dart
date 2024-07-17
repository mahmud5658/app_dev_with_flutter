import 'package:flutter/material.dart';
import 'package:taskmanager/api/api_client.dart';
import 'package:taskmanager/style/style.dart';
import 'package:taskmanager/utility/utility.dart';

class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen({super.key});

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  Map<String, String> formValues = {
    "email": "",
    "OTP": "",
    "password": "",
    "cpassword": ""
  };
  bool loading = false;
  @override
  void initState() {
    callData();
    super.initState();
  }

  void callData() async {
    String? otp = await readUserData('otpVerification');
    String? email = await readUserData('emailVerification');
    inputOnChange('OTP', otp);
    inputOnChange('email', email);
  }

  inputOnChange(mapKey, textValue) {
    setState(() {
      formValues.update(mapKey, (value) => textValue);
    });
  }

  formOnSubmit() async {
    if (formValues['password']!.isEmpty) {
      errorToast('Password Required!');
    } else if (formValues['password'] != formValues['cpassword']) {
      errorToast('Confirm password should be same!');
    } else {
      setState(() {
        loading = true;
      });
      bool response = await setPasswordRequest(formValues);
      if (response == true) {
        //navigate to dashboard page
        Navigator.pushNamedAndRemoveUntil(
            // ignore: use_build_context_synchronously
            context,
            '/login',
            (route) => false);
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
            child: loading
                ? const CircularProgressIndicator(
                    color: colorGreen,
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Set Password',
                        style: head1Text(colorDarkBlue),
                      ),
                      const SizedBox(
                        height: 1,
                      ),
                      Text(
                        'Minimum length password 8 character with Letter and number combination',
                        style: head6Text(colorLightGray),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: appInputDecoration('Password'),
                        onChanged: (textValue) {
                          inputOnChange('password', textValue);
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: appInputDecoration('Confirm password'),
                        onChanged: (textValue) {
                          inputOnChange('cpassword', textValue);
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
                          child: successButtonChild('Confirm'))
                    ],
                  ),
          )
        ],
      ),
    );
  }
}
