import 'package:flutter/material.dart';
import 'package:taskmanager/style/style.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
        return Scaffold(
      body: Stack(
        children: [
          screenBackground(context),
          Container(
            padding: const EdgeInsets.all(30),
            child: SingleChildScrollView(
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
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                      TextFormField(
                    decoration: appInputDecoration('First Name'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                      TextFormField(
                    decoration: appInputDecoration('Last Name'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                      TextFormField(
                    decoration: appInputDecoration('Mobile'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: appInputDecoration('Password'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                      TextFormField(
                    decoration: appInputDecoration('Confirm Password'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      style: appButtonStyle(),
                      onPressed: () {},
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