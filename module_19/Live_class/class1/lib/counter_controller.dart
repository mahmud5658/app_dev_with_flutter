// import 'package:get/get.dart';

// class CounterController {
//   RxInt _count = 0.obs;
//   RxInt get count => _count;
//   void increment() {
//     _count++;
//   }

//   void decrement() {
//     _count--;
//   }
// }

import 'package:get/get.dart';

class CounterController extends GetxController {
  int _count = 0;
  int get count => _count;
  void increment() {
    _count++;
    update();
  }

  void decrement() {
    _count--;
    update();
  }
}
