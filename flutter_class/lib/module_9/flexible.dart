import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FlexibleWidget extends StatelessWidget {
  const FlexibleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flexible widget"),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Flexible(
            fit: FlexFit.tight,
            child: Container(
              height: 100,
              width: 100,
              color: Colors.red,
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              // height: 100,
              width: 100,
              color: Colors.purple,
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            child: Container(
                height: 100,
                width: 100,
                color: Colors.green,
              ),
          ),

        ],
      ),
    );
  }
}