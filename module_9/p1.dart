import 'dart:io';

void suggestOutfit() {

  String dressCode = stdin.readLineSync()!.trim();
  int temperature = int.parse(stdin.readLineSync()!.trim());

  if (dressCode == "casual") {
    if (temperature >= 15 && temperature <= 25) {
      print("Jeans and a light jacket.");
    } else {
      print("Wear what you're comfortable in.");
    }
  } else if (dressCode == "festive") {
    if (temperature > 25) {
      print("Colorful dress and sandals.");
    } else {
      print("Wear what you're comfortable in.");
    }
  }
}
void main() {
  suggestOutfit();
}
