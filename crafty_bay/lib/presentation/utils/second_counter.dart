import 'package:get/get.dart';

class SecondCounter extends GetxController {
  late int remainingSecond;

  Future<void> setAndDecreaseTime() async {
    for (remainingSecond = 300; remainingSecond > 0;) {
      await Future.delayed(const Duration(seconds: 1));
      remainingSecond--;
      update();
    }
  }
}
