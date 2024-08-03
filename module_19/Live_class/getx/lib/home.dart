import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/counter_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CounterController _counterController = Get.put(CounterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter Application'),
      ),
      body: Center(
          child: Column(
        children: [
          // Obx(() {
          //   return Text('Counter Value: ${_counterController.count}');
          // }),
          GetBuilder<CounterController>(builder: (counterController) {
            return Text('Counter Value: ${counterController.count}');
          })
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: _counterController.increment,
        child: const Icon(Icons.add),
      ),
    );
  }
}
