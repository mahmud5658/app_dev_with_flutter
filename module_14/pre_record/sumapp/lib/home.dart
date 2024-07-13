import 'package:flutter/material.dart';
import 'package:sumapp/style.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, double> formValue = {"num1": 0, "num2": 0};
  double result = 0;
  @override
  Widget build(BuildContext context) {
    inputOnChange(inputKey, inputValue) {
      setState(() {
        formValue.update(inputKey, (value) => double.parse(inputValue));
      });
    }

    addAllNumber() {
      setState(() {
        result = formValue['num1']! + formValue['num2']!;
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Sum Application'),
      ),
      body: Padding(
        padding: EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Sum = $result',
              style: headLineStyle(),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: appInputStyle('First Number'),
              onChanged: (value) {
                inputOnChange('num1', value);
              },
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: appInputStyle('Second Number'),
              onChanged: (value) {
                inputOnChange('num2', value);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                  style: buttonStyle(),
                  onPressed: () {
                    addAllNumber();
                  },
                  child: const Text('Add')),
            )
          ],
        ),
      ),
    );
  }
}
