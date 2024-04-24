import 'package:flutter/material.dart';

class FractionalSizedWidget extends StatelessWidget {
  const FractionalSizedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fractional Sized Box"),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: FractionallySizedBox(
          widthFactor: .3,
          heightFactor: .5,
          child: Container(
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}