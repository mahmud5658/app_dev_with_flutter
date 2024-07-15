import 'package:flutter/material.dart';
import 'package:taskmanager/style/style.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                Text('Get Started with',style: head1Text(colorDarkBlue),),
                const SizedBox(height: 1,),
                Text('',style: head6Text(colorLightGray),),
                 const SizedBox(
                  height: 20,
                ),
                TextFormField(decoration: appInputDecoration('Email Address'),),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: appInputDecoration('Password'),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: appButtonStyle(),
                  onPressed: (){}, child: successButtonChild('Login'))
              ],
            ),
          )
        ],
      ),
    );
  }
}
