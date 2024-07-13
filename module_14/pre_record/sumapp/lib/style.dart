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

TextStyle headLineStyle() {
  return TextStyle(fontSize: 24, fontWeight: FontWeight.w800);
}

ButtonStyle buttonStyle() {
  return ElevatedButton.styleFrom(
    padding: EdgeInsets.all(12),
    backgroundColor: Colors.green,
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4),
    )
  );
}
