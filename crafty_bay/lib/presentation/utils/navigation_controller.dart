import 'package:get/get.dart';

class NavigationController extends GetxController{
  int _currentIndex=0;
  int get currentIndex => _currentIndex;
  void selectIndex(int i){
    _currentIndex = i;
    update();
  }
  void goToCategoryScreen(){
    _currentIndex = 1;
    update();
  }
  void goToHomeScreen(){
    _currentIndex = 0;
    update();
  }
}