import 'package:calculator/utility/button_values.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String number1 = '';
  String operand = '';
  String number2 = '';
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                reverse: true,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  alignment: Alignment.bottomRight,
                  child: Text(
                    '$number1$operand$number2'.isEmpty
                        ? '0'
                        : '$number1$operand$number2',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 48,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
            ),
            Wrap(
                children: Button.buttonValues
                    .map(
                      (value) => SizedBox(
                        width: value == Button.n0
                            ? screenSize.width / 2
                            : (screenSize.width / 4),
                        height: screenSize.height / 8,
                        child: buildButton(value),
                      ),
                    )
                    .toList())
          ],
        ),
      ),
    );
  }

  Widget buildButton(value) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Material(
        color: getButtonColor(value),
        clipBehavior: Clip.hardEdge,
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: const BorderSide(color: Colors.white24)),
        child: InkWell(
            onTap: () => onBtnTap(value),
            child: Center(
                child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ))),
      ),
    );
  }

  void onBtnTap(String value) {
    if (value == Button.del) {
      delete();
      return;
    }
    if (value == Button.clr) {
      clearAll();
    }
    if (value == Button.per) {
      convertToPercentage();
    }
    if (value == Button.calculate) {
      calculate();
    }
    appendValue(value);
  }

  void calculate() {
    if (number1.isEmpty) return;
    if (operand.isEmpty) return;
    if (number2.isEmpty) return;
    final double num1 = double.parse(number1);
    final double num2 = double.parse(number2);
    var result = 0.0;
    switch (operand) {
      case Button.add:
        result = num1 + num2;
        break;
      case Button.subtract:
        result = num1 - num2;
        break;
      case Button.multiply:
        result = num1 * num2;
        break;
      case Button.divide:
        result = num1 / num2;
        break;
    }
    setState(() {
      number1 = result.toStringAsPrecision(3);
      if (number1.endsWith('.0')) {
        number1 = number1.substring(0, number1.length - 2);
      }
      operand = '';
      number2 = '';
    });
  }

  void convertToPercentage() {
    if (number1.isNotEmpty && operand.isNotEmpty && number2.isNotEmpty) {
      calculate();
    }
    if (operand.isNotEmpty) {
      return;
    }
    final number = double.parse(number1);
    setState(() {
      number1 = '${(number / 1000)}';
      operand = '';
      number2 = '';
    });
  }

  void clearAll() {
    number1 = '';
    operand = '';
    number2 = '';
    setState(() {});
  }

  void delete() {
    if (number2.isNotEmpty) {
      number2 = number2.substring(0, number2.length - 1);
    } else if (operand.isNotEmpty) {
      operand = '';
    } else if (number1.isNotEmpty) {
      number1 = number1.substring(0, number1.length - 1);
    }
    setState(() {});
  }

  void appendValue(value) {
    if (value != Button.dot && int.tryParse(value) == null) {
      if (operand.isNotEmpty && number2.isNotEmpty) {
        calculate();
      }
      operand = value;
    } else if (number1.isEmpty || operand.isEmpty) {
      if (value == Button.dot && number1.contains(Button.dot)) {
        return;
      }
      if (value == Button.dot && (number1.isEmpty || number1 == Button.dot)) {
        value = '0.';
      }
      number1 += value;
    } else if (number2.isEmpty || operand.isNotEmpty) {
      if (value == Button.dot && number2.contains(Button.dot)) {
        return;
      }
      if (value == Button.dot && (number2.isEmpty || number2 == Button.dot)) {
        value = '0.';
      }
      number2 += value;
    }
    setState(() {});
  }

  Color getButtonColor(value) {
    return [Button.del, Button.clr].contains(value)
        ? Colors.blueGrey
        : [
            Button.per,
            Button.multiply,
            Button.add,
            Button.subtract,
            Button.divide,
            Button.calculate
          ].contains(value)
            ? Colors.orange
            : Colors.black87;
  }
}
