

import 'package:flutter/material.dart';

class AspectRatioWidget extends StatelessWidget {
  const AspectRatioWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Aspect Ratio Widget"),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        width: double.infinity,
        height: 300,
        color: Colors.red,
        alignment: Alignment.center,
        child: AspectRatio(aspectRatio: 16 / 9, child: Container(
          color: Colors.yellow,
        )),
      ),
    );
  }
}
