import 'package:get/get.dart';
import 'package:taskmanager/ui/controller/email_verification_controller.dart';
import 'package:taskmanager/ui/controller/sign_in_controller.dart';
import 'package:taskmanager/ui/controller/sign_up_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignInController());
    Get.lazyPut(() => SignUpController());
     Get.lazyPut(() => EmailVerificationController());
  }
}
