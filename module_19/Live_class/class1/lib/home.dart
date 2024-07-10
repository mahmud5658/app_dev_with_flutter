import 'package:class1/counter_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  final CounterController _counterController = Get.put(CounterController());
  int counterValue = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Obx(
            //   () => Text(
            //       'Counter Values:${_counterController.count}',
            //       style: const TextStyle(
            //           fontSize: 30, fontWeight: FontWeight.bold),
            //     ),
            // )
            GetBuilder<CounterController>(builder: (counterController) {
              return Text(
                'Counter Values:${_counterController.count}',
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              );
            })
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _counterController.increment,
        child: const Icon(Icons.add),
      ),
    );
  }
}
