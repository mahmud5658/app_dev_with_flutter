import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _secondEditingController =
      TextEditingController();
  final TextEditingController _firstEditingController = TextEditingController();

  double _result = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            TextField(
              keyboardType: TextInputType.number,
              controller: _firstEditingController,
              decoration: const InputDecoration(labelText: 'First number'),
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: _secondEditingController,
              decoration: const InputDecoration(labelText: 'Second number'),
            ),
            const SizedBox(
              height: 15,
            ),
            Wrap(
              spacing: 16,
              alignment: WrapAlignment.center,
              children: [
                ElevatedButton.icon(
                    onPressed: _add,
                    icon: const Icon(Icons.add),
                    label: const Text('Add')),
                ElevatedButton.icon(
                    onPressed: () {
                      _sub();
                    },
                    icon: const Icon(Icons.remove),
                    label: const Text('Sub')),
                ElevatedButton.icon(
                    onPressed: _multiply,
                    icon: const Icon(Icons.star_border),
                    label: const Text('Multiply')),
                ElevatedButton.icon(
                    onPressed: _divide,
                    icon: const Icon(Icons.ac_unit_outlined),
                    label: const Text('Division')),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Text('Result: $_result')
          ],
        ),
      ),
    );
  }

  void _add() {
    double num1 = double.tryParse(_firstEditingController.text) ?? 0;
    double num2 = double.tryParse(_secondEditingController.text) ?? 0;

    _result = num1 + num2;
    setState(() {});
  }

  void _sub() {
    double num1 = double.tryParse(_firstEditingController.text) ?? 0;
    double num2 = double.tryParse(_secondEditingController.text) ?? 0;

    _result = num1 - num2;
    setState(() {});
  }

  void _multiply() {
    double num1 = double.tryParse(_firstEditingController.text) ?? 0;
    double num2 = double.tryParse(_secondEditingController.text) ?? 0;

    _result = num1 * num2;
    setState(() {});
  }

  void _divide() {
    double num1 = double.tryParse(_firstEditingController.text) ?? 0;
    double num2 = double.tryParse(_secondEditingController.text) ?? 0;

    _result = num1 / num2;
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _firstEditingController.dispose();
    _secondEditingController.dispose();
  }
}
