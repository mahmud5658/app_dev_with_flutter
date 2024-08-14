import 'package:authapp/firebase_services/splash_services.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  SplashServices splashServices = SplashServices();

  @override
  void initState() {
    super.initState();
    splashServices.isLogin(context);
    // _moveToLoginScreen();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Firebase Practice'),
      ),
    );
  }

  // Future<void> _moveToLoginScreen() async {
  //   await Future.delayed(const Duration(seconds: 5));
  //   if (mounted) {
  //     Navigator.push(context,
  //         MaterialPageRoute(builder: (context) => const LoginScreen()));
  //   }
  // }
}
