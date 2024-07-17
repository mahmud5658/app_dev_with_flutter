import 'package:flutter/material.dart';
import 'package:taskmanager/api/api_client.dart';
import 'package:taskmanager/style/style.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  Map<String, String> formValues = {"email":''};

  bool loading = false;

  inputOnChange(mapKey, textValue) {
    setState(() {
      formValues.update(mapKey, (value) => textValue);
    });
  }

  formOnSubmit() async {
    if (formValues['email']!.isEmpty) {
      errorToast('Email Required!');
    } else {
      // Data Rest API
      setState(() {
        loading = true;
      });
      bool response = await verifyEmailRequest(formValues['email']);
      if (response == true) {
        //navigate to dashboard page
        Navigator.pushNamed(
            // ignore: use_build_context_synchronously
            context,
            '/pin_verification');
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
            alignment: Alignment.center,
            padding: const EdgeInsets.all(30),
            child: loading? const CircularProgressIndicator(
              color: colorGreen,
            ):SingleChildScrollView(
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
                  onChanged: (textValue) {
                    inputOnChange('email', textValue);
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
                    child: successButtonChild('Next'))
              ],
            ),
            )
          )
        ],
      ),
    );
  }
}
