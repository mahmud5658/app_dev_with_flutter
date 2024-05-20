
import 'package:flutter/material.dart';

class appBar extends StatelessWidget implements PreferredSizeWidget{
  final String title;
  const appBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title,style: const TextStyle(fontWeight: FontWeight.bold),),
      backgroundColor: const Color.fromRGBO(33, 150, 243, 1),
      foregroundColor: Colors.white,
    );
  }
  @override
  Size get preferredSize => const Size.fromHeight(56);
}
