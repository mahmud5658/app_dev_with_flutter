import 'dart:io';

void main() {
  String equation = stdin.readLineSync()!.trim();
  
  int firstOperand = int.parse(equation[0]);
  String operator = equation[2];
  int secondOperand = int.parse(equation[4]);
  
  int result;
  switch (operator) {
    case '+':
      result = firstOperand + secondOperand;
      break;
    case '-':
      result = firstOperand - secondOperand;
      break;
    case '*':
      result = firstOperand * secondOperand;
      break;
    case '/':
      result = firstOperand ~/ secondOperand;
      break;
    default:
      print('Invalid operator');
      return;
  }
  
  print(result);
}
