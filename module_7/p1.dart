import 'dart:io';

int calculateTablePosition(int screenWidth) {
  int tableWidth = 300;
  int leftMargin = (screenWidth - tableWidth) ~/ 2;
  return leftMargin;
}

void main() {

  int screenWidth = int.parse(stdin.readLineSync()!);
  print(calculateTablePosition(screenWidth));
}
