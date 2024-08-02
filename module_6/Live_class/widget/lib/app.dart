import 'package:flutter/material.dart';
import 'package:widget/widget/column.dart';
import 'package:widget/widget/text.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ColumnWidget(),
    );

  }
}
