import 'package:flutter/material.dart';

class LayoutBuilderWidget extends StatelessWidget {
  const LayoutBuilderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Layout Builder"),
        backgroundColor: Colors.blue,
      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 600) {
          return Center(
            child: Container(
              height: 400,
              width: 400,
              color: Colors.red,
            ),
          );
        } else {
          return Center(
            child: Container(
              height: 300,
              width: 300,
              color: Colors.blue,
            ),
          );
        }
      }),
    );
  }
}
