import 'package:crafty_bay/data/state_holders/login_controller.dart';
import 'package:crafty_bay/data/state_holders/pin_verify_controller.dart';
import 'package:crafty_bay/presentation/UI/screens/set_profile.dart';
import 'package:crafty_bay/presentation/UI/widgets/bottom_popup_message.dart';
import 'package:crafty_bay/presentation/UI/widgets/button_loading_indicator.dart';
import 'package:crafty_bay/presentation/utils/second_counter.dart';
import 'package:crafty_bay/presentation/utils/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../widgets/app_logo.dart';

class PinVerificationScreen extends StatefulWidget {
  const PinVerificationScreen({super.key, required this.email});
  final String email;

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<SecondCounter>().setAndDecreaseTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.sizeOf(context).height / 5,
              left: 26,
              right: 26,
              bottom: 26),
          child: Form(
            key: _theKey,
            child: Column(
              children: [
                const AppLogo(logoSize: 110),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Enter the OTP code',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'A 6 digit OTP code has been sent',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(
                  height: 20,
                ),
                PinCodeTextField(
                  controller: _tECOtp,
                  autovalidateMode: AutovalidateMode.disabled,
                  validator: (String? i) {
                    if (i != null) {
                      if (i.trim().length < 6) {
                        return 'Enter the OTP to proceed!';
                      }
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  length: 6,
                  obscureText: true,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(3),
                      fieldHeight: 40,
                      fieldWidth: 30,
                      activeFillColor: Colors.white,
                      activeColor: Colors.green,
                      inactiveFillColor: Colors.white,
                      inactiveColor: ThemeColor.accentColor,
                      selectedColor: const Color(0XFFFE9900),
                      selectedFillColor: Colors.white),
                  animationDuration: const Duration(milliseconds: 300),
                  backgroundColor: Colors.transparent,
                  enableActiveFill: true,
                  onCompleted: (v) {},
                  appContext: context,
                ),
                GetBuilder<PinVerifyController>(
                  builder: (controller) {
                    return Visibility(
                      visible: !controller.loading,
                      replacement: const ButtonLoadingIndicator(),
                      child: ElevatedButton(
                        onPressed: () async{
                          if (_theKey.currentState!.validate()) {
                            bool verificationSuccess = await controller.verify(email: widget.email, oTP: _tECOtp.text);
                            if(verificationSuccess){
                              bottomPopUpMessage(context, controller.serverMessage);
                              bool profileExist = controller.profileExist;
                              if(profileExist){
                                Get.back();
                              }else{
                                _navigateToSetProfileScreen();
                              }
                            }else{
                              bottomPopUpMessage(context, controller.errorMessage??'Something went wrong', showError: true);
                            }
                          }
                        },
                        child: Text(
                          'Next',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.white, fontWeight: FontWeight.w400),
                        ),
                      ),
                    );
                  }
                ),
                const SizedBox(
                  height: 15,
                ),
                GetBuilder<SecondCounter>(builder: (time) {
                  return RichText(
                    text: TextSpan(
                        text: ('This code will expire in'),
                        style: Theme.of(context).textTheme.bodySmall,
                        children: [
                          TextSpan(
                            text: ' ${time.remainingSecond}s',
                            style: _dynamicTextStyleCounter(),
                          )
                        ]),
                  );
                }),
                GetBuilder<LoginController>(
                  builder: (controller) {
                    return Visibility(
                      visible: !controller.loading,
                      replacement: const ButtonLoadingIndicator(),
                      child: TextButton(
                        onPressed: _resentOTP,
                        child: Text(
                          'Resend Code',
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Get.find<SecondCounter>().remainingSecond <= 0
                                  ? ThemeColor.accentColor
                                  : Colors.grey),
                        ),
                      ),
                    );
                  }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //---------------------------------------Functions---------------------------------------
  void _navigateToSetProfileScreen() {
    Get.off(() =>  const SetProfile(heading: 'Complete profile',readProfileData: null,));
  }

  TextStyle? _dynamicTextStyleCounter() {
    if (Get.find<SecondCounter>().remainingSecond <= 100 &&
        Get.find<SecondCounter>().remainingSecond > 30) {
      _refreshScreen();
      return const TextStyle(color: Colors.green);
    } else if (Get.find<SecondCounter>().remainingSecond <= 30 &&
        Get.find<SecondCounter>().remainingSecond > 10) {
      _refreshScreen();
      return const TextStyle(color: Colors.orange);
    } else if (Get.find<SecondCounter>().remainingSecond <= 10) {
      _refreshScreen();
      return const TextStyle(color: Colors.red);
    } else {
      _refreshScreen();
      return const TextStyle(color: ThemeColor.accentColor);
    }
  }

  Future<void> _refreshScreen() async {
    await Future.delayed(const Duration(microseconds: 10));
    setState(() {});
  }

  void _resentOTP() async{
    if (Get.find<SecondCounter>().remainingSecond <= 0) {
      bool logInSuccess = await Get.find<LoginController>().logIn(email: widget.email);
      if(logInSuccess){
        Get.find<SecondCounter>().setAndDecreaseTime();
        bottomPopUpMessage(context, Get.find<LoginController>().serverMessage);
      }else{
        bottomPopUpMessage(context, Get.find<LoginController>().errorMessage??'Something went wrong', showError: true);
      }
    }
  }

  //---------------------------------------Variables----------------------------------------
  final GlobalKey<FormState> _theKey = GlobalKey<FormState>();
  final TextEditingController _tECOtp = TextEditingController();
}
