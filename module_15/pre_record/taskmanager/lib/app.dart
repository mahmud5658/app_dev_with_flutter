import 'package:flutter/material.dart';
import 'package:taskmanager/screen/onboard/email_varification.dart';
import 'package:taskmanager/screen/onboard/login.dart';
import 'package:taskmanager/screen/onboard/pin_verification.dart';
import 'package:taskmanager/screen/onboard/registration.dart';
import 'package:taskmanager/screen/onboard/set_password.dart';
import 'package:taskmanager/screen/task/home.dart';


class TaskManager extends StatelessWidget {
  final String firstRoute;
    const TaskManager( {super.key, required this.firstRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Manager',
      initialRoute: firstRoute,
      routes: {
        '/': (context) => const HomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/registration': (context) => const RegistrationScreen(),
        '/email_verification': (context) => const EmailVerificationScreen(),
        '/pin_verification': (context) => const PinVerificationScreen(),
        '/set_password': (context) => const SetPasswordScreen(),
      },
    );
  }
}
