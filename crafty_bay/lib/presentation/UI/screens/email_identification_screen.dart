import 'package:crafty_bay/presentation/UI/screens/pin_verification_screen.dart';
import 'package:crafty_bay/presentation/UI/widgets/bottom_popup_message.dart';
import 'package:crafty_bay/presentation/UI/widgets/button_loading_indicator.dart';
import 'package:crafty_bay/presentation/UI/widgets/loading_indicator.dart';
import 'package:crafty_bay/presentation/utils/input_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/state_holders/login_controller.dart';
import '../widgets/app_logo.dart';

class EmailIdentificationScreen extends StatefulWidget {
  const EmailIdentificationScreen({super.key});

  @override
  State<EmailIdentificationScreen> createState() =>
      _EmailIdentificationScreenState();
}

class _EmailIdentificationScreenState extends State<EmailIdentificationScreen> {
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
                  'Let\'s sign you in',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'Please enter your email address',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _tECEmail,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String? i) {
                    if (i != null) {
                      if (i.trim().isEmpty) {
                        return 'An email address is require to proceed!';
                      } else if (InputValidator.emailValidator.hasMatch(i) ==
                          false) {
                        return 'Kindly enter a valid email address!';
                      }
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(hintText: 'Email Address'),
                ),
                const SizedBox(
                  height: 15,
                ),
                GetBuilder<LoginController>(
                  builder: (controller) {
                    return Visibility(
                      visible: !controller.loading,
                      replacement: const ButtonLoadingIndicator(),
                      child: ElevatedButton(
                        onPressed: () async{
                          if (_theKey.currentState!.validate()) {
                            bool logInSuccess = await controller.logIn(email: _tECEmail.text);
                            if(logInSuccess){
                              bottomPopUpMessage(context, controller.serverMessage);
                              Get.off(() => PinVerificationScreen(email: _tECEmail.text,));
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    _tECEmail.dispose();
    super.dispose();
  }

  //---------------------------------------Functions---------------------------------------

  //---------------------------------------Variables----------------------------------------
  final GlobalKey<FormState> _theKey = GlobalKey<FormState>();
  final TextEditingController _tECEmail = TextEditingController();
}
