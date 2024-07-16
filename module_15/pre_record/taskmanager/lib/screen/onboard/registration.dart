import 'package:flutter/material.dart';
import 'package:taskmanager/api/api_client.dart';
import 'package:taskmanager/style/style.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  Map<String, String> formValues = {
    "email": '',
    'firstName': '',
    'lastName': '',
    'mobile': '',
    'password': '',
    'photo': '',
    'cpassword': ''
  };

  bool loading = false;

  inputOnChange(mapKey, textValue) {
    setState(() {
      formValues.update(mapKey, (value) => textValue);
    });
  }

  formOnSubmit() async {
    if (formValues['email']!.isEmpty) {
      errorToast('Email Required!');
    } else if (formValues['firstName']!.isEmpty) {
      errorToast('First Name Required!');
    } else if (formValues['lastName']!.isEmpty) {
      errorToast('Last Name Required!');
    } else if (formValues['mobile']!.isEmpty) {
      errorToast('Mobile number required!');
    } else if (formValues['password']!.isEmpty) {
      errorToast('password Required!');
    } else if (formValues['cpassword']!=formValues['password']) {
      errorToast('password and confirm password should be same!');
    } 
    else {
      // Data Rest API
      setState(() {
        loading = true;
      });
      bool response = await registrationRequest(formValues);
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
          SingleChildScrollView(
            child: loading?const Center(
              child:  CircularProgressIndicator(
                color: colorGreen,
              ),
            ):
            Container(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Join with us',
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
                          decoration: appInputDecoration('First Name'),
                          onChanged: (textValue) {
                            inputOnChange('firstName', textValue);
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          decoration: appInputDecoration('Last Name'),
                          onChanged: (textValue) {
                            inputOnChange('lastName', textValue);
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          decoration: appInputDecoration('Mobile'),
                          onChanged: (textValue) {
                            inputOnChange('mobile', textValue);
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
                        TextFormField(
                          decoration: appInputDecoration('Confirm Password'),
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
                            child: successButtonChild('Registration'))
                      ],
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
