import 'package:flutter/material.dart';
import 'package:taskmanager/style/style.dart';

class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen({super.key});

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
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
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: appInputDecoration('Confirm password'),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    style: appButtonStyle(),
                    onPressed: () {},
                    child: successButtonChild('Confirm'))
              ],
            ),
          )
        ],
      ),
    );
  }
}