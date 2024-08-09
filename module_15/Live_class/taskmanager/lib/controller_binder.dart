import 'package:get/get.dart';
import 'package:taskmanager/ui/controller/sign_in_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignInController());
  }
}
