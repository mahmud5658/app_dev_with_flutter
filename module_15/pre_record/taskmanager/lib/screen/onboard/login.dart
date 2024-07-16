import 'package:flutter/material.dart';
import 'package:taskmanager/api/api_client.dart';
import 'package:taskmanager/style/style.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Map<String, String> formValues = {"email": '', 'password': ''};

  bool loading = false;

  inputOnChange(mapKey, textValue) {
    setState(() {
      formValues.update(mapKey, (value) => textValue);
    });
  }

  formOnSubmit() async {
    if (formValues['email']!.isEmpty) {
      errorToast('Email Required!');
    } else if (formValues['password']!.isEmpty) {
      errorToast('Password Required!');
    } else {
      // Data Rest API
      setState(() {
        loading = true;
      });
      bool response = await loginRequest(formValues);
      // if (response == true) {
      //   //navigate to dashboard page
      // } else {
        
      // }
      setState(() {
          loading = false;
        });
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
                ? Center(child: const CircularProgressIndicator(
                  // backgroundColor: colorGreen,
                  color: colorGreen,
                ))
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Get Started with',
                        style: head1Text(colorDarkBlue),
                      ),
                      const SizedBox(
                        height: 1,
                      ),
                      Text(
                        'Learn with rabbil hasan',
                        style: head6Text(colorLightGray),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: appInputDecoration('Email Address'),
                        onChanged: (textValue) {
                          inputOnChange('email', textValue);
                        },
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
                      ElevatedButton(
                          style: appButtonStyle(),
                          onPressed: () {
                            formOnSubmit();
                          },
                          child: successButtonChild('Login'))
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
