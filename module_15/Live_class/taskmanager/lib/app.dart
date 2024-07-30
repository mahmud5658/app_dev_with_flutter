import 'package:flutter/material.dart';
import 'package:taskmanager/ui/screen/auth/splash_screen.dart';
import 'package:taskmanager/ui/utility/color.dart';

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightThemeData(),
      home: const SplashScreen(),
    );
  }
}

ThemeData lightThemeData() {
  return ThemeData(
    inputDecorationTheme: const InputDecorationTheme(
      fillColor: Colors.white,
      filled: true,
      border: OutlineInputBorder(borderSide: BorderSide.none),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.themeColor,
        padding: const EdgeInsets.symmetric(vertical: 15),
        foregroundColor: AppColor.white,
        fixedSize: const Size.fromWidth(double.maxFinite),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
          fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black),
          titleSmall: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey)
    ),

    textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: Colors.grey,
      textStyle: const TextStyle(fontWeight: FontWeight.w500,letterSpacing: 0.4)

    )
    )
  );
}
