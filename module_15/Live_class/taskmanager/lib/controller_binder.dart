import 'package:get/get.dart';
import 'package:taskmanager/ui/controller/add_new_task_controller.dart';
import 'package:taskmanager/ui/controller/cancel_task_controller.dart';
import 'package:taskmanager/ui/controller/complete_task_controller.dart';
import 'package:taskmanager/ui/controller/email_verification_controller.dart';
import 'package:taskmanager/ui/controller/in_progress_task_controller.dart';
import 'package:taskmanager/ui/controller/new_task_controller.dart';
import 'package:taskmanager/ui/controller/pin_verification_controller.dart';
import 'package:taskmanager/ui/controller/reset_password_controller.dart';
import 'package:taskmanager/ui/controller/sign_in_controller.dart';
import 'package:taskmanager/ui/controller/sign_up_controller.dart';
import 'package:taskmanager/ui/controller/update_profile_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignInController());
    Get.lazyPut(() => SignUpController());
    Get.lazyPut(() => EmailVerificationController());
    Get.lazyPut(() => PinVerificationController());
    Get.lazyPut(() => ResetPasswordController());
    Get.lazyPut(() => AddNewTaskController());
    Get.lazyPut(() => CancelTaskController());
    Get.lazyPut(() => CompleteTaskController());
    Get.lazyPut(() => InProgressTaskController());
    Get.lazyPut(() => NewTaskController());
     Get.lazyPut(() => UpdateProfileController());
  }
}
