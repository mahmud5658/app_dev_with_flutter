import 'package:get/get.dart';

// class CounterController {
//   RxInt _count = 0.obs;
//   RxInt get count => _count;
//   void increment() {
//     _count++;
//   }

//   void decrement() {
//     if (_count > 0) {
//       _count--;
//     }
//   }
// }

class CounterController extends GetxController {
  int _count = 0;
  int get count => _count;
  void increment() {
    _count++;
    update();
  }

  void decrement() {
    if (_count > 0) {
      _count--;
      update();
    }
  }
}
