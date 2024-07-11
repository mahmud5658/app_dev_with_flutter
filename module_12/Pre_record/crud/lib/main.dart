import 'package:crud/screen/product_create.dart';
import 'package:flutter/material.dart';

import 'screen/product_grid_view.dart';

void main() {
  runApp(const CrudApp());
}

class CrudApp extends StatelessWidget {
  const CrudApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Crud Application',
      home: ProductGridViewScreen(),
    );
  }
}
