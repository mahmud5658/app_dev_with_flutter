import 'package:flutter/material.dart';

InputDecoration appInputStyle(String label) {
  return InputDecoration(
    contentPadding: EdgeInsets.fromLTRB(20, 10, 10, 20),
    fillColor: Colors.white,
    filled: true,
    border: OutlineInputBorder(),
    labelText: label,
  );
}

ButtonStyle buttonStyle() {
  return ElevatedButton.styleFrom(
      padding: const EdgeInsets.all(15),
      backgroundColor: Colors.green,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ));
}

SizedBox sizedBox50(child) {
  return SizedBox(
    height: 50,
    width: double.infinity,
    child: Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8),
      child: child,
    ),
  );
}
