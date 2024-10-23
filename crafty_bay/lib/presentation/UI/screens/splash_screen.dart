import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/app_logo.dart';
import 'bottom_navigation_widgets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToEmailScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              const AppLogo(logoSize: 130),
              const Spacer(),
              const SizedBox(
                height: 28,
                width: 28,
                child: CircularProgressIndicator(),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Version 1.0.0',
                style: Theme.of(context).textTheme.labelSmall,
              )
            ],
          ),
        ),
      ),
    );
  }

  //---------------------------------------Functions---------------------------------------
  Future<void> _navigateToEmailScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    //Get.off(()=>const EmailIdentificationScreen());
    Get.off(() => BottomNavigationWidgets());
  }
}
