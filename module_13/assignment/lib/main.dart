import 'package:crud_app/screens/ProductListScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


void main(){
  runApp(CrudApp());
}

class CrudApp extends StatelessWidget {
  const CrudApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProductListScreen(),
      theme: ThemeData(
          inputDecorationTheme: const InputDecorationTheme(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.purple)
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.purple)
            ),
            errorBorder: OutlineInputBorder(),
            focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red)
            ),
          ),
          elevatedButtonTheme:  ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size.fromWidth(double.maxFinite),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)
                ),
                backgroundColor: Colors.pinkAccent,
                foregroundColor: Colors.white,
              )
          )
      ),
    );
  }
}
