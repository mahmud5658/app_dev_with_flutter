import 'dart:io';

void main() {

  int imageWidth = int.parse(stdin.readLineSync()!);


  int containerWidth = 1000;


  int remainingSpace = containerWidth - imageWidth;

  
  int leftMargin = remainingSpace ~/ 2;


  if(leftMargin>0){
    print(leftMargin);
  }else{
    print(0);
  }
}
