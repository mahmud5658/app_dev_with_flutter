import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/counter_controller.dart';
import 'package:getx/screen/profile.dart';
import 'package:getx/screen/setting.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter Application'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Obx(() {
          //   return Text('Counter Value: ${_counterController.count}');
          // }),
          GetBuilder<CounterController>(builder: (counterController) {
            return Text('Counter Value: ${counterController.count}');
          }),
          TextButton(
              onPressed: () {
                Get.to(() => const ProfileScreen());
              },
              child: const Text('Go to Profile')),
          TextButton(onPressed: () {
            Get.to(() => const SettingScrren());
          }, child: const Text('Go to Settings'))
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: Get.find<CounterController>().increment,
        child: const Icon(Icons.add),
      ),
    );
  }
}
