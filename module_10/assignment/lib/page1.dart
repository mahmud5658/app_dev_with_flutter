import 'package:flutter/material.dart';

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Photo Gallery",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        leading: Container(
          margin: const EdgeInsets.all(8),
          height: 40,
          width: 40,
          decoration: BoxDecoration(
              color: Colors.white38, borderRadius: BorderRadius.circular(10)),
          child: const Center(
            child: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            ),
          ),
        ),
        actions: const [
          Icon(
            Icons.more_vert,
            color: Colors.white,
          )
        ],
      ),
    );
  }
}
