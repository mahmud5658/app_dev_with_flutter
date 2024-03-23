import 'dart:io';

void printSegments(int l1, int r1, int l2, int r2) {
  for (int i = l1; i < l2; i++) {
    stdout.write('$i ');
  }

  for (int i = r2 + 1; i <= r1; i++) {
    stdout.write('$i ');
  }
}

void main() {
  List<String> input = stdin.readLineSync()!.split(' ');
  int l1 = int.parse(input[0]);
  int r1 = int.parse(input[1]);
  int l2 = int.parse(input[2]);
  int r2 = int.parse(input[3]);

  printSegments(l1, r1, l2, r2);
}
